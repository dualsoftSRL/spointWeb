@extends('layouts.app')
@section('title', __( 'lang_v1.shipments'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header no-print">
    <h1>@lang( 'lang_v1.shipments')
    </h1>
</section>

<!-- Main content -->
<section class="content no-print">
    @component('components.filters', ['title' => __('report.filters')])
        <div class="col-md-3">
            <div class="form-group">
                {!! Form::label('shipping_status',  __('lang_v1.shipping_status') . ':') !!}

                {!! Form::select('shipping_status', $shipping_statuses, null, ['class' => 'form-control select2', 'style' => 'width:100%', 'placeholder' => __('lang_v1.all') ]); !!}
            </div>
        </div>
    @endcomponent
    @component('components.widget', ['class' => 'box-primary'])
        @if(auth()->user()->can('access_shipping'))
            <div class="table-responsive">
            <input type="hidden" name="puede"  class="form-control" id="puede" value="{{$idencontrado}}">

                <table class="table table-bordered table-striped ajax_view" id="sell_table">
                    <thead>
                        <tr>
                            <th>@lang('messages.date')</th>
                            <th>@lang('sale.invoice_no')</th>
                            <th>@lang('sale.customer_name')</th>
                            <th>@lang('sale.location')</th>
                            <th>@lang('lang_v1.shipping_status')</th>
                            <th>@lang('sale.payment_status')</th>
                            <th>@lang('messages.action')</th>
                        </tr>
                    </thead>
                </table>
            </div>
        @endif
    @endcomponent
</section>
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
<!-- /.content -->
<div class="modal fade payment_modal" tabindex="-1" role="dialog" 
    aria-labelledby="gridSystemModalLabel">
</div>

<div class="modal fade edit_payment_modal" tabindex="-1" role="dialog" 
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
        aaSorting: [[0, 'desc']],
        "ajax": {
            "url": "/sells",
            "data": function ( d ) {
                if($('#sell_list_filter_date_range').val()) {
                    var start = $('#sell_list_filter_date_range').data('daterangepicker').startDate.format('YYYY-MM-DD');
                    var end = $('#sell_list_filter_date_range').data('daterangepicker').endDate.format('YYYY-MM-DD');
                    d.start_date = start;
                    d.end_date = end;
                }
                d.only_shipments = true;
                d.shipping_status = $('#shipping_status').val();
            }
        },
        columnDefs: [ {
            "targets": [6],
            "orderable": false,
            "searchable": false
        } ],
        columns: [
            { data: 'transaction_date', name: 'transaction_date'  },
            { data: 'invoice_no', name: 'invoice_no'},
            { data: 'name', name: 'contacts.name'},
            { data: 'business_location', name: 'bl.name'},
            { data: 'shipping_status', name: 'shipping_status'},
            { data: 'payment_status', name: 'payment_status'},
            { data: 'action', name: 'action'}
        ],
        "fnDrawCallback": function (oSettings) {
            __currency_convert_recursively($('#sell_table'));
        },
        createdRow: function( row, data, dataIndex ) {
            $( row ).find('td:eq(4)').attr('class', 'clickable_td');
        }
    });

    $(document).on('change', '#shipping_status',  function() {
        sell_table.ajax.reload();
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
<script src="{{ asset('public/js/payment.js?v=' . $asset_v) }}"></script>
@endsection