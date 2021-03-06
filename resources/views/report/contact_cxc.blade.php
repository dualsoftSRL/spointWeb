@extends('layouts.app')
@section('title', __('report.customer') . ' - ' . __('report.supplier') . ' ' . __('report.reports'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>{{ __('report.customer')}} {{ __('report.reports')}}</h1>
    <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
    </ol> -->
</section>

<!-- Main content -->
<section class="content">

    <div class="row" hidden>
        <div class="col-md-12">
            @component('components.filters', ['title' => __('report.filters')])

                <div class="col-md-3" hidden>
                    <div class="form-group">
                        {!! Form::label('cg_customer_group_id', __( 'lang_v1.customer_group_name' ) . ':') !!}
                        {!! Form::select('cnt_customer_group_id', $customer_group, null, ['class' => 'form-control select2', 'style' => 'width:100%', 'id' => 'cnt_customer_group_id']); !!}
                    </div>
                </div>

                <div class="col-md-3" hidden>
                    <div class="form-group">
                        {!! Form::label('type', __( 'lang_v1.type' ) . ':') !!}
                        {!! Form::select('contact_type', $types, null, ['class' => 'form-control select2', 'style' => 'width:100%', 'id' => 'contact_type']); !!}
                    </div>
                </div>

            @endcomponent
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            @component('components.widget', ['class' => 'box-primary'])
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="supplier_report_tbl1">
                    <thead>
                        <tr>
                            <th>@lang('report.contact')</th>
                            <th>@lang('report.total_due')</th>
                            <th>@lang('lang_v1.0_15')</th>
                            <th>@lang('lang_v1.15_30')</th>
                             <th>@lang('lang_v1.30_45')</th>
                            <th>@lang('lang_v1.45_60')</th>
                            <th>@lang('lang_v1.60+')</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr class="bg-gray font-17 footer-total text-center">
                            <td><strong>@lang('sale.total'):</strong></td>
                            <td><span class="display_currency" id="footer_total_purchase" data-currency_symbol ="true"></span></td>
                            <td><span class="display_currency" id="footer_total_purchase_return" data-currency_symbol ="true"></span></td>
                            <td><span class="display_currency" id="footer_total_sell" data-currency_symbol ="true"></span></td>
                            <td><span class="display_currency" id="footer_total_sell_return" data-currency_symbol ="true"></span></td>
                            <td><span class="display_currency" id="footer_total_opening_bal_due" data-currency_symbol ="true"></span></td>
                            <td><span class="display_currency" id="footer_total_due" data-currency_symbol ="true"></span></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            @endcomponent
        </div>
    </div>
</section>
<!-- /.content -->

<div class="modal fade location_add_modal1" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>
@endsection

@section('javascript')
<script src="{{ asset('public/js/functions.js') }}"></script>

    <script src="{{ asset('public/js/report.js?v=' . $asset_v) }}"></script>
    <script>
    $(document).ready(function(){
        $(document).on('click', '.showdetail_contact_button', function(e) {
        e.preventDefault();
        $('div.location_add_modal1').load($(this).attr('href'), function() {

            $(this).modal('show');
        });
    });
 
        if($('#supplier_report_tbl1').length != 0){
        $("#contact_type").val('customer').trigger('change');
        supplier_report_tbl1.ajax.reload();

        $('#customer_group_id, #contact_type').change(function() {
            supplier_report_tbl1.ajax.reload();
        });
    }
    });
    </script>
@endsection