@extends('layouts.guest')
@section('title', $title)
@section('content')

<div class="container">
    <div class="spacer"></div>
    <div class="row">
        <div class="col-md-12">
            <button type="button" class="btn btn-primary no-print pull-right"
                 aria-label="Print" onclick="$('#invoice_content').printThis();"><i class="fa fa-print"></i> @lang( 'messages.print' )
            </button>
            <a href="{{action('SellController@index')}}" class="btn btn-success no-print"><i class="fa fa-backward"></i>
                </a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 col-md-offset-2 col-sm-12" style="border: 1px solid #ccc;">
            <div class="spacer"></div>
            <div id="invoice_content">
                {!! $receipt['html_content'] !!}
            </div>
            <div class="spacer"></div>
        </div>
    </div>
    <div class="spacer"></div>
</div>
@endsection
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

<script>

    $(document).ready(function(){
        $('#invoice_content').printThis();      });
</script>