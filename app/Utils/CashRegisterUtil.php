<?php

namespace App\Utils;
use App\TransactionPayment;

use App\CashRegister;
use App\CashRegisterTransaction;
use App\Transaction;

use DB;

class CashRegisterUtil extends Util
{
    /**
     * Returns number of opened Cash Registers for the
     * current logged in user
     *
     * @return int
     */
    public function countOpenedRegister()
    {
        $user_id = auth()->user()->id;
        $count =  CashRegister::where('user_id', $user_id)
                                ->where('status', 'open')
                                ->count();
        return $count;
    }

    /**
     * Adds sell payments to currently opened cash register
     *
     * @param object/int $transaction
     * @param array $payments
     *
     * @return boolean
     */
    public function addSellPayments($transaction, $payments)
    {
        $user_id = auth()->user()->id;
        $register =  CashRegister::where('user_id', $user_id)
                                ->where('status', 'open')
                                ->first();
        $payments_formatted = [];
        foreach ($payments as $payment) {
            $payments_formatted[] = new CashRegisterTransaction([
                    'amount' => (isset($payment['is_return']) && $payment['is_return'] == 1) ? (-1*$this->num_uf($payment['amount'])) : $this->num_uf($payment['amount']),
                    'pay_method' => $payment['method'],
                    'type' => 'credit',
                    'transaction_type' => 'sell',
                    'transaction_id' => $transaction->id
                ]);
        }

        if (!empty($payments_formatted)) {
            $register->cash_register_transactions()->saveMany($payments_formatted);
        }

        return true;
    }

    /**
     * Adds sell payments to currently opened cash register
     *
     * @param object/int $transaction
     * @param array $payments
     *
     * @return boolean
     */
    public function updateSellPayments($status_before, $transaction, $payments)
    {
        $user_id = auth()->user()->id;
        $register =  CashRegister::where('user_id', $user_id)
                                ->where('status', 'open')
                                ->first();
        //If draft -> final then add all
        //If final -> draft then refund all
        //If final -> final then update payments
        if ($status_before == 'draft' && $transaction->status == 'final') {
            $this->addSellPayments($transaction, $payments);
        } elseif ($status_before == 'final' && $transaction->status == 'draft') {
            $this->refundSell($transaction);
        } elseif ($status_before == 'final' && $transaction->status == 'final') {
            $prev_payments = CashRegisterTransaction::where('transaction_id', $transaction->id)
                            ->select(
                                DB::raw("SUM(IF(pay_method='cash', IF(type='credit', amount, -1 * amount), 0)) as total_cash"),
                                DB::raw("SUM(IF(pay_method='card', IF(type='credit', amount, -1 * amount), 0)) as total_card"),
                                DB::raw("SUM(IF(pay_method='cheque', IF(type='credit', amount, -1 * amount), 0)) as total_cheque"),
                                DB::raw("SUM(IF(pay_method='bank_transfer', IF(type='credit', amount, -1 * amount), 0)) as total_bank_transfer"),
                                DB::raw("SUM(IF(pay_method='other', IF(type='credit', amount, -1 * amount), 0)) as total_other"),
                                DB::raw("SUM(IF(pay_method='custom_pay_1', IF(type='credit', amount, -1 * amount), 0)) as total_custom_pay_1"),
                                DB::raw("SUM(IF(pay_method='custom_pay_2', IF(type='credit', amount, -1 * amount), 0)) as total_custom_pay_2"),
                                DB::raw("SUM(IF(pay_method='custom_pay_3', IF(type='credit', amount, -1 * amount), 0)) as total_custom_pay_3")
                            )->first();
            if (!empty($prev_payments)) {
                $payment_diffs = [
                    'cash' => $prev_payments->total_cash,
                    'card' => $prev_payments->total_card,
                    'cheque' => $prev_payments->total_cheque,
                    'bank_transfer' => $prev_payments->total_bank_transfer,
                    'other' => $prev_payments->total_other,
                    'custom_pay_1' => $prev_payments->total_custom_pay_1,
                    'custom_pay_2' => $prev_payments->total_custom_pay_2,
                    'custom_pay_3' => $prev_payments->total_custom_pay_3,
                ];

                foreach ($payments as $payment) {
                    if (isset($payment['is_return']) && $payment['is_return'] == 1) {
                        $payment_diffs[$payment['method']] += $this->num_uf($payment['amount']);
                    } else {
                        $payment_diffs[$payment['method']] -= $this->num_uf($payment['amount']);
                    }
                }
                $payments_formatted = [];
                foreach ($payment_diffs as $key => $value) {
                    if ($value > 0) {
                        $payments_formatted[] = new CashRegisterTransaction([
                            'amount' => $value,
                            'pay_method' => $key,
                            'type' => 'debit',
                            'transaction_type' => 'refund',
                            'transaction_id' => $transaction->id
                        ]);
                    } elseif ($value < 0) {
                        $payments_formatted[] = new CashRegisterTransaction([
                            'amount' => -1 * $value,
                            'pay_method' => $key,
                            'type' => 'credit',
                            'transaction_type' => 'sell',
                            'transaction_id' => $transaction->id
                        ]);
                    }
                }
                if (!empty($payments_formatted)) {
                    $register->cash_register_transactions()->saveMany($payments_formatted);
                }
            }
        }

        return true;
    }

