@extends('layouts.app')
@section('title', __( 'sale.list_pos'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header no-print">
    <h1>POS
    </h1>
</section>

<!-- Main content -->
<section class="content no-print">
    @component('components.filters', ['title' => __('report.filters')])
        @include('sell.partials.sell_list_filters')
    @endcomponent

    @component('components.widget', ['class' => 'box-primary', 'title' => __( 'sale.list_pos')])
        @can('sell.create')
            @slot('tool')
                <div class="box-tools">
                    <a class="btn btn-block btn-primary" href="{{action('SellPosController@create')}}">
                    <i class="fa fa-plus"></i> @lang('messages.add')</a>
                </div>
            @endslot
        @endcan
        @can('sell.view')
            <div class="table-responsive">
            <input type="hidden" name="puede"  class="form-control" id="puede" value="{{$idencontrado}}">

                <table class="table table-bordered table-striped ajax_view" id="sell_table">
                    <thead>
                        <tr>
                        <th>@lang('messages.action')</th>
                            <th>@lang('messages.date')</th>
                            <th>@lang('sale.invoice_no')</th>
                            <th style="width: 200px; min-width: 200px;">@lang('sale.customer_name')</th>
                            <th style="width: 130px; min-width: 130px;">@lang('lang_v1.contact_no')</th>
                            <th>@lang('sale.location')</th>
                            <th style="width: 130px; min-width: 130px;">@lang('sale.payment_status')</th>
                            <th style="width: 100px; min-width: 100px;">@lang('lang_v1.payment_method')</th>
                            <th style="width: 90px; min-width: 90px;">@lang('sale.total_amount')</th>
                            <th style="width: 90px; min-width: 90px;">@lang('sale.total_paid')</th>
                            <th style="width: 90px; min-width: 90px;">@lang('lang_v1.sell_due')</th>
                            <th style="width: 130px; min-width: 130px;">@lang('lang_v1.sell_return_due')</th>
                            <th style="width: 120px; min-width: 120px;">@lang('lang_v1.shipping_status')</th>
                            <th style="width: 110px; min-width: 110px;">@lang('lang_v1.total_items')</th>
                            <th style="width: 90px; min-width: 90px;">@lang('lang_v1.types_of_service')</th>
                            <th style="width: 120px; min-width: 120px;">@lang('lang_v1.third_party_order_id')</th>
                            <th>@lang('lang_v1.added_by')</th>
                            <th style="width: 120px; min-width: 120px;">@lang('sale.sell_note')</th>
                            <th style="width: 90px; min-width: 90px;">@lang('sale.staff_note')</th>
                            <th style="width: 90px; min-width: 90px;">@lang('sale.shipping_details')</th>
                            <th>@lang('restaurant.table')</th>
                            <th>@lang('restaurant.service_staff')</th>
                            <th>@lang('invoice.ncflist')</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr class="bg-gray font-17 footer-total text-center">
                            <td colspan="6"><strong>@lang('sale.total'):</strong></td>
                            <td id="footer_payment_status_count"></td>
                            <td id="payment_method_count"></td>
                            <td><span class="display_currency" id="footer_sale_total" data-currency_symbol ="true"></span></td>
                            <td><span class="display_currency" id="footer_total_paid" data-currency_symbol ="true"></span></td>
                            <td><span class="display_currency" id="footer_total_remaining" data-currency_symbol ="true"></span></td>
                            <td><span class="display_currency" id="footer_total_sell_return_due" data-currency_symbol ="true"></span></td>
                            <td colspan="2"></td>
                            <td id="service_type_count"></td>
                            <td colspan="7"></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        @endcan
    @endcomponent
</section>
<!-- /.content -->
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
<div class="modal fade payment_modal" tabindex="-1" role="dialog" 
    aria-labelledby="gridSystemModalLabel">
</div>

<div class="modal fade edit_payment_modal" tabindex="-1" role="dialog" 
    aria-labelledby="gridSystemModalLabel">
</div>

<div class="modal fade register_details_modal" tabindex="-1" role="dialog" 
    aria-labelledby="gridSystemModalLabel">
</div>
<div class="modal fade close_register_modal" tabindex="-1" role="dialog" 
    aria-labelledby="gridSystemModalLabel">
</div>

<!-- This will be printed -->
<!-- <section class="invoice print_section" id="receipt_section">
</section> -->


@stop

@section('javascript')
<script type="text/javascript">
$(document).ready( function(){
    //Date range as a button
    $('#sell_list_filter_date_range').daterangepicker(
        dateRangeSettings,
        function (start, end) {
            $('#sell_list_filter_date_range').val(start.format(moment_date_format) + ' ~ ' + end.format(moment_date_format));
            sell_table.ajax.reload();
        }
    );
    $('#sell_list_filter_date_range').on('cancel.daterangepicker', function(ev, picker) {
        $('#sell_list_filter_date_range').val('');
        sell_table.ajax.reload();
    });
    
    sell_table = $('#sell_table').DataTable({
        processing: true,
        serverSide: true,
        stateSave: true,

        aaSorting: [[1, 'desc']],
        "ajax": {
            "url": "/sells",
            "data": function ( d ) {
                if($('#sell_list_filter_date_range').val()) {
                    var start = $('#sell_list_filter_date_range').data('daterangepicker').startDate.format('YYYY-MM-DD');
                    var end = $('#sell_list_filter_date_range').data('daterangepicker').endDate.format('YYYY-MM-DD');
                    d.start_date = start;
                    d.end_date = end;
                }
                d.is_direct_sale = 0;

                d.location_id = $('#sell_list_filter_location_id').val();
                d.customer_id = $('#sell_list_filter_customer_id').val();
                d.payment_status = $('#sell_list_filter_payment_status').val();
                d.created_by = $('#created_by').val();
                d.sales_cmsn_agnt = $('#sales_cmsn_agnt').val();
                d.service_staffs = $('#service_staffs').val();
            }
        },
        columns: [
            { data: 'action', name: 'action', orderable: false, "searchable": false},
            { data: 'transaction_date', name: 'transaction_date'  },
            { data: 'invoice_no', name: 'invoice_no'},
            { data: 'name', name: 'contacts.name'},
            { data: 'mobile', name: 'contacts.mobile'},
            { data: 'business_location', name: 'bl.name'},
            { data: 'payment_status', name: 'payment_status'},
            { data: 'payment_methods', orderable: false, "searchable": false},
            { data: 'final_total', name: 'final_total'},
            { data: 'total_paid', name: 'total_paid', "searchable": false},
            { data: 'total_remaining', name: 'total_remaining'},
            { data: 'return_due', orderable: false, "searchable": false},
            { data: 'shipping_status', name: 'shipping_status'},
            { data: 'total_items', name: 'total_items', "searchable": false},
            { data: 'types_of_service_name', name: 'tos.name'},
            { data: 'service_custom_field_1', name: 'service_custom_field_1'},
            { data: 'added_by', name: 'u.first_name'},
            { data: 'additional_notes', name: 'additional_notes'},
            { data: 'staff_note', name: 'staff_note'},
            { data: 'shipping_details', name: 'shipping_details'},
            { data: 'table_name', name: 'tables.name', @if(empty($is_tables_enabled)) visible: false @endif },
            { data: 'waiter', name: 'ss.first_name', @if(empty($is_service_staff_enabled)) visible: false @endif },
            { data: 'ncf', name: 'ncf'}

        ],
        "fnDrawCallback": function (oSettings) {
            
            $('#footer_sale_total').text(sum_table_col($('#sell_table'), 'final-total'));

            $('#footer_total_paid').text(sum_table_col($('#sell_table'), 'total-paid'));

            $('#footer_total_remaining').text(sum_table_col($('#sell_table'), 'payment_due'));
            $('#footer_total_sell_return_due').text(sum_table_col($('#sell_table'), 'sell_return_due'));

            $('#footer_payment_status_count ').html(__sum_status_html($('#sell_table'), 'payment-status-label'));
            $('#service_type_count').html(__sum_status_html($('#sell_table'), 'service-type-label'));
            $('#payment_method_count').html(__sum_status_html($('#sell_table'), 'payment-method'));

            __currency_convert_recursively($('#sell_table'));
        },
        createdRow: function( row, data, dataIndex ) {
            $( row ).find('td:eq(6)').attr('class', 'clickable_td');
        }
    });
    $('.dataTables_filter input').focus();


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
    

    $(document).on('change', '#sell_list_filter_location_id, #sell_list_filter_customer_id, #sell_list_filter_payment_status, #created_by, #sales_cmsn_agnt, #service_staffs',  function() {
        sell_table.ajax.reload();
    });
});

</script>
<script src="{{ asset('public/js/payment.js?v=' . $asset_v) }}"></script>
@endsection