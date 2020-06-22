<?php

namespace App\Http\Controllers;
use App\Account;
use App\BusinessLocation;
use App\InvoiceLayout;
use App\Ncf;
use App\User;
use App\Contact;
use App\Brands;
use App\Ncfsecuencia;
use App\CustomerGroup;
use App\Presupuesto;
use Illuminate\Support\Facades\Input;

use App\InvoiceScheme;
use App\SellingPriceGroup;
use App\Utils\ModuleUtil;
use App\Utils\Util;
use App\Project;
use App\Task;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use Spatie\Permission\Models\Permission;
use Yajra\DataTables\Facades\DataTables;
use App\Utils\ContactUtil;


class ProjectController extends Controller
{
    protected $contactUtil;
    public function __construct(ContactUtil $contactUtil)
    {
        $this->contactUtil = $contactUtil;
        

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
        $business_id = request()->session()->get('user.business_id');

        if (request()->ajax()) {
            $brands = Project::where('project.business_id', $business_id)
            ->leftjoin('contacts as ncfp','project.customer_id','=','ncfp.id')
            ->leftjoin('users as usr','project.encargado','=','usr.id')

                        ->select(['project.name', 'project.Description', 'ncfp.name as customer_id','project.status','usr.first_name as encargado','project.start_date','project.end_date','project.category','project.p_id']);

            return Datatables::of($brands)
            ->addColumn(
                'action',
                '<div class="btn-group">
                    <button type="button" class="btn btn-info dropdown-toggle btn-xs" 
                        data-toggle="dropdown" aria-expanded="false">' .
                        __("messages.actions") .
                        '<span class="caret"></span><span class="sr-only">Toggle Dropdown
                        </span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-right" role="menu">
                    
                    <li><a href="{{action(\'ProjectController@edit\', [$p_id])}}" class="edit_project"><i class="fa fa-external-link" aria-hidden="true"></i> @lang("messages.edit")</a></li>
                    <li><a href="{{action(\'ProjectController@presupuesto\', [$p_id])}}" class="presupuesto_button"><i class="fa fa-external-link" aria-hidden="true"></i> @lang("lang_v1.presupuesto")</a></li>
                    <li><a href="{{action(\'ProjectController@Delete_project\', [$p_id])}}" class="delete_button"><i class="fa fa-power-off" aria-hidden="true"></i> @lang("lang_v1.delete_project")</a></li>
                    <li><a href="{{action(\'ProjectController@presupuesto_details\', [$p_id])}}" class="view_details_button"><i class="fa fa-power-off" aria-hidden="true"></i> @lang("lang_v1.view_details")</a></li>

                     </ul></div>'
            )
                ->removeColumn('p_id')
                ->rawColumns([8])
                ->make(false);
        }
  
        $count_project = Project::where('business_id', $business_id)
        ->count();
        $count_project_pending = Project::where('business_id', $business_id)
        ->where('status','En espera')
        ->count();
        $count_project_completed = Project::where('business_id', $business_id)
        ->where('status','Completado')
        ->count();
        $count_project_cancelado = Project::where('business_id', $business_id)
        ->where('status','Cancelado')
        ->count();
        $count_project_progreso = Project::where('business_id', $business_id)
        ->where('status','En progreso')
        ->count();
        $count_task_project = Task::where('business_id', $business_id)
        ->count();
        return view('Project.index')
        ->with(compact('count_project','count_project_pending','count_project_completed','count_project_cancelado','count_project_progreso','count_task_project'));

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
        
        $types = [];
        if (auth()->user()->can('supplier.create')) {
            $types['supplier'] = __('report.supplier');
        }
        if (auth()->user()->can('customer.create')) {
            $types['customer'] = __('report.customer');
        }
        if (auth()->user()->can('supplier.create') && auth()->user()->can('customer.create')) {
            $types['both'] = __('lang_v1.both_supplier_customer');
        }
        $business_id = request()->session()->get('user.business_id');
        $walk_in_customer = $this->contactUtil->getWalkInCustomer($business_id);
        $customers = Contact::customersDropdown($business_id, false);
        $users = User::allUsersDropdown($business_id, false);

        //Check if subscribed or not, then check for location quota
        // if (!$this->moduleUtil->isSubscribed($business_id)) {
        //     return $this->moduleUtil->expiredResponse();
        // } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
        //     return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
        // }

       

        

        $customer_groups = CustomerGroup::forDropdown($business_id);



        //Accounts
        $accounts = [];
     

        return view('Project.create')
        ->with(compact(
            'walk_in_customer','types','customer_groups','customers','users'));
                    
    }
public function Task(){
    if (!auth()->user()->can('business_settings.access')) {
        abort(403, 'Unauthorized action.');
    }
    $business_id = request()->session()->get('user.business_id');
  
    $count_task = Task::where('business_id', $business_id)
    ->count();
    $count_task_pending = Task::where('business_id', $business_id)
    ->where('status','En espera')
    ->count();
    $count_task_completed = Task::where('business_id', $business_id)
    ->where('status','Completado')
    ->count();
    $count_task_cancelado = Task::where('business_id', $business_id)
    ->where('status','Cancelado')
    ->count();
    $count_task_progreso = Task::where('business_id', $business_id)
    ->where('status','En progreso')
    ->count();
    $count_task_project = Project::where('business_id', $business_id)
    ->count();

    return view('Project.task')
    ->with(compact('count_task','count_task_pending','count_task_completed','count_task_cancelado','count_task_progreso','count_task_project'));
}
public function Task_list(){
    if (!auth()->user()->can('business_settings.access')) {
        abort(403, 'Unauthorized action.');
    }

    if (request()->ajax()) {
        $business_id = request()->session()->get('user.business_id');
        $brands = Task::where('task.business_id', $business_id)
        ->leftjoin('project as ncfp','task.p_id','=','ncfp.p_id')

                    ->select(['task.task_title','task.task_description', 'task.category as category','task.start_from','task.end_date','ncfp.name as p_id','task.status','task.idtask']);

        return Datatables::of($brands)
        ->addColumn(
            'action',
            '<div class="btn-group">
                <button type="button" class="btn btn-info dropdown-toggle btn-xs" 
                    data-toggle="dropdown" aria-expanded="false">' .
                    __("messages.actions") .
                    '<span class="caret"></span><span class="sr-only">Toggle Dropdown
                    </span>
                </button>
                <ul class="dropdown-menu dropdown-menu-right" role="menu">
                
                <li><a href="{{action(\'ProjectController@Show_task\', [$idtask])}}" class="view_button"><i class="fa fa-external-link" aria-hidden="true"></i> @lang("messages.view")</a></li>
                <li><a href="{{action(\'ProjectController@Edit_task\', [$idtask])}}" class="edit_button"><i class="glyphicon glyphicon-edit" aria-hidden="true"></i> @lang("messages.edit")</a></li>
                <li><a href="{{action(\'ProjectController@Delete_task1\', [$idtask])}}" class="delete_button"><i class="fa fa-power-off" aria-hidden="true"></i> @lang("lang_v1.Delete_task")</a></li>

                 </ul></div>'
        )
            ->removeColumn('idtask')
            ->rawColumns([7])
            ->make(false);
    }

    
    return view('Project.task');
}
public function add_task(){
    $business_id = request()->session()->get('user.business_id');

            $project = Project::forDropdown($business_id, false, false, true);

    return view('Project.add_task')
    ->with(compact('project'));
}
   
public function Edit_task($idtask){
    $business_id = request()->session()->get('user.business_id');
$tareas=Task::where('business_id',$business_id)
            ->where('idtask',$idtask)->first();
            $project = Project::forDropdown($business_id, false, false, true);

    return view('Project.edit_task')
    ->with(compact('tareas','project'));
}
public function Show_task($idtask){
    $business_id = request()->session()->get('user.business_id');
    $tareas=Task::where('business_id',$business_id)
                ->where('idtask',$idtask)->first();
                $project = Project::forDropdown($business_id, false, false, true);
    
        return view('Project.view_task')
        ->with(compact('tareas','project'));}
 public function store_presupuesto(Request $request)
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
         $p_id = $request->input('p_id');

