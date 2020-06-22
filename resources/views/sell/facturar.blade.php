@extends('layouts.app')

@section('title', __('sale.add_sale'))

@section('content')
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>@lang('sale.add_sale')</h1>
</section>
<!-- Main content -->
<section class="content no-print">
@if(!empty($pos_settings['allow_overselling']))
	<input type="hidden" id="is_overselling_allowed">
@endif
@if(session('business.enable_rp') == 1)
    <input type="hidden" id="reward_point_enabled">
@endif
@if(is_null($default_location))
<div class="row">
	<div class="col-sm-3">
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon">
					<i class="fa fa-map-marker"></i>
				</span>
			{!! Form::select('select_location_id', $business_locations, null, ['class' => 'form-control input-sm', 
			'placeholder' => __('lang_v1.select_location'),
			'id' => 'select_location_id', 
			'required', 'autofocus'], $bl_attributes); !!}
			<span class="input-group-addon">
					@show_tooltip(__('tooltip.sale_location'))
				</span> 
			</div>
		</div>
	</div>
</div>
@endif
<input type="hidden" id="item_addition_method" value="{{$business_details->item_addition_method}}">
	{!! Form::open(['url' => action('SellPosController@store'), 'method' => 'post', 'id' => 'add_sell_form' ]) !!}
	<div class="row">
		<div class="col-md-12 col-sm-12">
			@component('components.widget', ['class' => 'box-primary'])
				{!! Form::hidden('location_id', $default_location, ['id' => 'location_id', 'data-receipt_printer_type' => isset($bl_attributes[$default_location]['data-receipt_printer_type']) ? $bl_attributes[$default_location]['data-receipt_printer_type'] : 'browser']); !!}

				@if(!empty($price_groups))
					@if(count($price_groups) > 1)
						<div class="col-sm-4">
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon">
										<i class="fa fa-money"></i>
									</span>
									@php
										reset($price_groups);
									@endphp
									{!! Form::hidden('hidden_price_group', key($price_groups), ['id' => 'hidden_price_group']) !!}
									{!! Form::select('price_group', $price_groups, null, ['class' => 'form-control select2', 'id' => 'price_group']); !!}
									<span class="input-group-addon">
										@show_tooltip(__('lang_v1.price_group_help_text'))
									</span> 
								</div>
							</div>
						</div>
						
					@else
						@php
							reset($price_groups);
						@endphp
						{!! Form::hidden('price_group', key($price_groups), ['id' => 'price_group']) !!}
					@endif
				@endif

				{!! Form::hidden('default_price_group', null, ['id' => 'default_price_group']) !!}

				@if(in_array('types_of_service', $enabled_modules) && !empty($types_of_service))
					<div class="col-md-4 col-sm-6">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">
									<i class="fa fa-external-link text-primary service_modal_btn"></i>
								</span>
								{!! Form::select('types_of_service_id', $types_of_service, null, ['class' => 'form-control', 'id' => 'types_of_service_id', 'style' => 'width: 100%;', 'placeholder' => __('lang_v1.select_types_of_service')]); !!}

								{!! Form::hidden('types_of_service_price_group', null, ['id' => 'types_of_service_price_group']) !!}

								<span class="input-group-addon">
									@show_tooltip(__('lang_v1.types_of_service_help'))
								</span> 
							</div>
							<small><p class="help-block hide" id="price_group_text">@lang('lang_v1.price_group'): <span></span></p></small>
						</div>
					</div>
					<div class="modal fade types_of_service_modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel"></div>
				@endif
				
				@if(in_array('subscription', $enabled_modules))
					<div class="col-md-4 pull-right col-sm-6">
						<div class="checkbox">
							<label>
				              {!! Form::checkbox('is_recurring', 1, false, ['class' => 'input-icheck', 'id' => 'is_recurring']); !!} @lang('lang_v1.subscribe')?
				            </label><button type="button" data-toggle="modal" data-target="#recurringInvoiceModal" class="btn btn-link"><i class="fa fa-external-link"></i></button>@show_tooltip(__('lang_v1.recurring_invoice_help'))
						</div>
					</div>
				@endif
				<div class="clearfix"></div>
				<div class="@if(!empty($commission_agent)) col-sm-3 @else col-sm-4 @endif">
					<div class="form-group">
						{!! Form::label('contact_id', __('contact.customer') . ':*') !!}
						<div class="input-group">
							<span class="input-group-addon">
								<i class="fa fa-user"></i>
							</span>
							<input type="hidden" id="default_customer_id" 
							value="{{ $walk_in_customer1['id']}}" >
							<input type="hidden" id="default_customer_name" 
							value="{{ $walk_in_customer1['name']}}" >
							<input type="hidden" id="tokenprueba" name="tokenprueba" value="{{$ultimoid}}">

							{!! Form::select('contact_id', 
								[], null, ['class' => 'form-control mousetrap', 'id' => 'customer_id', 'placeholder' => 'Enter Customer name / phone', 'required']); !!}
							<span class="input-group-btn">
								<button type="button" class="btn btn-default bg-white btn-flat add_new_customer" data-name=""><i class="fa fa-plus-circle text-primary fa-lg"></i></button>
							</span>
						</div>
					</div>
				</div>

				<div class="col-md-3">
		          <div class="form-group">
		            <div class="multi-input">
		              {!! Form::label('pay_term_number', __('contact.pay_term') . ':') !!} @show_tooltip(__('tooltip.pay_term'))
		              <br/>
		              {!! Form::number('pay_term_number', $walk_in_customer['pay_term_number'], ['class' => 'form-control width-40 pull-left', 'placeholder' => __('contact.pay_term')]); !!}

		              {!! Form::select('pay_term_type', 
		              	['months' => __('lang_v1.months'), 
		              		'days' => __('lang_v1.days')], 
		              		$walk_in_customer['pay_term_type'], 
		              	['class' => 'form-control width-60 pull-left','placeholder' => __('messages.please_select')]); !!}
		            </div>
		          </div>
		        </div>

				@if(!empty($commission_agent))
				<div class="col-sm-3">
					<div class="form-group">
					{!! Form::label('commission_agent', __('lang_v1.commission_agent') . ':') !!}
					{!! Form::select('commission_agent', 
								$commission_agent, null, ['class' => 'form-control select2']); !!}
					</div>
				</div>
				@endif
				<div class="@if(!empty($commission_agent)) col-sm-3 @else col-sm-4 @endif">
					<div class="form-group">
						{!! Form::label('transaction_date', __('sale.sale_date') . ':*') !!}
						<div class="input-group">
							<span class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</span>
							{!! Form::text('transaction_date', $default_datetime, ['class' => 'form-control', 'readonly', 'required']); !!}
						</div>
					</div>
				</div>
				<div class="@if(!empty($commission_agent)) col-sm-3 @else col-sm-4 @endif">
					<div class="form-group">
						{!! Form::label('status', __('sale.status') . ':*') !!}
						{!! Form::select('status', ['final' => __('sale.final'), 'draft' => __('sale.draft'), 'quotation' => __('lang_v1.quotation')], null, ['class' => 'form-control select2', 'placeholder' => __('messages.please_select'), 'required']); !!}
					</div>
				</div>
				<div class="col-sm-3">
					<div class="form-group">
						{!! Form::label('invoice_scheme_id', __('invoice.invoice_scheme') . ':') !!}
						{!! Form::select('invoice_scheme_id', $invoice_schemes, $default_invoice_schemes->id, ['class' => 'form-control select2', 'placeholder' => __('messages.please_select')]); !!}
					</div>
				</div>
				<div class="col-sm-3" hidden>
					<div class="form-group">
						{!! Form::label('mcomprobante', __('invoice.manejocomprobante') . ':') !!}
						{!! Form::select('mcomprobante', $manejocomprobante, null, ['class' => 'form-control select2', 'placeholder' => __('messages.please_select')]); !!}
					</div>
				</div>
				<div class="col-sm-4" id="ncfmostrar">
					<div class="form-group" >
						{!! Form::label('idncf', __('invoice.ncf1') . ':') !!}
						{!! Form::select('idncf', $idncf, null, ['class' => 'form-control select2', 'placeholder' => __('messages.noncf')]); !!}
					</div>
				</div>
				<div class="col-sm-4" id="codigomostrarncf">
					<div class="form-group">
						{!! Form::label('comprobante', __('invoice.comprobante') . ':') !!}
						{!! Form::text('comprobante', null, ['class' => 'form-control', 'placeholder' => __('invoice.comprobante'),'readonly' => 'true']); !!}
					</div>
					<div class="form-group" hidden>
						{!! Form::label('secuencia', __('invoice.secuencia') . ':') !!}
						{!! Form::text('secuencia', null, ['class' => 'form-control', 'placeholder' => __('invoice.comprobante')]); !!}
					</div>
					<div class="form-group" hidden>
						{!! Form::label('idsecuencia', __('invoice.idsecuencia') . ':') !!}
						{!! Form::text('idsecuencia', null, ['class' => 'form-control', 'placeholder' => __('invoice.comprobante')]); !!}
					</div>
				</div>
				<div class="clearfix"></div>
				<!-- Call restaurant module if defined -->
		        @if(in_array('tables' ,$enabled_modules) || in_array('service_staff' ,$enabled_modules))
		        	<span id="restaurant_module_span">
		          		<div class="col-md-3"></div>
		        	</span>
		        @endif
			@endcomponent

			@component('components.widget', ['class' => 'box-primary'])
				<div class="col-sm-10 col-sm-offset-1">
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-default bg-white btn-flat" data-toggle="modal" data-target="#configure_search_modal" title="{{__('lang_v1.configure_product_search')}}"><i class="fa fa-barcode"></i></button>
							</div>
							{!! Form::text('search_product', null, ['class' => 'form-control mousetrap', 'id' => 'search_product', 'placeholder' => __('lang_v1.search_product_placeholder'),
							'disabled' => is_null($default_location)? true : false,
							'autofocus' => is_null($default_location)? false : true,
							]); !!}
							<span class="input-group-btn">
								<button type="button" class="btn btn-default bg-white btn-flat pos_add_quick_product" data-href="{{action('ProductController@quickAdd')}}" data-container=".quick_add_product_modal"><i class="fa fa-plus-circle text-primary fa-lg"></i></button>
							</span>
						</div>
					</div>
				</div>

				<div class="row col-sm-12 pos_product_div" style="min-height: 0">

					<input type="hidden" name="sell_price_tax" id="sell_price_tax" value="{{$business_details->sell_price_tax}}">

					<!-- Keeps count of product rows -->
					<input type="hidden" id="product_row_count" 
						value="0">
					@php
						$hide_tax = '';
						if( session()->get('business.enable_inline_tax') == 0){
							$hide_tax = 'hide';
						}
					@endphp
					<div class="table-responsive">
					<table class="table table-condensed table-bordered table-striped table-responsive" id="pos_table">
						<thead>
							<tr>
								<th class="text-center">	
									@lang('sale.product')
								</th>
								<th class="text-center">
									@lang('sale.qty')
								</th>
								@if(!empty($pos_settings['inline_service_staff']))
									<th class="text-center">
										@lang('restaurant.service_staff')
									</th>
								@endif
								<th class="text-center {{$hide_tax}}">
									@lang('sale.price_inc_tax')
								</th>
								<th class="text-center">
									@lang('sale.subtotal')
								</th>
								<th class="text-center"><i class="fa fa-close" aria-hidden="true"></i></th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
					</div>
					<div class="table-responsive">
					<table class="table table-condensed table-bordered table-striped">
						<tr>
							<td>
								<div class="pull-right">
								<b>@lang('sale.item'):</b> 
								<span class="total_quantity">0</span>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<b>@lang('sale.total'): </b>
									<span class="price_total">0</span>
								</div>
							</td>
						</tr>
					</table>
					</div>
				</div>
			@endcomponent

			@component('components.widget', ['class' => 'box-primary'])
				<div class="col-md-4">
			        <div class="form-group">
			            {!! Form::label('discount_type', __('sale.discount_type') . ':*' ) !!}
			            <div class="input-group">
			                <span class="input-group-addon">
			                    <i class="fa fa-info"></i>
			                </span>
			                {!! Form::select('discount_type', ['fixed' => __('lang_v1.fixed'), 'percentage' => __('lang_v1.percentage')], 'percentage' , ['class' => 'form-control','placeholder' => __('messages.please_select'), 'required', 'data-default' => 'percentage']); !!}
			            </div>
			        </div>
			    </div>
			    <div class="col-md-4">
			        <div class="form-group">
			            {!! Form::label('discount_amount', __('sale.discount_amount') . ':*' ) !!}
			            <div class="input-group">
			                <span class="input-group-addon">
			                    <i class="fa fa-info"></i>
			                </span>
			                {!! Form::text('discount_amount', @num_format($business_details->default_sales_discount), ['class' => 'form-control input_number', 'data-default' => $business_details->default_sales_discount]); !!}
			            </div>
			        </div>
			    </div>
			    <div class="col-md-4"><br>
			    	<b>@lang( 'sale.discount_amount' ):</b>(-) 
					<span class="display_currency" id="total_discount">0</span>
			    </div>
			    <div class="clearfix"></div>
			    <div class="col-md-12 well well-sm bg-light-gray @if(session('business.enable_rp') != 1) hide @endif">
			    	<input type="hidden" name="rp_redeemed" id="rp_redeemed" value="0">
			    	<input type="hidden" name="rp_redeemed_amount" id="rp_redeemed_amount" value="0">
			    	<div class="col-md-12"><h4>{{session('business.rp_name')}}</h4></div>
			    	<div class="col-md-4">
				        <div class="form-group">
				            {!! Form::label('rp_redeemed_modal', __('lang_v1.redeemed') . ':' ) !!}
				            <div class="input-group">
				                <span class="input-group-addon">
				                    <i class="fa fa-gift"></i>
				                </span>
				                {!! Form::number('rp_redeemed_modal', 0, ['class' => 'form-control direct_sell_rp_input', 'data-amount_per_unit_point' => session('business.redeem_amount_per_unit_rp'), 'min' => 0, 'data-max_points' => 0, 'data-min_order_total' => session('business.min_order_total_for_redeem') ]); !!}
				                <input type="hidden" id="rp_name" value="{{session('business.rp_name')}}">
				            </div>
				        </div>
				    </div>
				    <div class="col-md-4">
				    	<p><strong>@lang('lang_v1.available'):</strong> <span id="available_rp">0</span></p>
				    </div>
				    <div class="col-md-4">
				    	<p><strong>@lang('lang_v1.redeemed_amount'):</strong> (-)<span id="rp_redeemed_amount_text">0</span></p>
				    </div>
			    </div>
			    <div class="clearfix"></div>
			    <div class="col-md-4" hidden>
			    	<div class="form-group">
			            {!! Form::label('tax_rate_id', __('sale.order_tax') . ':*' ) !!}
			            <div class="input-group">
			                <span class="input-group-addon">
			                    <i class="fa fa-info"></i>
			                </span>
			                {!! Form::select('tax_rate_id', $taxes['tax_rates'], $business_details->default_sales_tax, ['placeholder' => __('messages.please_select'), 'class' => 'form-control', 'data-default'=> $business_details->default_sales_tax], $taxes['attributes']); !!}

							<input type="hidden" name="tax_calculation_amount" id="tax_calculation_amount" 
							value="@if(empty($edit)) {{@num_format($business_details->tax_calculation_amount)}} @else {{@num_format(optional($transaction->tax)->amount)}} @endif" data-default="{{$business_details->tax_calculation_amount}}">
			            </div>
			        </div>
			    </div>
			    <div class="col-md-4 col-md-offset-4">
			    	<b>@lang( 'sale.order_tax' ):</b>(+) 
					<span class="display_currency" id="order_tax">0</span>
			    </div>
			    <div class="clearfix"></div>
				<div class="col-md-4">
					<div class="form-group">
			            {!! Form::label('shipping_details', __('sale.shipping_details')) !!}
			            <div class="input-group">
							<span class="input-group-addon">
			                    <i class="fa fa-info"></i>
			                </span>
			                {!! Form::textarea('shipping_details',null, ['class' => 'form-control','placeholder' => __('sale.shipping_details') ,'rows' => '1', 'cols'=>'30']); !!}
			            </div>
			        </div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
			            {!! Form::label('shipping_address', __('lang_v1.shipping_address')) !!}
			            <div class="input-group">
							<span class="input-group-addon">
			                    <i class="fa fa-map-marker"></i>
			                </span>
			                {!! Form::textarea('shipping_address',null, ['class' => 'form-control','placeholder' => __('lang_v1.shipping_address') ,'rows' => '1', 'cols'=>'30']); !!}
			            </div>
			        </div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						{!!Form::label('shipping_charges', __('sale.shipping_charges'))!!}
						<div class="input-group">
						<span class="input-group-addon">
						<i class="fa fa-info"></i>
						</span>
						{!!Form::text('shipping_charges',@num_format(0.00),['class'=>'form-control input_number','placeholder'=> __('sale.shipping_charges')]);!!}
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
			            {!! Form::label('shipping_status', __('lang_v1.shipping_status')) !!}
			            {!! Form::select('shipping_status',$shipping_statuses, null, ['class' => 'form-control','placeholder' => __('messages.please_select')]); !!}
			        </div>
				</div>
				<div class="col-md-4">
			        <div class="form-group">
			            {!! Form::label('delivered_to', __('lang_v1.delivered_to') . ':' ) !!}
			            {!! Form::text('delivered_to', null, ['class' => 'form-control','placeholder' => __('lang_v1.delivered_to')]); !!}
			        </div>
			    </div>
				<div class="clearfix"></div>
			    <div class="col-md-4 col-md-offset-8">
			    	<div><b>@lang('sale.total_payable'): </b>
						<input type="hidden" name="final_total" id="final_total_input">
						<span id="total_payable">0</span>
					</div>
			    </div>
			    <div class="col-md-12">
			    	<div class="form-group">
						{!! Form::label('sell_note',__('sale.sell_note')) !!}
						{!! Form::textarea('sale_note', null, ['class' => 'form-control', 'rows' => 3]); !!}
					</div>
			    </div>
				<div class="col-md-12" hidden>
			    	<div class="form-group">
						{!! Form::label('sell_note',__('sale.sell_note')) !!}
						<input type="hidden" name="credit_enable" value="" id="credito_tiene">

					</div>
			    </div>
				<div class="col-md-12">
			    	<div class="form-group">
						{!! Form::label('permitir',__('sale.Sell_credit')) !!}