    /**
     * Refunds all payments of a sell
     *
     * @param object/int $transaction
     *
     * @return boolean
     */
    public function refundSell($transaction)
    {
        $user_id = auth()->user()->id;
        $register =  CashRegister::where('user_id', $user_id)
                                ->where('status', 'open')
                                ->first();

        $total_payment = CashRegisterTransaction::where('transaction_id', $transaction->id)
                            ->select(
                                DB::raw("SUM(IF(pay_method='cash', IF(type='credit', amount, -1 * amount), 0)) as total_cash"),
                                DB::raw("SUM(IF(pay_method='card', IF(type='credit', amount, -1 * amount), 0)) as total_card"),
                                DB::raw("SUM(IF(pay_method='cheque', IF(type='credit', amount, -1 * amount), 0)) as total_cheque"),
                                DB::raw("SUM(IF(pay_method='bank_transfer', IF(type='credit', amount, -1 * amount), 0)) as total_bank_transfer"),
                                DB::raw("SUM(IF(pay_method='other', IF(type='credit', amount, -1 * amount), 0)) as total_other"),
                                DB::raw("SUM(IF(pay_method='custom_pay_1', IF(type='credit', amount, -1 * amount), 0)) as total_custom_pay_1"),
                                DB::raw("SUM(IF(pay_method='custom_pay_2', IF(type='credit', amount, -1 * amount), 0)) as total_custom_pay_2"),
                                DB::raw("SUM(IF(pay_method='custom_pay_3', IF(type='credit', amount, -1 * amount), 0)) as total_custom_pay_3")
                            )->first();
        $refunds = [
                    'cash' => $total_payment->total_cash,
                    'card' => $total_payment->total_card,
                    'cheque' => $total_payment->total_cheque,
                    'bank_transfer' => $total_payment->total_bank_transfer,
                    'other' => $total_payment->total_other,
                    'custom_pay_1' => $total_payment->total_custom_pay_1,
                    'custom_pay_2' => $total_payment->total_custom_pay_2,
                    'custom_pay_3' => $total_payment->total_custom_pay_3,
                ];
        $refund_formatted = [];
        foreach ($refunds as $key => $val) {
            if ($val > 0) {
                $refund_formatted[] = new CashRegisterTransaction([
                    'amount' => $val,
                    'pay_method' => $key,
                    'type' => 'debit',
                    'transaction_type' => 'refund',
                    'transaction_id' => $transaction->id
                ]);
            }
        }

        if (!empty($refund_formatted)) {
            $register->cash_register_transactions()->saveMany($refund_formatted);
        }
        return true;
    }

