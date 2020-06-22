<div class="modal-dialog modal-lg" role="document">
  <div class="modal-content">

    {!! Form::open(['url' => action('ProjectController@store_presupuesto'), 'method' => 'post', 'id' => 'project_id' ]) !!}

    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title">@lang( 'lang_v1.presupuesto' )</h4>
    </div>

    <div class="modal-body">
      <div class="row">
      <div class="col-sm-6">
          <div class="form-group">
          <input type="hidden" name="p_id" id="p_id" value="{{$p_id1}}">
          {!! Form::label('partidas', __( 'lang_v1.partidas' ) . ':*') !!}
              {!! Form::text('partidas', null, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.partidas') ]); !!}
          </div>
        </div>
        <div class="col-sm-6">
          <div class="form-group">
          {!! Form::label('cantidad', __( 'lang_v1.cantidad' ) . ':*') !!}

          {!! Form::number('cantidad', null, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.cantidad') ]); !!}

          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('partidas', __( 'lang_v1.unidad' ) . ':*') !!}

{!! Form::text('unidad', null, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.unidad') ]); !!}
          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
          {!! Form::label('precio_unitario', __( 'lang_v1.precio_unitario' ) . ':*') !!}

{!! Form::number('precio_unitario', null, ['class' => 'form-control', 'placeholder' => __( 'lang_v1.precio_unitario') ]); !!}
          </div>
        </div>
        
       
        <div class="clearfix"></div>

        <div class="col-sm-12 table-responsive">
    <table border="1" class="table table-responsive" id="tablaprueba">
      <thead class="thead-dark">
        <tr>
        <th>Accion</th>
          <th>Partidas</th>
          <th>Cantidad</th>
          <th>Unidad</th>
          <th>Precio Unitario</th>
          <th>Valor</th>
          
        </tr>
      </thead>
      <tbody></tbody>
    </table>

    <div class="form-group">
      <button type="button" class="btn btn-primary mr-2" onclick="agregarFila()">Agregar Fila</button>
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


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script>
function agregarFila(){



  var empTab = document.getElementById('tablaprueba');
  var rowCnt = empTab.rows.length;        // GET TABLE ROW COUNT.
  var tr = empTab.insertRow(rowCnt);      // TABLE ROW.
  tr = empTab.insertRow(rowCnt);
  if(document.getElementById("partidas").value=="" || document.getElementById("cantidad").value=="" || $("input[name='unidad']").val()=="" || document.getElementById("precio_unitario").value=="")
  {
    alert("Todos los campos son requeridos");
  }else{

             for (var c = 0; c < 6; c++) {
            var td = document.createElement('td');          // TABLE DEFINITION.
            td = tr.insertCell(c);

            if (c == 0) {           // FIRST COLUMN.
                // ADD A BUTTON.
                var button = document.createElement('input');

                // SET INPUT ATTRIBUTE.
                button.setAttribute('type', 'button');
                button.setAttribute('value', 'Remove');

                // ADD THE BUTTON's 'onclick' EVENT.
                button.setAttribute('onclick', 'removeRow(this)');

                td.appendChild(button);

            }
            if(c==1) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', document.getElementById('partidas').value);
                ele.setAttribute('name', 'partidas[]');
                ele.setAttribute('readonly', true);

                td.appendChild(ele);
            }
            if(c==2) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', new Intl.NumberFormat().format(document.getElementById('cantidad').value));
                ele.setAttribute('name', 'cantidad[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
            if(c==3) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', $("input[name='unidad']").val());
                ele.setAttribute('name', 'unidad[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
           
            if(c==4) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value',new Intl.NumberFormat().format(document.getElementById('precio_unitario').value));
                ele.setAttribute('name', 'precio_unitario[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
            if(c==5) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var valor_total=parseInt($("#cantidad").val())*parseInt($("#precio_unitario").val());
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', new Intl.NumberFormat().format(valor_total));
                ele.setAttribute('name', 'valor[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
           
          }

          $("input[name='unidad']").val('');
                    document.getElementById('partidas').value = "";
          document.getElementById('cantidad').value = "";
          document.getElementById('precio_unitario').value = "";

 
        }
        }
        function removeRow(oButton) {
        var empTab = document.getElementById('tablaprueba');
        empTab.deleteRow(oButton.parentNode.parentNode.rowIndex);       // BUTTON -> TD -> TR.
    }


   
</script>