<select class="form-control" name="permitir_credito" id="permitir">
<option value='si'>Venta a crédito</option>
<option value='no'>Realizar pago</option>
</select>
					</div>
			    </div>
				<input type="hidden" name="is_direct_sale" value="1">
			@endcomponent

		</div>
	</div>
	@can('sell.payments')
		@component('components.widget', ['class' => 'box-primary', 'id' => "payment_rows_div", 'title' => __('purchase.add_payment')])
		<div class="payment_row">
			@include('sale_pos.partials.payment_row_form', ['row_index' => 0])
			<hr>
			<div class="row">
				<div class="col-sm-12">
					<div class="pull-right"><strong>@lang('lang_v1.balance'):</strong> <span class="balance_due">0.00</span></div>
				</div>
			</div>
		</div>
		
		@endcomponent
	@endcan
	
	<div class="row">
	<input id="is_save_and_print" name="is_save_and_print" type="hidden" value="0">
		<div class="col-sm-12 text-righ">
			<button type="button" id="submit-sell" class="btn btn-primary pull-right btn-flat">@lang('messages.submit')</button>
			<!-- <button type="button" id="save-and-print" class="btn btn-primary btn-flat">Save and print</button> -->
		</div>
	</div>
	
	@if(empty($pos_settings['disable_recurring_invoice']))
		@include('sale_pos.partials.recurring_invoice_modal')
	@endif
	<div class="div-overlay pos-processing"></div>

	{!! Form::close() !!}