    /**
     * Retrieves details of given rigister id else currently opened register
     *
     * @param $register_id default null
     *
     * @return object
     */
    public function getRegisterDetails($register_id = null)
    {
        $query = CashRegister::join(
            'cash_register_transactions as ct',
            'ct.cash_register_id',
            '=',
            'cash_registers.id'
        )
        ->join(
            'users as u',
            'u.id',
            '=',
            'cash_registers.user_id'
        )
        ->leftJoin(
            'business_locations as bl',
            'bl.id',
            '=',
            'cash_registers.location_id'
        );
        if (empty($register_id)) {
            $user_id = auth()->user()->id;
            $query->where('user_id', $user_id)
                ->where('cash_registers.status', 'open');
        } else {
            $query->where('cash_registers.id', $register_id);
        }
                              
        $register_details = $query->select(
            'cash_registers.created_at as open_time',
            'cash_registers.closed_at as close_time_regis',
            'cash_registers.user_id',
            'cash_registers.closing_note',
            'cash_registers.location_id',
            DB::raw("SUM(IF(transaction_type='initial', amount, 0)) as cash_in_hand"),
            DB::raw("SUM(IF(transaction_type='sell', amount, IF(transaction_type='refund', -1 * amount, 0))) as total_sale"),
            DB::raw("SUM(IF(pay_method='cash', IF(transaction_type='sell', amount, 0), 0)) as total_cash"),
            DB::raw("SUM(IF(pay_method='cheque', IF(transaction_type='sell', amount, 0), 0)) as total_cheque"),
            DB::raw("SUM(IF(pay_method='card', IF(transaction_type='sell', amount, 0), 0)) as total_card"),
            DB::raw("SUM(IF(pay_method='bank_transfer', IF(transaction_type='sell', amount, 0), 0)) as total_bank_transfer"),
            DB::raw("SUM(IF(pay_method='other', IF(transaction_type='sell', amount, 0), 0)) as total_other"),
            DB::raw("SUM(IF(pay_method='custom_pay_1', IF(transaction_type='sell', amount, 0), 0)) as total_custom_pay_1"),
            DB::raw("SUM(IF(pay_method='custom_pay_2', IF(transaction_type='sell', amount, 0), 0)) as total_custom_pay_2"),
            DB::raw("SUM(IF(pay_method='custom_pay_3', IF(transaction_type='sell', amount, 0), 0)) as total_custom_pay_3"),
            DB::raw("SUM(IF(transaction_type='refund', amount, 0)) as total_refund"),
            DB::raw("SUM(IF(transaction_type='refund', IF(pay_method='cash', amount, 0), 0)) as total_cash_refund"),
            DB::raw("SUM(IF(transaction_type='refund', IF(pay_method='cheque', amount, 0), 0)) as total_cheque_refund"),
            DB::raw("SUM(IF(transaction_type='refund', IF(pay_method='card', amount, 0), 0)) as total_card_refund"),
            DB::raw("SUM(IF(transaction_type='refund', IF(pay_method='bank_transfer', amount, 0), 0)) as total_bank_transfer_refund"),
            DB::raw("SUM(IF(transaction_type='refund', IF(pay_method='other', amount, 0), 0)) as total_other_refund"),
            DB::raw("SUM(IF(transaction_type='refund', IF(pay_method='custom_pay_1', amount, 0), 0)) as total_custom_pay_1_refund"),
            DB::raw("SUM(IF(transaction_type='refund', IF(pay_method='custom_pay_2', amount, 0), 0)) as total_custom_pay_2_refund"),
            DB::raw("SUM(IF(transaction_type='refund', IF(pay_method='custom_pay_3', amount, 0), 0)) as total_custom_pay_3_refund"),
            DB::raw("SUM(IF(pay_method='cheque', 1, 0)) as total_cheques"),
            DB::raw("SUM(IF(pay_method='card', 1, 0)) as total_card_slips"),
            DB::raw("CONCAT(COALESCE(surname, ''), ' ', COALESCE(first_name, ''), ' ', COALESCE(last_name, '')) as user_name"),
            'u.email',
            'bl.name as location_name'
        )->first();
        return $register_details;
    }

