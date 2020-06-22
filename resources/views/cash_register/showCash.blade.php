@extends('layouts.guest')
@section('content')

<div class="container">
    <div class="spacer"></div>
    <div class="row">
        <div class="col-md-12">
            <button type="button" class="btn btn-primary no-print pull-right"
                 aria-label="Print" onclick="$('#invoice_content').printThis();"><i class="fa fa-print"></i> @lang( 'messages.print' )
            </button>
            <a href="{{action('HomeController@index')}}" class="btn btn-success no-print"><i class="fa fa-backward"></i>
                </a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 col-md-offset-2 col-sm-12" style="border: 1px solid #ccc;">
            <div class="spacer"></div>
            <div id="invoice_content">
            <div class="row" style="margin-left:10px; margin-top:10px;">
        <div class="col-sm-12">
        <h3 class="modal-title">@lang( 'cash_register.closedetails' ) ( {{ \Carbon::createFromFormat('Y-m-d H:i:s', $register_details->open_time)->format('jS M, Y h:i A') }} - {{ \Carbon::now()->format('jS M, Y h:i A') }})</h3>

          <table class="table">
          <tr>
              <td>
                @lang('cash_register.cash_in_hand'):
              </td>
              <td>
                <span class="display_currency" data-currency_symbol="true">{{ $register_details->cash_in_hand }}</span>
              </td>
            </tr>
            <tr>
              <td>
                @lang('cash_register.venta_contado'):
              </td>
              <td>
                <span class="display_currency" data-currency_symbol="true">{{$details['transaction_details']->total_sales- $register_details->total_cash_refund}}</span>
              </td>
            </tr>
            <tr>
              <th>
                @lang('lang_v1.Desglose'):
              </th>
              </tr>
            <tr>
              <td>
                @lang('cash_register.cash_payment'):
              </th>
              <td>
                <span class="display_currency" data-currency_symbol="true">{{$register_details->total_cash}}</span>
              </td>
            </tr>
            <tr>
              <td>
                @lang('cash_register.checque_payment'):
              </td>
              <td>
                <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_cheque}}</span>
              </td>
            </tr>
            <tr>
              <td>
                @lang('cash_register.card_payment'):
              </td>
              <td>
                <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_card}}</span>
              </td>
            </tr>
            <tr>
              <td>
                @lang('cash_register.bank_transfer'):
              </td>
              <td>
                <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_bank_transfer}}</span>
              </td>
            </tr>
            @if(array_key_exists('custom_pay_1', $payment_types))
              <tr>
                <td>
                  {{$payment_types['custom_pay_1']}}:
                </td>
                <td>
                  <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_custom_pay_1}}</span>
                </td>
              </tr>
            @endif
            @if(array_key_exists('custom_pay_2', $payment_types))
              <tr>
                <td>
                  {{$payment_types['custom_pay_2']}}:
                </td>
                <td>
                  <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_custom_pay_2}}</span>
                </td>
              </tr>
            @endif
            @if(array_key_exists('custom_pay_3', $payment_types))
              <tr>
                <td>
                  {{$payment_types['custom_pay_3']}}:
                </td>
                <td>
                  <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_custom_pay_3}}</span>
                </td>
              </tr>
            @endif
            <tr>
              <td>
                @lang('cash_register.other_payments'):
              </td>
              <td>
                <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_other + $details['transaction_details_method']->total_other}}</span>
              </td>
              </tr>
              <tr class="success">
              <th>
                @lang('lang_v1.credit_sales'):
              </th>
              <td>
                <b><span class="display_currency" data-currency_symbol="true">{{$details['transaction_details_due']->total_sales}}</span></b>
              </td>
            </tr>
            <tr class="success">
              <th>
                @lang('cash_register.ingreso_pago'):
              </th>
              <td>
                <b><span class="display_currency" data-currency_symbol="true">{{$details['querypayment1']->total_paid}}</span></b>
              </td>
            </tr>
              <tr class="success">
              <th>
                @lang('lang_v1.gastos'):
              </th>
              <td>
                <b><span class="display_currency" data-currency_symbol="true">{{$details['expenses']->total_expense}}</span></b>
              </td>
              </tr>
            <tr class="success">
              <th>
                @lang('cash_register.total_refund')
              </th>
              <td>
                <b><span class="display_currency" data-currency_symbol="true">{{ $register_details->total_refund + $details['transaction_details_method']->total_refund }}</span></b><br>
                <small>
                @if($register_details->total_cash_refund != 0)
                  Cash: <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_cash_refund + $details['transaction_details_method']->total_cash_refund }}</span><br>
                @endif
                @if($register_details->total_cheque_refund != 0) 
                  Cheque: <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_cheque_refund + $details['transaction_details_method']->total_cheque_refund }}</span><br>
                @endif
                @if($register_details->total_card_refund != 0) 
                  Card: <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_card_refund + $details['transaction_details_method']->total_card_refund}}</span><br> 
                @endif
                @if($register_details->total_bank_transfer_refund != 0)
                  Bank Transfer: <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_bank_transfer_refund + $details['transaction_details_method']->total_bank_transfer_refund}}</span><br>
                @endif
                @if(array_key_exists('custom_pay_1', $payment_types) && $register_details->total_custom_pay_1_refund != 0)
                    {{$payment_types['custom_pay_1']}}: <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_custom_pay_1_refund }}</span>
                @endif
                @if(array_key_exists('custom_pay_2', $payment_types) && $register_details->total_custom_pay_2_refund != 0)
                    {{$payment_types['custom_pay_2']}}: <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_custom_pay_2_refund }}</span>
                @endif
                @if(array_key_exists('custom_pay_3', $payment_types) && $register_details->total_custom_pay_3_refund != 0)
                    {{$payment_types['custom_pay_3']}}: <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_custom_pay_3_refund }}</span>
                @endif
                @if($register_details->total_other_refund != 0)
                  Other: <span class="display_currency" data-currency_symbol="true">{{ $register_details->total_other_refund + $details['transaction_details_method']->total_other_refund}}</span>
                @endif
                </small>
              </td>
            </tr>
            <tr class="success">
              <th>
                @lang('lang_v1.total_payment')
              </th>
              <td>
                <b><span class="display_currency" data-currency_symbol="true">{{$details['querypayment1']->total_paid+ $details['transaction_details']->total_sales- $register_details->total_cash_refund}}</span></b>
                
              </td>
            </tr>
          
            <tr class="success">
              <th>
                @lang('cash_register.total_sales'):
              </th>
              <td>
                <b><span class="display_currency" data-currency_symbol="true">{{ $details['transaction_details']->total_sales+$details['transaction_details_due']->total_sales }}</span></b>
              </td>
            </tr>
            <tr class="success">
              <th>
                @lang('lang_v1.total_rest'):
              </th>
              <td>
              <b><span class="display_currency" data-currency_symbol="true">{{ ($register_details->cash_in_hand+$details['transaction_details']->total_sales- $register_details->total_cash_refund+$details['querypayment1']->total_paid)-$details['expenses']->total_expense-($register_details->total_refund + $details['transaction_details_method']->total_refund) }}</span></b>
              </td>
            </tr>
          </table>
        </div>
      </div>

      @include('cash_register.register_product_details')
      
      <div class="row">
        <div class="col-xs-6">
          <b>@lang('report.user'):</b> {{ $register_details->user_name}}<br>
          <b>Email:</b> {{ $register_details->email}}<br>
          <b>@lang('business.business_location'):</b> {{ $register_details->location_name}}<br>
        </div>
        @if(!empty($register_details->closing_note))
          <div class="col-xs-6">
            <strong>@lang('cash_register.closing_note'):</strong><br>
            {{$register_details->closing_note}}
          </div>
        @endif
      </div>
    </div>
            <div class="spacer"></div>
        </div>
    </div>
    <div class="spacer"></div>
</div>
@endsection
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="{{ asset('public/plugins/accounting.min.js') }}"></script>
<script src="{{ asset('public/js/functions.js') }}"></script>

<script>

    $(document).ready(function(){
      __currency_precision=2;
      __currency_symbol='RD$';
      __currency_thousand_separator=',';
      __currency_decimal_separator='.';
      __currency_symbol_placement='_';
      __currency_convert_recursively($('table tr'));


        $('#invoice_content').printThis();      });
</script>