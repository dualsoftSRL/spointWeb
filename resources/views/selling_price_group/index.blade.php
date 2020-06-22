@extends('layouts.app')
@section('title', __('lang_v1.selling_price_group'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>@lang( 'lang_v1.selling_price_group' )
    </h1>
    <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
    </ol> -->
</section>

<!-- Main content -->
<section class="content">
    @if (session('notification') || !empty($notification))
        <div class="row">
            <div class="col-sm-12">
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    @if(!empty($notification['msg']))
                        {{$notification['msg']}}
                    @elseif(session('notification.msg'))
                        {{ session('notification.msg') }}
                    @endif
                </div>
            </div>  
        </div>     
    @endif
    @component('components.widget', ['class' => 'box-primary', 'title' => __('lang_v1.import_export_selling_price_group_prices')])
            <div class="row">
                <div class="col-sm-6">
                    <a href="{{action('SellingPriceGroupController@export')}}" class="btn btn-primary">@lang('lang_v1.export_selling_price_group_prices')</a>
                </div>
                <div class="col-sm-6">
                    {!! Form::open(['url' => action('SellingPriceGroupController@import'), 'method' => 'post', 'enctype' => 'multipart/form-data' ]) !!}
                    <div class="form-group">
                        {!! Form::label('name', __( 'product.file_to_import' ) . ':') !!}
                        {!! Form::file('product_group_prices', ['required' => 'required']); !!}
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">@lang('messages.submit')</button>
                    </div>
                    {!! Form::close() !!}
                </div>
                <div class="col-sm-12">
                    <h4>@lang('lang_v1.instructions'):</h4>
                    <p>
                        &bull; @lang('lang_v1.price_group_import_istruction')
                    </p>
                    <p>
                        &bull; @lang('lang_v1.price_group_import_istruction1')
                    </p>
                    <p>
                        &bull; @lang('lang_v1.price_group_import_istruction2')
                    </p>
                </div>
            </div>
    @endcomponent
    @component('components.widget', ['class' => 'box-primary', 'title' => __( 'lang_v1.all_selling_price_group' )])
        @slot('tool')
            <div class="box-tools">
                <button type="button" class="btn btn-block btn-primary btn-modal" 
                    data-href="{{action('SellingPriceGroupController@create')}}" 
                    data-container=".view_modal">
                    <i class="fa fa-plus"></i> @lang( 'messages.add' )</button>
            </div>
        @endslot
        <div class="table-responsive">
        <input type="hidden" name="puede"  class="form-control" id="puede" value="{{$idencontrado}}">

            <table class="table table-bordered table-striped" id="selling_price_group_table">
                <thead>
                    <tr>
                        <th>@lang( 'lang_v1.name' )</th>
                        <th>@lang( 'lang_v1.description' )</th>
                        <th>@lang( 'messages.action' )</th>
                    </tr>
                </thead>
            </table>
        </div>
    @endcomponent
    
    <div class="modal fade brands_modal" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>
    <div id="miModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Contenido del modal -->
    <div class="modal-content">
      <div class="modal-header">
      <p style="text-align:center; font-weight:bold;">Otorgar Permiso</p>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        {!! Form::open(['url' => action('ProductController@User_Verifiy'), 'method' => 'post', 'id' => 'user_verifiy' ]) !!}
      <label for="user">Usuario:</label>
       <input type="text" name="user" id="user" class="form-control" autofocus>
       <label for="user">Contraseña:</label>

       <input type="password" name="password" id="password" class="form-control">
       <input type="submit" value="Permitir" class="btn btn-success" name="otorgar" id="otorgar" style="margin-top:30px;">

       
        {!! Form::close() !!}

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>
</section>
<!-- /.content -->
@stop
@section('javascript')
<script type="text/javascript">
    $(document).ready( function(){
        
        //selling_price_group_table
        var selling_price_group_table = $('#selling_price_group_table').DataTable({
                        processing: true,
                        serverSide: true,
                        ajax: '/selling-price-group',
                        columnDefs: [ {
                            "targets": 2,
                            "orderable": false,
                            "searchable": false
                        } ]
                    });

        $(document).on('submit', 'form#selling_price_group_form', function(e){
            e.preventDefault();
            var data = $(this).serialize();

            $.ajax({
                method: "POST",
                url: $(this).attr("action"),
                dataType: "json",
                data: data,
                success: function(result){
                    if(result.success == true){
                        $('div.view_modal').modal('hide');
                        toastr.success(result.msg);
                        selling_price_group_table.ajax.reload();
                    } else {
                        toastr.error(result.msg);
                    }
                }
            });
        });

        $(document).on('click', 'button.delete_spg_button', function(){
            swal({
              title: LANG.sure,
              icon: "warning",
              buttons: true,
              dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
                    var href = $(this).data('href');
                    var data = $(this).serialize();

                    $.ajax({
                        method: "DELETE",
                        url: href,
                        dataType: "json",
                        data: data,
                        success: function(result){
                            if(result.success == true){
                                toastr.success(result.msg);
                                selling_price_group_table.ajax.reload();
                            } else {
                                toastr.error(result.msg);
                            }
                        }
                    });
                }
            });
        });

        $(".buttons-colvis").click(function(){
    if($("#puede").val()!="Puede"){

      $("#miModal").modal("show");
$("ul.dt-button-collection").hide();

}

});

$("#otorgar").click(function(e){
          e.preventDefault();
        $.ajaxSetup({
             headers: {
                 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
             }
         });
      var form = $('form#user_verifiy')

var data = form.serialize();
    $.ajax({
        method: form.attr('method'),
        url: form.attr('action'),
        dataType: 'json',
        data: data,
        success: function(result) {
             // if (result.success == true) {
            //     toastr.success(result.msg);
               
            // } else {
            //     toastr.error(result.msg);
            // }
        },
        error: function (request, status, error) {
        // alert(request.responseText);
        if(request.responseText=="Otorgado"){
            $("#miModal").modal("hide");
            $("#puede").val("Puede");
            // $(".buttons-colvis").trigger('click');
            // $("ul.dt-button-collection").show();

        }else{
            if(request.responseText==""){
                alert("No tienes permiso de administrador para realizar esta acción");

            }else{
            alert("Creedenciales incorrectas");
            }
        }
    },
    });
      });

      $('#miModal').on('shown.bs.modal', function() {
  $(this).find('[autofocus]').focus();
});

    });
</script>
@endsection