    /**
     * Get the transaction details for a particular register
     *
     * @param $user_id int
     * @param $open_time datetime
     * @param $close_time datetime
     *
     * @return array
     */
    public function getRegisterTransactionDetails($user_id, $open_time, $close_time,$close_time_regis, $is_types_of_service_enabled = false)
    {
        $business_id = request()->session()->get('user.business_id');

        if($close_time_regis==null){
            $close_time_regis=$close_time;
        }
        $transaction_details_method = TransactionPayment::where('transaction_payments.created_by', $user_id)
        ->join('transactions AS t','transaction_payments.transaction_id','=','t.id')
        ->whereBetween('t.transaction_date', [$open_time, $close_time_regis])
           ->select(
            DB::raw("SUM(IF(transaction_payments.method='cash' AND t.payment_status='paid' AND t.status='final', IF(t.type='sell', transaction_payments.amount, 0), 0)) as total_cash"),
            DB::raw("SUM(IF(transaction_payments.method='cheque', IF(t.type='sell', transaction_payments.amount, 0), 0)) as total_cheque"),
            DB::raw("SUM(IF(transaction_payments.method='card', IF(t.type='sell', transaction_payments.amount, 0), 0)) as total_card"),
            DB::raw("SUM(IF(transaction_payments.method='bank_transfer', IF(t.type='sell', transaction_payments.amount, 0), 0)) as total_bank_transfer"),
            DB::raw("SUM(IF(transaction_payments.method='other', IF(t.type='sell', transaction_payments.amount, 0), 0)) as total_other"),
            DB::raw("SUM(IF(transaction_payments.method='custom_pay_1', IF(t.type='sell', transaction_payments.amount, 0), 0)) as total_custom_pay_1"),
            DB::raw("SUM(IF(transaction_payments.method='custom_pay_2', IF(t.type='sell', transaction_payments.amount, 0), 0)) as total_custom_pay_2"),
            DB::raw("SUM(IF(transaction_payments.method='custom_pay_3', IF(t.type='sell', transaction_payments.amount, 0), 0)) as total_custom_pay_3"),
            DB::raw("SUM(IF(t.type='refund', amount, 0)) as total_refund"),
            DB::raw("SUM(IF(t.type='refund', IF(transaction_payments.method='cash', amount, 0), 0)) as total_cash_refund"),
            DB::raw("SUM(IF(t.type='refund', IF(transaction_payments.method='cheque', amount, 0), 0)) as total_cheque_refund"),
            DB::raw("SUM(IF(t.type='refund', IF(transaction_payments.method='card', amount, 0), 0)) as total_card_refund"),
            DB::raw("SUM(IF(t.type='refund', IF(transaction_payments.method='bank_transfer', amount, 0), 0)) as total_bank_transfer_refund"),
            DB::raw("SUM(IF(t.type='refund', IF(transaction_payments.method='other', amount, 0), 0)) as total_other_refund"),
            DB::raw("SUM(IF(t.type='refund', IF(transaction_payments.method='custom_pay_1', amount, 0), 0)) as total_custom_pay_1_refund"),
            DB::raw("SUM(IF(t.type='refund', IF(transaction_payments.method='custom_pay_2', amount, 0), 0)) as total_custom_pay_2_refund"),
            DB::raw("SUM(IF(t.type='refund', IF(transaction_payments.method='custom_pay_3', amount, 0), 0)) as total_custom_pay_3_refund")
            )->first();

        $product_details = Transaction::where('transactions.created_by', $user_id)
                ->whereBetween('transaction_date', [$open_time, $close_time])
                ->where('transactions.type', 'sell')
                ->where('transactions.status', 'final')
                ->join('transaction_sell_lines AS TSL', 'transactions.id', '=', 'TSL.transaction_id')
                ->join('products AS P', 'TSL.product_id', '=', 'P.id')
                ->leftjoin('brands AS B', 'P.brand_id', '=', 'B.id')
                ->groupBy('B.id')
                ->select(
                    'B.name as brand_name',
                    DB::raw('SUM(TSL.quantity) as total_quantity'),
                    DB::raw('SUM(TSL.unit_price_inc_tax*TSL.quantity) as total_amount')
                )
                ->orderByRaw('CASE WHEN brand_name IS NULL THEN 2 ELSE 1 END, brand_name')
                ->get();

        //If types of service
        $types_of_service_details = null;
        if ($is_types_of_service_enabled) {
            $types_of_service_details = Transaction::where('transactions.created_by', $user_id)
                ->whereBetween('transaction_date', [$open_time, $close_time])
                ->where('transactions.type', 'sell')
                ->where('transactions.status', 'final')
                ->leftjoin('types_of_services AS tos', 'tos.id', '=', 'transactions.types_of_service_id')
                ->groupBy('tos.id')
                ->select(
                    'tos.name as types_of_service_name',
                    DB::raw('SUM(final_total) as total_sales')
                )
                ->orderBy('total_sales', 'desc')
                ->get();
        }

        $transaction_details = Transaction::where('transactions.created_by', $user_id)
                ->leftjoin('transaction_payments as tr','tr.transaction_id','=','transactions.id')
                ->whereBetween('transaction_date', [$open_time, $close_time])
                ->where('transactions.type', 'sell')
                ->where('transactions.status', 'final')
                ->where('transactions.payment_status','paid')
                ->whereNull('tr.type_cont')
                ->select(
                    DB::raw('SUM(tax_amount) as total_tax'),
                    DB::raw('SUM(IF(discount_type = "percentage", total_before_tax*discount_amount/100, discount_amount)) as total_discount'),
                    DB::raw('SUM(final_total) as total_sales')
                )
                ->first();
                $transaction_details_due = Transaction::where('transactions.created_by', $user_id)
                ->whereBetween('transaction_date', [$open_time, $close_time])
                ->where('transactions.type', 'sell')
                ->where('transactions.status', 'final')
                ->whereIn('transactions.payment_status',['due','partial'])
                ->select(
                    DB::raw('SUM(tax_amount) as total_tax'),
                    DB::raw('SUM(IF(discount_type = "percentage", total_before_tax*discount_amount/100, discount_amount)) as total_discount'),
                    DB::raw('SUM(final_total) as total_sales')
                )
                ->first();

                $open_time=date('Y-m-d H:i',strtotime($open_time));
                $close_time_regis=date('Y-m-d H:i',strtotime($close_time_regis));

                $query = Transaction::leftjoin('expense_categories AS ec', 'transactions.expense_category_id', '=', 'ec.id')
                ->where('transactions.business_id', $business_id)
                ->where('transactions.type', 'expense');
                $query->whereBetween('transactions.transaction_date', [$open_time,
                $close_time_regis]);
                $expenses = $query->select(
                    DB::raw("SUM( transactions.final_total ) as total_expense")
                )
                            ->first();


                            $querypayment = TransactionPayment::leftjoin('transactions as t','transaction_payments.transaction_id','=','t.id')
                            ->where('t.business_id', $business_id)
                           ->whereBetween('transaction_payments.paid_on', [$open_time,
                           $close_time_regis])
                            ->whereIn('t.type', ['sell', 'opening_balance'])
                            ->where('transaction_payments.type_cont','pago')
                            ->whereRaw("(transaction_payments.transaction_id IS NOT NULL AND t.type IN ('sell', 'opening_balance'))");
                        $querypayment1=$querypayment->select(
                            DB::raw('SUM(transaction_payments.amount) as total_paid')
                            )   
                        ->first();
        return ['product_details' => $product_details,
                'transaction_details' => $transaction_details,
                'types_of_service_details' => $types_of_service_details,
                'transaction_details_due'=>$transaction_details_due,
                'transaction_details_method'=>$transaction_details_method,
                'expenses'=>$expenses,
                'querypayment1'=>$querypayment1
            ];
    }

    /**
     * Retrieves the currently opened cash register for the user
     *
     * @param $int user_id
     *
     * @return obj
     */
    public function getCurrentCashRegister($user_id)
    {
        $register =  CashRegister::where('user_id', $user_id)
                                ->where('status', 'open')
                                ->first();

        return $register;
    }
}
