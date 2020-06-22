<div class="modal-dialog modal-lg" role="document">
  <div class="modal-content">

    {!! Form::open(['url' => action('ProjectController@update_task'), 'method' => 'post', 'id' => 'id_task' ]) !!}

    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title">@lang( 'lang_v1.edit_task' )</h4>
    </div>

    <div class="modal-body">
      <div class="row">
      <div class="col-sm-6">
          <div class="form-group">
          <input type="hidden" name="idtask" value="{{$tareas->idtask}}">
          {!! Form::label('task', __( 'lang_v1.Task_title' ) . ':*') !!}
          {!! Form::text('task_title', $tareas->task_title, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.task_title') ]); !!}
          </div>
        </div>
        <div class="col-sm-6">
          <div class="form-group">
          {!! Form::label('task_description', __( 'lang_v1.description_task' ) . ':*') !!}

          {!! Form::text('task_description', $tareas->task_description, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.description_task') ]); !!}

          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('category', __( 'lang_v1.category_task' ) . ':*') !!}

          {!! Form::text('category', $tareas->category, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.category_task') ]); !!}

          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('start_from', __( 'lang_v1.start_from' ) . ':*') !!}

{!! Form::date('start_from', $tareas->start_from, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.start_from') ]); !!}
          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('end_date', __( 'lang_v1.end_date' ) . ':*') !!}

{!! Form::date('end_date', $tareas->end_date, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.end_date') ]); !!}
          </div>
        </div>
        
       

        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('p_id', __( 'lang_v1.p_id_task' ) . ':*') !!}
          {!! Form::select('p_id', $project, $tareas->p_id, ['class' => 'form-control select2', 'placeholder' => __('lang_v1.select_a_project')]); !!}

          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          <input type="hidden" name="idstatus" id="idstatus" value='{{$tareas->status}}'>
          {!! Form::label('status', __('lang_v1.status_activity') . ':') !!}

<select name="status" id="status" class="form-control">
<option value="No iniciado">No iniciado</option>
<option value="En progreso">En progreso</option>
<option value="En espera">En espera</option>
<option value="Cancelado">Cancelado</option>
<option value="Completado">Completado</option>

          
          </select>

          </div>
        </div>
     
    
      
     
     
    
     

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

@section('javascript')

<script>
$(document).ready(function(){
  
$("#status").val($("#idstatus").val());
});
</script>
@endsection