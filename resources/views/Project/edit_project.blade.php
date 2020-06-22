<div class="modal-dialog modal-lg" role="document">
  <div class="modal-content">

    {!! Form::open(['url' => action('ProjectController@update_project'), 'method' => 'post', 'id' => 'project_id' ]) !!}

    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title">@lang( 'lang_v1.Project_create' )</h4>
    </div>

    <div class="modal-body">
      <div class="row">
      <div class="col-sm-6">
          <div class="form-group">
          <input type="hidden" name="p_id" value="{{$project1->p_id}}">
          {!! Form::label('name', __( 'lang_v1.project_name' ) . ':') !!}
              {!! Form::text('name', $project1->name, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.project_name' ) ]); !!}
          </div>
        </div>
        <div class="clearfix"></div>
        <div class="col-sm-12">
          <div class="form-group">
          {!! Form::label('description_project', __( 'lang_v1.description_project' ) . ':') !!}

            <textarea name="description" id="description" style="margin: 0px; width: 868px; height: 186px;" rows="10">{{$project1->Description}}</textarea>
          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('customer_id', __('contact.customer') . ':') !!}
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="fa fa-user"></i>
                        </span>
                        {!! Form::select('customer_id', $customers, $project1->customer_id, ['class' => 'form-control select2', 'placeholder' => __('lang_v1.all')]); !!}
                    </div>
          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          <input type="hidden" name="idstatus" id="idstatus" value="{{$project1->status}}">
          {!! Form::label('status', __('lang_v1.status_project') . ':') !!}

           <select name="status" id="status" class="form-control">
           <option value="No iniciado">No iniciado</option>
           <option value="En progreso">En progreso</option>
           <option value="En espera">En espera</option>
           <option value="Cancelado">Cancelado</option>
           <option value="Completado">Completado</option>
           
           </select>
          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('encargado', __('lang_v1.manager_project') . ':') !!}
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="fa fa-user"></i>
                        </span>
                        {!! Form::select('encargado', $users, $project1->encargado, ['class' => 'form-control select2', 'placeholder' => __('lang_v1.all')]); !!}
                    </div>
          </div>
        </div>
        <div class="clearfix"></div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('start_date', __('lang_v1.start_date') . ':') !!}
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="fa fa-calendar"></i>
                        </span>
                        <input type="date" name="start_date" id="start_date" value="{{$project1->start_date}}" class="form-control">
                    </div>
          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('end_date', __('lang_v1.end_date') . ':') !!}
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="fa fa-calendar"></i>
                        </span>
                        <input type="date" name="end_date" id="end_date" value="{{$project1->end_date}}" class="form-control">
                    </div>
          </div>
        </div>
       
       

        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('category', __('lang_v1.category') . ':') !!}
                   
                        <input type="text" name="category" id="category" value="{{$project1->category}}" class="form-control">
                    
          </div>
        </div>
        <div class="clearfix"></div>

   
    
      
     
     
    
     

      <div class="clearfix"></div>
        <hr>
       
      </div>
    </div>

    <div class="modal-footer">
      <button type="submit" class="btn btn-primary">@lang( 'messages.save' )</button>
      <button type="button" class="btn btn-default" data-dismiss="modal">@lang( 'messages.close' )</button>
    </div>

    {!! Form::close() !!}

  </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
<!-- <div class="modal fade contact_modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
	@include('contact.create', ['quick_add' => true])
</div> -->

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
$("#status").val($("#idstatus").val());
});
</script>