         // $input = $request->only(['idncf', 'prefijo', 'desde', 'hasta', 'autorizacionNo', 'fecha_venc']);
         for($i = 0; $i < count(Input::get('partidas')); $i++){
             $input['business_id'] = $business_id;
             $input['partidas'] = Input::get('partidas')[$i];
             $input['cantidad'] = Input::get('cantidad')[$i];
             $input['unidad'] = Input::get('unidad')[$i];
             $input['precio_unitario'] = Input::get('precio_unitario')[$i];
             $input['Valor'] = Input::get('valor')[$i];
             $input['p_id'] =$p_id;
             $location = Presupuesto::create($input);

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
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

     public function store_task(Request $request){
        try {
            $business_id = $request->session()->get('user.business_id');

            //Check if subscribed or not, then check for location quota
            // if (!$this->moduleUtil->isSubscribed($business_id)) {
            //     return $this->moduleUtil->expiredResponse();
            // } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
            //     return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
            // }

            $input = $request->only(['task_title', 'category', 'start_from', 'end_date','task_description', 'p_id','status']);
        //   $miembros=$request->input('members');
            // $input['members']=implode(',', $miembros);
            $input['business_id']=$business_id;
            $location = Task::create($input);
            $msg = __('lang_v1.task_successfully');

            $output = ['success' => true,
            'msg' => __("lang_v1.task_successfully")
        ];
} catch (\Exception $e) {
\Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());

$output = ['success' => false,
            'msg' => __("messages.something_went_wrong")
        ];
}
// return $output;
return redirect('Task')->with('status', $output);

     }
    public function store(Request $request)
    {
      
        try {
            $business_id = $request->session()->get('user.business_id');

            //Check if subscribed or not, then check for location quota
            // if (!$this->moduleUtil->isSubscribed($business_id)) {
            //     return $this->moduleUtil->expiredResponse();
            // } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
            //     return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
            // }

            $input = $request->only(['name', 'description', 'customer_id', 'status', 'encargado', 'start_date','end_date','category']);
        //   $miembros=$request->input('members');
            // $input['members']=implode(',', $miembros);
            $input['business_id']=$business_id;
            $location = Project::create($input);
            $msg = __('lang_v1.project_successfully');

            $output = ['success' => true,
            'msg' => $msg
        ];
        }catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
            $output = ['success' => false,
                            'msg' => __("messages.something_went_wrong")
                        ];
        }

