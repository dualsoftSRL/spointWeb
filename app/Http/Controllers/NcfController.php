<?php

namespace App\Http\Controllers;

use App\Account;
use App\BusinessLocation;
use App\InvoiceLayout;
use App\Ncf;
use App\Brands;
use App\Ncfsecuencia;
use Illuminate\Support\Facades\Input;

use App\InvoiceScheme;
use App\SellingPriceGroup;
use App\Utils\ModuleUtil;
use App\Utils\Util;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;
use Yajra\DataTables\Facades\DataTables;

class NcfController extends Controller
{
    protected $moduleUtil;
    protected $commonUtil;

    /**
     * Constructor
     *
     * @param ModuleUtil $moduleUtil
     * @return void
     */
    public function __construct(ModuleUtil $moduleUtil, Util $commonUtil)
    {
        $this->moduleUtil = $moduleUtil;
        $this->commonUtil = $commonUtil;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            $business_id = request()->session()->get('user.business_id');

            $brands = Ncfsecuencia::where('ncf_secuencia.business_id', $business_id)
                        ->leftjoin('ncf as ncfp','ncf_secuencia.idncf','=','ncfp.idncf')
                        ->whereIn('ncf_secuencia.status',[1,2])
                        ->select(['ncf_secuencia.fecha_venc', 'ncf_secuencia.prefijo', 'ncf_secuencia.desde','ncf_secuencia.hasta','ncf_secuencia.usados','ncf_secuencia.autorizacionNo','ncf_secuencia.idncfsecuencia','ncfp.nombre']);

            return Datatables::of($brands)
                ->addColumn(
                    'action',
                    '
                    <button type="button" data-href="{{action(\'NcfController@activateDeactivateLocation\', [$idncfsecuencia])}}" class="btn btn-xs btn-danger desactivate-ncf"><i class="fa fa-power-off"></i>  </button>
                    '
                )
                ->removeColumn('idncfsecuencia')
                ->rawColumns([7])
                ->make(false);
        }

        return view('Ncf.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }
        $business_id = request()->session()->get('user.business_id');

        //Check if subscribed or not, then check for location quota
        // if (!$this->moduleUtil->isSubscribed($business_id)) {
        //     return $this->moduleUtil->expiredResponse();
        // } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
        //     return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
        // }

        $invoice_layouts = InvoiceLayout::where('business_id', $business_id)
                            ->get()
                            ->pluck('name', 'id');

        $invoice_schemes = InvoiceScheme::where('business_id', $business_id)
                            ->get()
                            ->pluck('name', 'id');

        $price_groups = SellingPriceGroup::forDropdown($business_id);
        $idncf = Ncf::forDropdown1();

        $payment_types = $this->commonUtil->payment_types();

        //Accounts
        $accounts = [];
        if ($this->commonUtil->isModuleEnabled('account')) {
            $accounts = Account::forDropdown($business_id, true, false);
        }

        return view('Ncf.create')
                    ->with(compact(
                        'invoice_layouts',
                        'invoice_schemes',
                        'price_groups',
                        'payment_types',
                        'idncf',
                        'accounts'
                    ));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    // public function store(Request $request)
    // {
    //     if (!auth()->user()->can('business_settings.access')) {
    //         abort(403, 'Unauthorized action.');
    //     }

    //     try {
    //         $business_id = $request->session()->get('user.business_id');

    //         //Check if subscribed or not, then check for location quota
    //         // if (!$this->moduleUtil->isSubscribed($business_id)) {
    //         //     return $this->moduleUtil->expiredResponse();
    //         // } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
    //         //     return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
    //         // }

    //         $input = $request->only(['idncf', 'prefijo', 'desde', 'hasta', 'autorizacionNo', 'fecha_venc']);

    //         $input['business_id'] = $business_id;


    //         //Update reference count

        

    //         $location = Ncfsecuencia::create($input);

    //         //Create a new permission related to the created location

    //         $output = ['success' => true,
    //                         'msg' => __("invoice.ncf_added_success")
    //                     ];
    //     } catch (\Exception $e) {
    //         \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
    //         $output = ['success' => false,
    //                         'msg' => __("messages.something_went_wrong")
    //                     ];
    //     }

    //     return $output;
    // }

    public function verificar($idncf,$desde,$hasta){
        // if (!auth()->user()->can('business_settings.access')) {
        //     abort(403, 'Unauthorized action.');
        // }
    
        try {
        $business_id = request()->session()->get('user.business_id');
        $input['business_id'] = $business_id;
        $idncf1 = $idncf;
        $desde1 = $desde;
        $hasta1 = $hasta;
        $idncf = Ncfsecuencia::where('idncf',$idncf)
        ->whereBetween('desde',[$desde,$hasta])
        ->where('business_id',$business_id)
        ->whereIn('status',[1,2])
        
        ->first();
                    if($idncf->idncf!=0){
                $output = ['success' => true,
                'msg' => __("invoice.sucuence_uso"),
                'desde'=>$idncf->desde

            ];
            }else{
                 $output = ['success' => false,
                            'msg' => __("messages.something_went_wrong"),
                            'desde'=>$idncf->desde
                        ];
            }
    
      
    
        }   
        catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
            $output = ['success' => false,
                            'msg' => __("messages.something_went_wrong")
                        ];
        }
        return $output;
    
    }



    
 public function store(Request $request)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $business_id = $request->session()->get('user.business_id');

