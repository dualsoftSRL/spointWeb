@extends('layouts.app')
@section('title', __('invoice.Secuencias_ncf'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>@lang( 'invoice.Secuencias_ncf' )
        <small>@lang( 'invoice.manage_Secuencias_ncf' )</small>
    </h1>
    <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
    </ol> -->
</section>

<!-- Main content -->
<section class="content">
    @component('components.widget', ['class' => 'box-primary', 'title' => __( 'invoice.all_your_ncf_secuence' )])
        @slot('tool')
            <div class="box-tools">
                <button type="button" class="btn btn-block btn-primary btn-modal" 
                    data-href="{{action('NcfController@create')}}" 
                    data-container=".location_add_modal1">
                    <i class="fa fa-plus"></i> @lang( 'messages.add' )</button>
            </div>
        @endslot
        <div class="table-responsive">
            <!-- <table class="table table-bordered table-striped" id="ncf_table">
                <thead>
                    <tr>
                        <th>@lang( 'invoice.prefix' )</th>
                        <th>@lang( 'invoice.desde' )</th>
                        <th>@lang( 'invoice.hasta' )</th>
                        <th>@lang( 'invoice.used' )</th>
                        <th>@lang( 'invoice.noautorizacion' )</th>
                       
                        <th>@lang( 'messages.action' )</th>
                    </tr>
                </thead>
            </table> -->

            <div class="table-responsive">
            <table class="table table-bordered table-striped" id="ncf_table">
                    <thead>
                        <tr>
                        <th>@lang( 'invoice.date' )</th>
                        <th>@lang( 'invoice.prefix' )</th>
                        <th>@lang( 'invoice.desde' )</th>
                        <th>@lang( 'invoice.hasta' )</th>
                        <th>@lang( 'invoice.used' )</th>
                        <th>@lang( 'invoice.noautorizacion' )</th>
                        <th>@lang( 'invoice.Type' )</th>

                        <th>@lang( 'messages.action' )</th>
                        </tr>
                    </thead>
                </table>
        </div>
        </div>
    @endcomponent

    <div class="modal fade location_add_modal1" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>
    <div class="modal fade location_edit_modal1" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>

</section>
<!-- /.content -->

@endsection
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

<script>
var SITEURL = "{{action('NcfController@index')}}";
     $(document).ready(function(){
 


      var n = $('#ncf_table').DataTable({
        processing: true,
        serverSide: true,
        stateSave: true,

        ajax: {
          url: SITEURL,
         },        columnDefs: [
            {
                targets: 7,
                orderable: false,
                searchable: false,
            },
        ],
    });
    $('.dataTables_filter input').focus();

    $(document).on('click', 'button.desactivate-ncf', function(){
    swal({
        title: LANG.sure,
        icon: 'warning',
        buttons: true,
        dangerMode: true,
    }).then(willDelete => {
        if (willDelete) {
            $.ajax({
                url: $(this).data('href'),
                dataType: 'json',
                success: function(result) {
                    if (result.success == true) {
                        toastr.success(result.msg);
                        n.ajax.reload();
                    } else {
                        toastr.error(result.msg);
                    }
                },
            });
        }
    });
});
    $(document).on('shown.bs.modal','.modal', function (e) {
        $('form#ncf_add_form')
            .submit(function(e) {
                e.preventDefault();
            })
            .validate({
                rules: {
                 
                },
                messages: {
                   
                },
                submitHandler: function(form) {
                    e.preventDefault();
                    $(form)
                        .find('button[type="submit"]')
                        .attr('disabled', false);
                    var data = $(form).serialize();

                    $.ajax({
                        method: 'POST',
                        url: $(form).attr('action'),
                        dataType: 'json',
                        data: data,
                        success: function(result) {
                            if (result.success == true) {
                                $('div.location_add_modal1').modal('hide');
                                $('div.location_edit_modal1').modal('hide');
                                toastr.success(result.msg);
                                n.ajax.reload();
                            } else {
                                toastr.error(result.msg);
                            }
                        },
                    });
                },
            });
    });
});
           

</script>