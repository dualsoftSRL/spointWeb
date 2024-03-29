@extends('layouts.app')
@section('title', __('lang_v1.Task'))

@section('content')
<style>
.card{
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    position: relative;
    margin-bottom: 1.5rem;
    width: 100%;
    margin-top:20px;
}    
.bg-info{
    background-color: #45aaf2 !important;
}
.bg-warning{
background-color: #f1c40f !important;
}
.bg-danger{
    background-color: #f1620f !important;

}
.bg-success{
background-color: #5eba00 !important;
}
.text-light{
    color: #f8f9fa !important;

}
.text-center {
    text-align: center !important;
}
.p-3 {
    padding: 0.75rem !important;
}
.card{
    position: relative;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-direction: column;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid rgba(0, 40, 100, 0.12);
    border-radius: 3px;
}
</style>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>@lang( 'lang_v1.all_task' )
        <small>@lang( 'lang_v1.manage_task' )</small>
    </h1>
    <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
    </ol> -->
</section>

<!-- Main content -->
<section class="content">
    @component('components.widget', ['class' => 'box-primary', 'title' => __( 'lang_v1.all_task' )])
        @slot('tool')
        <div class="row row-cards">
      <div class="col-6 col-sm-4 col-lg-2">
        <div class="card bg-info">
          <div class="card-body p-3 text-center text-light">
            <div class="h1 m-0">{{$count_task}}</div>
            <div class="mb-4">Total Actividades</div>
          </div>
        </div>
      </div>
      <div class="col-6 col-sm-4 col-lg-2">
        <div class="card bg-warning">
          <div class="card-body p-3 text-center text-light">
            <div class="h1 m-0">{{$count_task_pending}}</div>
            <div class="mb-4">Pendientes</div>
          </div>
        </div>
      </div>
      <div class="col-6 col-sm-4 col-lg-2">
        <div class="card bg-success">
          <div class="card-body p-3 text-center text-light">
            <div class="h1 m-0">{{$count_task_completed}}</div>
            <div class="mb-4">Completados</div>
          </div>
        </div>
      </div>
      <div class="col-6 col-sm-4 col-lg-2">
        <div class="card bg-info">
          <div class="card-body p-3 text-center text-light">
            <div class="h1 m-0">{{$count_task_project}}</div>
            <div class="mb-4">Mis Projectos</div>
          </div>
        </div>
      </div>
      <div class="col-6 col-sm-4 col-lg-2">
        <div class="card bg-warning">
          <div class="card-body p-3 text-center text-light">
            <div class="h1 m-0">{{$count_task_progreso}}</div>
            <div class="mb-4">En progreso</div>
          </div>
        </div>
      </div>
      <div class="col-6 col-sm-4 col-lg-2">
        <div class="card bg-danger">
          <div class="card-body p-3 text-center text-light">
            <div class="h1 m-0">{{$count_task_cancelado}}</div>
            <div class="mb-4">Cancelados</div>
          </div>
        </div>
      </div>
</div>
            <div class="box-tools">
                <button type="button" class="btn btn-block btn-primary btn-modal" 
                    data-href="{{action('ProjectController@add_task')}}" 
                    data-container=".location_add_modal1">
                    <i class="fa fa-plus"></i> @lang( 'messages.add' )</button>
            </div>
        @endslot
        <div class="table-responsive">
            <!-- <table class="table table-bordered table-striped" id="ncf_table">
                <thead>
                    <tr>
                        <th>@lang( 'invoice.prefix' )</th>
                        <th>@lang( 'invoice.desde' )</th>
                        <th>@lang( 'invoice.hasta' )</th>
                        <th>@lang( 'invoice.used' )</th>
                        <th>@lang( 'invoice.noautorizacion' )</th>
                       
                        <th>@lang( 'messages.action' )</th>
                    </tr>
                </thead>
            </table> -->

            <div class="table-responsive">
            <table class="table table-bordered table-striped" id="task_table">
         
                    <thead>
                        <tr>
                        <th>@lang( 'lang_v1.task_title' )</th>
                        <th>@lang( 'lang_v1.task_description' )</th>
                        <th>@lang( 'lang_v1.category_task' )</th>
                        <th>@lang( 'lang_v1.start_from' )</th>
                        <th>@lang( 'lang_v1.end_date_task' )</th>
                        <th>@lang( 'lang_v1.p_id_task' )</th>
                        <th>@lang( 'lang_v1.status' )</th>

                        <th>@lang( 'messages.action' )</th>
                        </tr>
                    </thead>
                </table>
        </div>
        </div>
    @endcomponent

    <div class="modal fade location_add_modal1" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>
    <div class="modal fade location_add_modal2" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>
    <div class="modal fade location_edit_modal1" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>
    <div class="modal fade location_view_modal1" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>
</section>
<!-- /.content -->

@endsection

@section('javascript')


<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>

<script src="{{ asset('public/js/BsMultiSelect.js') }}"></script> -->
<script>
var SITEURL = "{{action('ProjectController@Task_list')}}";
     $(document).ready(function(){
        $(document).on('click', '.edit_button', function(e) {
        e.preventDefault();
        
        $('div.location_edit_modal1').load($(this).attr('href'), function() {
            $(this).modal('show');
        });
    });
    $(document).on('click', '.view_button', function(e) {
        e.preventDefault();
        
        $('div.location_view_modal1').load($(this).attr('href'), function() {
            $(this).modal('show');
        });
    });
      var n = $('#task_table').DataTable({
        processing: true,
        serverSide: true,
        stateSave: true,

        ajax: {
          url: SITEURL,
         },        columnDefs: [
            {
                targets: 7,
                orderable: false,
                searchable: false,
            },
        ],
    });
    $('.dataTables_filter input').focus();

    $('.delete_button').on('click', function(e){
        e.preventDefault();
    swal({
        title: LANG.sure,
        icon: 'warning',
        buttons: true,
        dangerMode: true,
    }).then(willDelete => {
        if (willDelete) {
                        var href = $(this).attr('href');
                        $.ajax({
                            method: "DELETE",
                            url: href,
                            dataType: "json",
                            success: function(result){
                                if(result.success == true){
                                    toastr.success(result.msg);
                                    product_table.ajax.reload();
                                } else {
                                    toastr.error(result.msg);
                                }
                            }
                        });
                    }
    });
});
    $(document).on('shown.bs.modal','.modal', function (e) {
        $('form#id_task')
            .submit(function(e) {
                e.preventDefault();
            })
            .validate({
                rules: {
                 
                },
                messages: {
                   
                },
                submitHandler: function(form) {
                    e.preventDefault();
                    $(form)
                        .find('button[type="submit"]')
                        .attr('disabled', false);
                    var data = $(form).serialize();

                    $.ajax({
                        method: 'POST',
                        url: $(form).attr('action'),
                        dataType: 'json',
                        data: data,
                        success: function(result) {
                            if (result.success == true) {
                                $('div.location_add_modal1').modal('hide');
                                $('div.location_edit_modal1').modal('hide');
                                toastr.success(result.msg);
                                n.ajax.reload();
                            } else {
                                toastr.error(result.msg);
                            }
                        },
                    });
                },
            });
    });
});
           

</script>
@endsection