        return $output;
        // return redirect('index')->with('status', $output);
        
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Project  $project
     * @return \Illuminate\Http\Response
     */
    public function show(Project $project)
    {
        //
    }
    public function presupuesto($id)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }
        
    
        $business_id = request()->session()->get('user.business_id');
$p_id1=$id;
        //Check if subscribed or not, then check for location quota
        // if (!$this->moduleUtil->isSubscribed($business_id)) {
        //     return $this->moduleUtil->expiredResponse();
        // } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
        //     return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
        // }  
         //Accounts
     

        return view('Project.presupuesto')
        ->with(compact(
            'p_id1'
        ));
        
    }

    public function presupuesto_details($id)
    {
      
    
        $business_id = request()->session()->get('user.business_id');
$p_id1=$id;

        //Check if subscribed or not, then check for location quota
        // if (!$this->moduleUtil->isSubscribed($business_id)) {
        //     return $this->moduleUtil->expiredResponse();
        // } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
        //     return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
        // }  
         //Accounts
     
         $brands = Presupuesto::where('p_id',$id)
         ->where('business_id', $business_id)
            
         ->select(['partidas', 'cantidad','unidad','precio_unitario','Valor','id']);

         return Datatables::of($brands)
         ->addColumn(
             'action',
             '<div class="btn-group">
                 <button type="button" class="btn btn-info dropdown-toggle btn-xs" 
                     data-toggle="dropdown" aria-expanded="false">' .
                     __("messages.actions") .
                     '<span class="caret"></span><span class="sr-only">Toggle Dropdown
                     </span>
                 </button>
                 <ul class="dropdown-menu dropdown-menu-right" role="menu">
                 
                 <li><a href="{{action(\'ProjectController@edit\', [$p_id])}}" class="edit_project"><i class="fa fa-external-link" aria-hidden="true"></i> @lang("messages.edit")</a></li>
                 <li><a href="{{action(\'ProjectController@presupuesto\', [$p_id])}}" class="presupuesto_button"><i class="fa fa-external-link" aria-hidden="true"></i> @lang("lang_v1.presupuesto")</a></li>
                 <li><a href="{{action(\'ProjectController@Delete_project\', [$p_id])}}" class="delete_button"><i class="fa fa-power-off" aria-hidden="true"></i> @lang("lang_v1.delete_project")</a></li>
                 <li><a href="{{action(\'ProjectController@presupuesto_details\', [$p_id])}}" class="view_details_button"><i class="fa fa-power-off" aria-hidden="true"></i> @lang("lang_v1.view_details")</a></li>

                  </ul></div>'
         )
             ->removeColumn('p_id')
             ->rawColumns([8])
             ->make(false);
        return view('Project.presupuesto_details')
        ->with(compact(
            'p_id1'
        ));
        
    }
    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Project  $project
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $business_id = request()->session()->get('user.business_id');
        $walk_in_customer = $this->contactUtil->getWalkInCustomer($business_id);
        $customers = Contact::customersDropdown($business_id, false);
        $users = User::allUsersDropdown($business_id, false);
        $types = [];
        if (auth()->user()->can('supplier.create')) {
            $types['supplier'] = __('report.supplier');
        }
        if (auth()->user()->can('customer.create')) {
            $types['customer'] = __('report.customer');
        }
        if (auth()->user()->can('supplier.create') && auth()->user()->can('customer.create')) {
            $types['both'] = __('lang_v1.both_supplier_customer');
        }
        $customer_groups = CustomerGroup::forDropdown($business_id);