</section>

<div class="modal fade contact_modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
	@include('contact.create', ['quick_add' => true])
</div>
<!-- /.content -->
<div class="modal fade register_details_modal" tabindex="-1" role="dialog" 
	aria-labelledby="gridSystemModalLabel">
</div>
<div class="modal fade close_register_modal" tabindex="-1" role="dialog" 
	aria-labelledby="gridSystemModalLabel">
</div>

<!-- quick product modal -->
<div class="modal fade quick_add_product_modal" tabindex="-1" role="dialog" aria-labelledby="modalTitle"></div>

@include('sale_pos.partials.configure_search_modal')

@stop

@section('javascript')
	<script src="{{ asset('public/js/pos.js?v=' . $asset_v) }}"></script>
	<script src="{{ asset('public/js/product.js?v=' . $asset_v) }}"></script>
	<script src="{{ asset('public/js/opening_stock.js?v=' . $asset_v) }}"></script>
	<script>
	$(document).ready(function(){
		$("#comprobante").val('0');
			$("#secuencia").val('0');
			$("#idsecuencia").val('0');
      $("#permitir").change(function(){
		if($(this).val()=='no'){
			$("#payment_rows_div").show("slow");

		}else{
			$("#payment_rows_div").hide("slow");

		}
	  });

$("#mcomprobante").val(1).trigger('change');
$("#mcomprobante").change(function(e){
	if($("#mcomprobante").val()==1){
	if($("#idcomp").val()!=0){
		$("#idncf").val($("#idcomp").val()).trigger('change');
	}
	var url = '{{ action("SellController@ncfsecuencia", ":id") }}';
url = url.replace(':id', $("#idncf").val());
$.ajax({
url: url,
dataType: 'json',
success: function(result) {
var data=JSON.stringify(result);
// alert(data);
const ncf = (num, places) => String(num).padStart(places, '0');
var secuencia=parseInt(result['secuencia']);
var codigoNcf = ncf(secuencia,8);
$("#comprobante").val(result['prefijo']+codigoNcf);
$("#secuencia").val(result['secuencia']);
$("#idsecuencia").val(result['idncfsecuencia']);
},
error: function(XMLHttpRequest, textStatus, errorThrown) { 
			$("#comprobante").val('0');
			$("#secuencia").val('0');
			$("#idsecuencia").val('0');
			if($("#idncf").val()=''){

			}else{
			toastr.warning("Secuencia de comprobante No válida");
			}


    } 
});
	}else if($(this).val()==0){
	$("#idncf").val(0).trigger('change');
	$("#comprobante").val('0');
			$("#secuencia").val('0');
			$("#idsecuencia").val('0');
	
}
});
		$("#customer_id").change(function(e){
			if($("#mcomprobante").val()==1){

e.preventDefault();
var url = '{{ action("SellController@ncfcustomer", ":id") }}';
url = url.replace(':id', $("#customer_id").val());
$.ajax({
url: url,
dataType: 'json',
success: function(result) {
var data=JSON.stringify(result);
// alert(data);
$("#credito_tiene").val(result['tiene_credito']);
if(result['tiene_credito']!=0){
	$("#permitir option[value='si']").remove();

	$("#permitir").append('<option value="si">Venta a crédito</option>');

	$("#permitir").val('si');
	$("#payment_rows_div").hide("slow");
		$("#method_0").val("cash").trigger('change');
$("#amount_0").val("0");
}else{
	$("#permitir").val('no');
	$("#permitir option[value='si']").remove();

	$("#payment_rows_div").show("slow");


}
$("select[name='pay_term_type']").val(result['pay_term_type']);
$("input[name='pay_term_number']").val(result['pay_term_number']);
// $("input[name='pay_term_type']").val(.result['pay_term_number']);

$("#idcomp").val(result['idncf']);
if(result['idncf']!=0){
$("#idncf").val(result['idncf']).trigger('change');
}else{
	$("#idncf").val('').trigger('change');

}
},
error: function(XMLHttpRequest, textStatus, errorThrown) { 
	$("#idcomp").val('0');
		

    } 
});
		}
});

if($("#mcomprobante").val()==1){

		$("#idncf").val($("#idcomp").val()).trigger('change');
		var url = '{{ action("SellController@ncfsecuencia", ":id") }}';
url = url.replace(':id', $("#idncf").val());
$.ajax({
url: url,
dataType: 'json',
success: function(result) {
var data=JSON.stringify(result);
// alert(data);
const ncf = (num, places) => String(num).padStart(places, '0');
var secuencia=parseInt(result['secuencia']);
var codigoNcf = ncf(secuencia,8);
$("#comprobante").val(result['prefijo']+codigoNcf);
$("#secuencia").val(result['secuencia']);
$("#idsecuencia").val(result['idncfsecuencia']);

},
error: function(XMLHttpRequest, textStatus, errorThrown) { 
			$("#comprobante").val('0');
			$("#secuencia").val('0');
			$("#idsecuencia").val('0');
			if($("#idncf").val()!=''){

			toastr.warning("Secuencia de comprobante No válida");
			}

    } 
});
}else{
	$("#idncf").val(0).trigger('change');

}

var url = '{{ action("SellController@ncfcustomer", ":id") }}';
url = url.replace(':id', $("#customer_id").val());
$.ajax({
url: url,
dataType: 'json',
success: function(result) {
var data=JSON.stringify(result);
// alert(data);
$("#credito_tiene").val(result['tiene_credito']);
if(result['tiene_credito']!=0){
	$("#permitir option[value='si']").remove();

	$("#permitir").append('<option value="si">Venta a crédito</option>');

	$("#permitir").val('si');


	$("#payment_rows_div").hide("slow");
	$("#method_0").val("cash").trigger('change');
	$("#amount_0").val("0");

}else{
	$("#permitir").val('no');
	$("#permitir option[value='si']").remove();

	$("#payment_rows_div").show("slow");
	$(".payment_types_dropdown").prop("required", true);

}

$("select[name='pay_term_type']").val(result['pay_term_type']);
$("input[name='pay_term_number']").val(result['pay_term_number']);

// $("input[name='pay_term_type']").val(.result['pay_term_number']);

$("#idcomp").val(result['idncf']);
if(result['idncf']!=0){
$("#idncf").val(result['idncf']).trigger('change');
}else{
	$("#idncf").val('').trigger('change');

}
},
error: function(XMLHttpRequest, textStatus, errorThrown) { 
	$("#idcomp").val('0');
		

    } 
});





$("#idncf").change(function(e){
	if($("#mcomprobante").val()==1){
		if($("#idncf").val()==''){
			$("#comprobante").val('0');
			$("#secuencia").val('0');
			$("#idsecuencia").val('0');
		}else{
e.preventDefault();
var url = '{{ action("SellController@ncfsecuencia", ":id") }}';
url = url.replace(':id', $(this).val());
$.ajax({
        url: url,
        dataType: 'json',
        success: function(result) {
			var data=JSON.stringify(result);
			// alert(data);
			const ncf = (num, places) => String(num).padStart(places, '0');
          var secuencia=parseInt(result['secuencia']);
          var codigoNcf = ncf(secuencia,8);
			$("#comprobante").val(result['prefijo']+codigoNcf);
			$("#secuencia").val(result['secuencia']);
			$("#idsecuencia").val(result['idncfsecuencia']);

		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
			$("#comprobante").val('0');
			$("#secuencia").val('0');
			$("#idsecuencia").val('0');
			if($("#idncf").val()!=''){
				

			toastr.warning("Secuencia de comprobante No válida");
			}

    }   
    });
		}
	}
});


if($("#credito_tiene").val()==0){
$("#permitir").val("no").trigger('change');
$("#permitir option[value='si']").remove();
$("#payment_rows_div").show("slow");

}
$("#status").val("final");
$("#status"). select2 (). trigger ('change');
	});

	$('button#submit-sell, button#save-and-print').click(function(e) {
		//Check if product is present or not.
		if($('#permitir').val()=='si'){
            $(".payment-amount").val('0.00');
        }
        if ($('table#pos_table tbody').find('.product_row').length <= 0) {
            toastr.warning(LANG.no_products_added);
            return false;
        }
		if($('#mcomprobante').val()==1){
			if($("#idncf").val()!=''){
		if ($('input#comprobante').val()== 0) {
            toastr.warning("Secuencia de comprobante No válida");
            return false;
        }
			}
		}
        if ($(this).attr('id') == 'save-and-print') {
            $('#is_save_and_print').val(1);           
        } else {
            $('#is_save_and_print').val(0);
        }

        if ($('#reward_point_enabled').length) {
            var validate_rp = isValidatRewardPoint();
            if (!validate_rp['is_valid']) {
                toastr.error(validate_rp['msg']);
                return false;
            }
        }

        if (sell_form.valid()) {
			
			window.onbeforeunload = null;

            sell_form.submit();
            $( "form" ).submit(function( event ) {
				event.preventDefault();

                var Datos = $( this ).serializeArray()
                var ArrayJSON = JSON.stringify(Datos)
                //Aqui usar el Ajax de la respuesta anterior solo en data mandar como parametro ArrayJson
				// alert($("input[name='_token']").val());

				// var url="{{ action('SellPosController@showInvoice1', ":id") }}";
                // url=url.replace(':id',$("#tokenprueba").val());
                // document.location.href=url;

              });
        }
    });
	</script>
	<!-- Call restaurant module if defined -->
    @if(in_array('tables' ,$enabled_modules) || in_array('modifiers' ,$enabled_modules) || in_array('service_staff' ,$enabled_modules))
    	<script src="{{ asset('public/js/restaurant.js?v=' . $asset_v) }}"></script>
    @endif
	
@endsection
