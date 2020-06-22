@php 
    $colspan = 15;
@endphp
<div class="table-responsive">
    <table class="table table-bordered table-striped ajax_view" id="product_table">
        <thead>
            <tr>
                <th><input type="checkbox" id="select-all-row"></th>
                <th>@lang('messages.photo')</th>
                <th>@lang('messages.action')</th>
                <th>@lang('sale.product')</th>
                <th style="width: 180px; min-width: 180px;">@lang('purchase.business_location') @show_tooltip(__('lang_v1.product_business_location_tooltip'))</th>
                @can('view_purchase_price')
                    @php 
                        $colspan++;
                    @endphp
                    <th style="width: 180px; min-width: 160px;">@lang('lang_v1.unit_perchase_price')</th>
                @endcan
                @can('access_default_selling_price')
                    @php 
                        $colspan++;
                    @endphp
                    <th style="width: 200px; min-width: 100px;">@lang('lang_v1.selling_price')</th>
                @endcan
                <th style="width: 80px; min-width: 80px;">@lang('report.current_stock')</th>
                <th style="width: 100px; min-width: 105px;">@lang('product.product_type')</th>
                <th>@lang('product.category')</th>
                <th>@lang('product.brand')</th>
                <th>@lang('product.tax')</th>
                <th>@lang('product.sku')</th>
                <th class="custom1">@lang('lang_v1.product_custom_field1')</th>
                <th class="custom2">@lang('lang_v1.product_custom_field2')</th>
                <th class="custom3">@lang('lang_v1.product_custom_field3')</th>
                <th class="custom4">@lang('lang_v1.product_custom_field4')</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <td colspan="{{$colspan}}">
                <div style="display: flex; width: 100%;">
                    @can('product.delete')
                        {!! Form::open(['url' => action('ProductController@massDestroy'), 'method' => 'post', 'id' => 'mass_delete_form' ]) !!}
                        {!! Form::hidden('selected_rows', null, ['id' => 'selected_rows']); !!}
                        {!! Form::submit(__('lang_v1.delete_selected'), array('class' => 'btn btn-xs btn-danger', 'id' => 'delete-selected')) !!}
                        {!! Form::close() !!}
                    @endcan
                    @can('product.update')
                    &nbsp;
                        {!! Form::open(['url' => action('ProductController@bulkEdit'), 'method' => 'post', 'id' => 'bulk_edit_form' ]) !!}
                        {!! Form::hidden('selected_products', null, ['id' => 'selected_products_for_edit']); !!}
                        <button type="submit" class="btn btn-xs btn-primary" id="edit-selected"> <i class="fa fa-edit"></i>{{__('lang_v1.bulk_edit')}}</button>
                        {!! Form::close() !!}
                        &nbsp;
                        <button type="button" class="btn btn-xs btn-success update_product_location" data-type="add">@lang('lang_v1.add_to_location')</button>
                        &nbsp;
                        <button type="button" class="btn btn-xs bg-navy update_product_location" data-type="remove">@lang('lang_v1.remove_from_location')</button>
                    @endcan
                    &nbsp;
                    {!! Form::open(['url' => action('ProductController@massDeactivate'), 'method' => 'post', 'id' => 'mass_deactivate_form' ]) !!}
                    {!! Form::hidden('selected_products', null, ['id' => 'selected_products']); !!}
                    {!! Form::submit(__('lang_v1.deactivate_selected'), array('class' => 'btn btn-xs btn-warning', 'id' => 'deactivate-selected')) !!}
                    {!! Form::close() !!} @show_tooltip(__('lang_v1.deactive_product_tooltip'))
                    </div>
                </td>
            </tr>
        </tfoot>
    </table>
</div>