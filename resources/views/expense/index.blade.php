@extends('layouts.app')
@section('title', __('expense.expenses'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>@lang('expense.expenses')</h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            @component('components.filters', ['title' => __('report.filters')])
                <div class="col-md-3">
                    <div class="form-group">
                        {!! Form::label('location_id',  __('purchase.business_location') . ':') !!}
                        {!! Form::select('location_id', $business_locations, null, ['class' => 'form-control select2', 'style' => 'width:100%']); !!}
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        {!! Form::label('expense_for', __('expense.expense_for').':') !!}
                        {!! Form::select('expense_for', $users, null, ['class' => 'form-control select2']); !!}
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        {!! Form::label('expense_category_id',__('expense.expense_category').':') !!}
                        {!! Form::select('expense_category_id', $categories, null, ['placeholder' =>
                        __('report.all'), 'class' => 'form-control select2', 'style' => 'width:100%', 'id' => 'expense_category_id']); !!}
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        {!! Form::label('expense_date_range', __('report.date_range') . ':') !!}
                        {!! Form::text('date_range', @format_date('first day of this month') . ' ~ ' . @format_date('last day of this month') , ['placeholder' => __('lang_v1.select_a_date_range'), 'class' => 'form-control', 'id' => 'expense_date_range', 'readonly']); !!}
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        {!! Form::label('expense_payment_status',  __('purchase.payment_status') . ':') !!}
                        {!! Form::select('expense_payment_status', ['paid' => __('lang_v1.paid'), 'due' => __('lang_v1.due'), 'partial' => __('lang_v1.partial')], null, ['class' => 'form-control select2', 'style' => 'width:100%', 'placeholder' => __('lang_v1.all')]); !!}
                    </div>
                </div>
            @endcomponent
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            @component('components.widget', ['class' => 'box-primary', 'title' => __('expense.all_expenses')])
            <div class="box-tools1" style="position: absolute;right: 94px; top: 5px;">

            <a class="btn btn-primary" href="{{action('ExpenseCategoryController@index')}}"><i class="fa fa-circle-o"></i>@lang('expense.expense_categories')</a>

            </div>
                @can('category.create')
                    @slot('tool')
                        <div class="box-tools">
                            <a class="btn btn-block btn-primary" href="{{action('ExpenseController@create')}}">
                            <i class="fa fa-plus"></i> @lang('messages.add')</a>
                        </div>
                    @endslot
                @endcan
                @can('category.view')
                    <div class="table-responsive">
                    <input type="hidden" name="puede"  class="form-control" id="puede" value="{{$idencontrado}}">

                        <table class="table table-bordered table-striped" id="expense_table">
                            <thead>
                                <tr>
                                    <th>@lang('messages.action')</th>
                                    <th>@lang('messages.date')</th>
                                    <th>@lang('purchase.ref_no')</th>
                                    <th>@lang('expense.expense_category')</th>
                                    <th>@lang('business.location')</th>
                                    <th>@lang('sale.payment_status')</th>
                                    <th>@lang('product.tax')</th>
                                    <th>@lang('sale.total_amount')</th>
                                    <th>@lang('purchase.payment_due')
                                    <th>@lang('expense.expense_for')</th>
                                    <th>@lang('expense.expense_note')</th>
                                    <th>@lang('lang_v1.added_by')</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr class="bg-gray font-17 text-center footer-total">
                                    <td colspan="6"><strong>@lang('sale.total'):</strong></td>
                                    <td id="footer_payment_status_count"></td>
                                    <td><span class="display_currency" id="footer_expense_total" data-currency_symbol ="true"></span></td>
                                    <td><span class="display_currency" id="footer_total_due" data-currency_symbol ="true"></span></td>
                                    <td colspan="3"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                @endcan
            @endcomponent
        </div>
    </div>

</section>
<!-- /.content -->
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
@stop
@section('javascript')
 <script src="{{ asset('public/js/payment.js?v=' . $asset_v) }}"></script>
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