            //Check if subscribed or not, then check for location quota
            // if (!$this->moduleUtil->isSubscribed($business_id)) {
            //     return $this->moduleUtil->expiredResponse();
            // } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
            //     return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
            // }

            // $input = $request->only(['idncf', 'prefijo', 'desde', 'hasta', 'autorizacionNo', 'fecha_venc']);
            for($i = 0; $i < count(Input::get('idncf')); $i++){
                $input['business_id'] = $business_id;
                $input['idncf'] = Input::get('idncf')[$i];
                $input['prefijo'] = Input::get('prefijo')[$i];
                $input['desde'] = Input::get('desde')[$i];
                $input['hasta'] = Input::get('hasta')[$i];
                $input['autorizacionNo'] = Input::get('autorizacionNo')[$i];
                $input['fecha_venc'] = Input::get('fecha_venc')[$i];
                $input['secuencia'] = Input::get('desde')[$i];
                $location = Ncfsecuencia::create($input);

            }


            //Update reference count

        


            //Create a new permission related to the created location

            $output = ['success' => true,
                            'msg' => __("invoice.ncf_added_success")
                        ];
        } catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
            $output = ['success' => false,
                            'msg' => __("messages.something_went_wrong")
                        ];
        }

        return $output;
    }




    /**
     * Display the specified resource.
     *
     * @param  \App\StoreFront  $storeFront
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\StoreFront  $storeFront
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        $business_id = request()->session()->get('user.business_id');
        $location = BusinessLocation::where('business_id', $business_id)
                                    ->find($id);
        $invoice_layouts = InvoiceLayout::where('business_id', $business_id)
                            ->get()
                            ->pluck('name', 'id');
        $invoice_schemes = InvoiceScheme::where('business_id', $business_id)
                            ->get()
                            ->pluck('name', 'id');

        $price_groups = SellingPriceGroup::forDropdown($business_id);

        $payment_types = $this->commonUtil->payment_types();

        //Accounts
        $accounts = [];
        if ($this->commonUtil->isModuleEnabled('account')) {
            $accounts = Account::forDropdown($business_id, true, false);
        }

        return view('business_location.edit')
                ->with(compact(
                    'location',
                    'invoice_layouts',
                    'invoice_schemes',
                    'price_groups',
                    'payment_types',
                    'accounts'
                ));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\StoreFront  $storeFront
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $input = $request->only(['name', 'landmark', 'city', 'state', 'country',
                'zip_code', 'invoice_scheme_id',
                'invoice_layout_id', 'mobile', 'alternate_number', 'email', 'website', 'custom_field1', 'custom_field2', 'custom_field3', 'custom_field4', 'location_id', 'selling_price_group_id', 'default_payment_accounts']);
            
            $business_id = $request->session()->get('user.business_id');

            $input['default_payment_accounts'] = !empty($input['default_payment_accounts']) ? json_encode($input['default_payment_accounts']) : null;

            BusinessLocation::where('business_id', $business_id)
                            ->where('id', $id)
                            ->update($input);

            $output = ['success' => true,
                            'msg' => __('business.business_location_updated_success')
                        ];
        } catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
            $output = ['success' => false,
                            'msg' => __("messages.something_went_wrong")
                        ];
        }

        return $output;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\StoreFront  $storeFront
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    /**
    * Checks if the given location id already exist for the current business.
    *
    * @param  \Illuminate\Http\Request  $request
    * @return \Illuminate\Http\Response
    */
    public function checkLocationId(Request $request)
    {
        $location_id = $request->input('location_id');

        $valid = 'true';
        if (!empty($location_id)) {
            $business_id = $request->session()->get('user.business_id');
            $hidden_id = $request->input('hidden_id');

            $query = BusinessLocation::where('business_id', $business_id)
                            ->where('location_id', $location_id);
            if (!empty($hidden_id)) {
                $query->where('id', '!=', $hidden_id);
            }
            $count = $query->count();
            if ($count > 0) {
                $valid = 'false';
            }
        }
        echo $valid;
        exit;
    }

    /**
     * Function to activate or deactivate a location.
     * @param int $location_id
     *
     * @return json
     */
    public function activateDeactivateLocation($idncf)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $business_id = request()->session()->get('user.business_id');
            $business_location = Ncfsecuencia::where('business_id', $business_id)
            ->where('idncfsecuencia',$idncf)
            ->first();   
            $business_location->status = 3;
            $business_location->save();
            $msg = __('invoice.Ncf_successfully');

            $output = ['success' => true,
                            'msg' => $msg
                        ];
        } catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
            $output = ['success' => false,
                            'msg' => __("messages.something_went_wrong")
                        ];
        }

        return $output;
    }
}
