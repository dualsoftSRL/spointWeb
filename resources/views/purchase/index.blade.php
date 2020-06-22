@extends('layouts.app')
@section('title', __('purchase.purchases'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header no-print">
    <h1>@lang('purchase.purchases')
        <small></small>
    </h1>
    <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
    </ol> -->
</section>

<!-- Main content -->
<section class="content no-print">
    @component('components.filters', ['title' => __('report.filters')])
        <div class="col-md-3">
            <div class="form-group">
                {!! Form::label('purchase_list_filter_location_id',  __('purchase.business_location') . ':') !!}
                {!! Form::select('purchase_list_filter_location_id', $business_locations, null, ['class' => 'form-control select2', 'style' => 'width:100%', 'placeholder' => __('lang_v1.all')]); !!}
            </div>
        </div>
        <input type="hidden" name="puede"  class="form-control" id="puede" value="{{$idencontrado}}">

        <div class="col-md-3">
            <div class="form-group">
                {!! Form::label('purchase_list_filter_supplier_id',  __('purchase.supplier') . ':') !!}
                {!! Form::select('purchase_list_filter_supplier_id', $suppliers, null, ['class' => 'form-control select2', 'style' => 'width:100%', 'placeholder' => __('lang_v1.all')]); !!}
            </div>
        </div>
        <div class="col-md-3">
            <div class="form-group">
                {!! Form::label('purchase_list_filter_status',  __('purchase.purchase_status') . ':') !!}
                {!! Form::select('purchase_list_filter_status', $orderStatuses, null, ['class' => 'form-control select2', 'style' => 'width:100%', 'placeholder' => __('lang_v1.all')]); !!}
            </div>
        </div>
        <div class="col-md-3">
            <div class="form-group">
                {!! Form::label('purchase_list_filter_payment_status',  __('purchase.payment_status') . ':') !!}
                {!! Form::select('purchase_list_filter_payment_status', ['paid' => __('lang_v1.paid'), 'due' => __('lang_v1.due'), 'partial' => __('lang_v1.partial'), 'overdue' => __('lang_v1.overdue')], null, ['class' => 'form-control select2', 'style' => 'width:100%', 'placeholder' => __('lang_v1.all')]); !!}
            </div>
        </div>
        <div class="col-md-3">
            <div class="form-group">
                {!! Form::label('purchase_list_filter_date_range', __('report.date_range') . ':') !!}
                {!! Form::text('purchase_list_filter_date_range', null, ['placeholder' => __('lang_v1.select_a_date_range'), 'class' => 'form-control', 'readonly']); !!}
            </div>
        </div>
    @endcomponent

    @component('components.widget', ['class' => 'box-primary', 'title' => __('purchase.all_purchases')])
    @can('purchase.update')
    <div class="box-tools1" style="position: absolute;right: 94px; top: 5px;">

            <a class="btn btn-primary"  href="{{action('PurchaseReturnController@index')}}"><i class="fa fa-undo"></i> @lang('lang_v1.list_purchase_return')</a>
            </div>

            @endcan 
    @can('purchase.create')
            @slot('tool')
                <div class="box-tools">
                    <a class="btn btn-block btn-primary" href="{{action('PurchaseController@create')}}">
                    <i class="fa fa-plus"></i> @lang('messages.add')</a>
                </div>
            @endslot
        @endcan
        @can('purchase.view')
            <div class="table-responsive">
                <table class="table table-bordered table-striped ajax_view" id="purchase_table">
                    <thead>
                        <tr>
                            <th>@lang('messages.action')</th>
                            <th>@lang('messages.date')</th>
                            <th>@lang('purchase.ref_no')</th>
                            <th>@lang('purchase.location')</th>
                            <th>@lang('purchase.supplier')</th>
                            <th>@lang('purchase.purchase_status')</th>
                            <th>@lang('purchase.payment_status')</th>
                            <th>@lang('purchase.grand_total')</th>
                            <th>@lang('purchase.payment_due') &nbsp;&nbsp;<i class="fa fa-info-circle text-info no-print" data-toggle="tooltip" data-placement="bottom" data-html="true" data-original-title="{{ __('messages.purchase_due_tooltip')}}" aria-hidden="true"></i></th>
                            <th>@lang('lang_v1.added_by')</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr class="bg-gray font-17 text-center footer-total">
                            <td colspan="5"><strong>@lang('sale.total'):</strong></td>
                            <td id="footer_status_count"></td>
                            <td id="footer_payment_status_count"></td>
                            <td><span class="display_currency" id="footer_purchase_total" data-currency_symbol ="true"></span></td>
                            <td class="text-left"><small>@lang('report.purchase_due') - <span class="display_currency" id="footer_total_due" data-currency_symbol ="true"></span><br>
                            @lang('lang_v1.purchase_return') - <span class="display_currency" id="footer_total_purchase_return_due" data-currency_symbol ="true"></span>
                            </small></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        @endcan
    @endcomponent
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
    <div class="modal fade product_modal" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>

    <div class="modal fade payment_modal" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>

    <div class="modal fade edit_payment_modal" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>

    @include('purchase.partials.update_purchase_status_modal')

</section>

<section id="receipt_section" class="print_section"></section>

<!-- /.content -->
@stop
@section('javascript')
<script src="{{ asset('public/js/purchase.js?v=' . $asset_v) }}"></script>
<script src="{{ asset('public/js/payment.js?v=' . $asset_v) }}"></script>
<script>
        //Date range as a button
    $('#purchase_list_filter_date_range').daterangepicker(
        dateRangeSettings,
        function (start, end) {
            $('#purchase_list_filter_date_range').val(start.format(moment_date_format) + ' ~ ' + end.format(moment_date_format));
           purchase_table.ajax.reload();
        }
    );
    $('#purchase_list_filter_date_range').on('cancel.daterangepicker', function(ev, picker) {
        $('#purchase_list_filter_date_range').val('');
        purchase_table.ajax.reload();
    });

    $(document).on('click', '.update_status', function(e){
        e.preventDefault();
        $('#update_purchase_status_form').find('#status').val($(this).data('status'));
        $('#update_purchase_status_form').find('#purchase_id').val($(this).data('purchase_id'));
        $('#update_purchase_status_modal').modal('show');
    });

    $(document).on('submit', '#update_purchase_status_form', function(e){
        e.preventDefault();
        $(this)
            .find('button[type="submit"]')
            .attr('disabled', true);
        var data = $(this).serialize();

        $.ajax({
            method: 'POST',
            url: $(this).attr('action'),
            dataType: 'json',
            data: data,
            success: function(result) {
                if (result.success == true) {
                    $('#update_purchase_status_modal').modal('hide');
                    toastr.success(result.msg);
                    purchase_table.ajax.reload();
                    $('#update_purchase_status_form')
                        .find('button[type="submit"]')
                        .attr('disabled', false);
                } else {
                    toastr.error(result.msg);
                }
            },
        });
    });
</script>
	<script>
    $(document).ready(function(){

    
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
    });
    $('#miModal').on('shown.bs.modal', function() {
  $(this).find('[autofocus]').focus();
});
    
    </script>
@endsection