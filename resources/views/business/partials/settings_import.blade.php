<div class="pos-tab-content">
     <div class="row">
        <div class="col-sm-4 col-md-4" style="width:22.333333%!important;">
        @if(auth()->user()->hasRole('SuperAdmin#' . auth()->user()->business_id))
               <a class="btn  btn-primary" href="{{action('ImportProductsController@index')}}"><i class="fa fa-download"></i>@lang('product.import_products')</a>
              @endif
              
    </div>
        <div class="col-sm-4 col-md-4" style="width:22.333333%!important;">
            @can('product.opening_stock')
                <a class="btn btn-primary" href="{{action('ImportOpeningStockController@index')}}"><i class="fa fa-download"></i>@lang('lang_v1.import_opening_stock')</a>
              @endcan
        </div>
        <div class="col-sm-4 col-md-4" style="width:22.333333%!important;">
            @if(auth()->user()->hasRole('SuperAdmin#' . auth()->user()->business_id))
            <a class="btn btn-primary" href="{{action('ContactController@getImportContacts')}}"><i class="fa fa-download"></i> @lang('lang_v1.import_contacts')</a>
              @endcan
        </div>
    
    </div>
</div>