$project1=Project::where('business_id',$business_id)
            ->where('p_id',$id)->first();
            $project = Project::forDropdown($business_id, false, false, true);

        return view('Project.edit_project')
        ->with(compact('project1','project','customers','users','types','customer_groups'));
        ;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Project  $project
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Project $project)
    {
        //
    }

    public function update_project(Request $request){
        try{
            $business_id = request()->session()->get('user.business_id');

            $input = $request->only(['name', 'description', 'customer_id', 'status', 'encargado', 'start_date','end_date','category','p_id']);
        $id=$input['p_id'];
            DB::beginTransaction();
            $project = Project::where('business_id', $business_id)
            ->where('p_id', $id)
            ->first();
            $project->name = $input['name'];
            $project->Description = $input['description'];
            $project->customer_id = $input['customer_id'];
            $project->status = $input['status'];
            $project->encargado = $input['encargado'];
            $project->start_date = $input['start_date'];
            $project->end_date = $input['end_date'];
            $project->category = $input['category'];
           

            $project->save();

            DB::commit();
            $output = ['success' => true,
            'msg' => __("lang_v1.project_update_successfully")
        ];
} catch (\Exception $e) {
\Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());

$output = ['success' => false,
            'msg' => __("messages.something_went_wrong")
        ];
}
return redirect('task')->with('status', $output);
}
    public function update_task(Request $request){
        try{
            $business_id = request()->session()->get('user.business_id');

            $input = $request->only(['idtask','task_title', 'category', 'start_from', 'end_date','task_description', 'p_id','status']);
        $id=$input['idtask'];
            DB::beginTransaction();
            $task = Task::where('business_id', $business_id)
            ->where('idtask', $id)
            ->first();
            $task->task_title = $input['task_title'];
            $task->category = $input['category'];
            $task->start_from = $input['start_from'];
            $task->end_date = $input['end_date'];
            $task->task_description = $input['task_description'];
            $task->p_id = $input['p_id'];
            $task->status = $input['status'];
           

            $task->save();

            DB::commit();
            $output = ['success' => true,
            'msg' => __("lang_v1.task_successfully")
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
     * @param  \App\Project  $project
     * @return \Illuminate\Http\Response
     */
    public function destroy(Project $project)
    {
        //
    }
    public function Delete_task1($idtask){
        try{
        $business_id = request()->session()->get('user.business_id');
        $can_be_deleted = true;
        $task = Task::where('idtask', $idtask)
        ->where('business_id', $business_id)
        ->first();

        if ($can_be_deleted) {
            if (!empty($task)) {
                DB::beginTransaction();
                //Delete variation location details
             
                $task->delete();

                DB::commit();
            }

            $output = ['success' => true,
                        'msg' => __("lang_v1.task_delete_success")
                    ];
        } else {
            $output = ['success' => false,
                        'msg' => $error_msg
                    ];
        }
    } catch (\Exception $e) {
        DB::rollBack();
        \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
        
        $output = ['success' => false,
                        'msg' => __("messages.something_went_wrong")
                    ];
    }
    return redirect('Task')->with('status', $output);

    }


    public function Delete_project($id){
        try{
        $business_id = request()->session()->get('user.business_id');
        $can_be_deleted = true;
        $project = Project::where('p_id', $id)
        ->where('business_id', $business_id)
        ->first();

        if ($can_be_deleted) {
            if (!empty($project)) {
                DB::beginTransaction();
                //Delete variation location details
             
                $project->delete();

                DB::commit();
            }

            $output = ['success' => true,
                        'msg' => __("lang_v1.project_delete_success")
                    ];
        } else {
            $output = ['success' => false,
                        'msg' => $error_msg
                    ];
        }
    } catch (\Exception $e) {
        DB::rollBack();
        \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
        
        $output = ['success' => false,
                        'msg' => __("messages.something_went_wrong")
                    ];
    }
    return redirect('task')->with('status', $output);

    }
}
