<div class="modal-dialog modal-lg" role="document">
  <div class="modal-content">

    {!! Form::open(['url' => action('NcfController@store'), 'method' => 'post', 'id' => 'ncf_add_form' ]) !!}

    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title">@lang( 'invoice.add_ncf_secuencia' )</h4>
    </div>

    <div class="modal-body">
      <div class="row">
      <div class="col-sm-6">
          <div class="form-group">
            {!! Form::label('idncf', __('invoice.ncfcreate') . ':*') !!} 
              {!! Form::select('idncf', $idncf, null, ['class' => 'form-control',
              'placeholder' => __('messages.please_select')]); !!}
          </div>
        </div>
        <div class="clearfix"></div>
        <div class="col-sm-6">
          <div class="form-group">
            {!! Form::label('prefijo', __( 'invoice.prefix' ) . ':') !!}
              {!! Form::text('prefijo', null, ['class' => 'form-control', 'placeholder' => __( 'invoice.prefix' ) ]); !!}
          </div>
        </div>
        <div class="col-sm-6">
          <div class="form-group">
            {!! Form::label('desde', __( 'invoice.desde' ) . ':*') !!}
              {!! Form::text('desde', null, ['class' => 'form-control', 'placeholder' => __( 'invoice.desde' ) ]); !!}
          </div>
        </div>
        <div class="clearfix"></div>
        <div class="col-sm-6">
          <div class="form-group">
            {!! Form::label('hasta', __( 'invoice.hasta' ) . ':*') !!}
              {!! Form::text('hasta', null, ['class' => 'form-control', 'placeholder' => __( 'invoice.hasta') ]); !!}
          </div>
        </div>
        <div class="col-sm-6">
          <div class="form-group">
            {!! Form::label('autorizacionNo', __( 'invoice.autorizacionNo' ) . ':*') !!}
              {!! Form::text('autorizacionNo', null, ['class' => 'form-control', 'placeholder' => __( 'invoice.autorizacionNo') ]); !!}
          </div>
        </div>
        <div class="clearfix"></div>
        
        <div class="col-sm-6">
          <div class="form-group">
            {!! Form::label('fecha_venc', __( 'invoice.fechavencimiento' ) . ':*') !!}
              {!! Form::date('fecha_venc', null, ['class' => 'form-control', 'placeholder' => __( 'invoice.fechavencimiento') ]); !!}
          </div>
        </div>
       
       
      
    
        <div class="col-sm-12 table-responsive">
    <table border="1" class="table table-responsive" id="tablaprueba">
      <thead class="thead-dark">
        <tr>
        <th>Accion</th>
          <th>ID</th>
          <th>Prefijo</th>
          <th>Desde</th>
          <th>Hasta</th>
          <th>No.Autorizacion</th>
          <th>Fec_Venc</th>
          
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
<script>
function agregarFila(){



  var empTab = document.getElementById('tablaprueba');
  var rowCnt = empTab.rows.length;        // GET TABLE ROW COUNT.
  var tr = empTab.insertRow(rowCnt);      // TABLE ROW.
  tr = empTab.insertRow(rowCnt);
  if(document.getElementById("idncf").value=="" || document.getElementById("prefijo").value=="" || document.getElementById("desde").value=="" || document.getElementById("autorizacionNo").value==""|| document.getElementById("fecha_venc").value=="" || document.getElementById("hasta").value=="")
  {
    alert("Todos los campos son requeridos");
  }else{

    var url='{{action("NcfController@verificar",[":id",":desde",":hasta"])}}';
  url = url.replace(':id', $("#idncf").val());
  url = url.replace(':desde', $("#desde").val());
  url = url.replace(':hasta', $("#hasta").val());
$.ajax({
    method: 'GET',
    url: url,
    dataType: 'json',
    success: function(result) {
        if (result.success == true) {
            toastr.error(result.msg);
        } else {
          for (var c = 0; c < 7; c++) {
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
                ele.setAttribute('value', document.getElementById('idncf').value);
                ele.setAttribute('name', 'idncf[]');
                ele.setAttribute('readonly', true);

                td.appendChild(ele);
            }
            if(c==2) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', document.getElementById('prefijo').value);
                ele.setAttribute('name', 'prefijo[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
            if(c==3) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', document.getElementById('desde').value);
                ele.setAttribute('name', 'desde[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
            if(c==4) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', document.getElementById('hasta').value);
                ele.setAttribute('name', 'hasta[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
            if(c==5) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', document.getElementById('autorizacionNo').value);
                ele.setAttribute('name', 'autorizacionNo[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
            if(c==6) {
                // CREATE AND ADD TEXTBOX IN EACH CELL.
                var ele = document.createElement('input');
                ele.setAttribute('type', 'text');
                ele.setAttribute('value', document.getElementById('fecha_venc').value);
                ele.setAttribute('name', 'fecha_venc[]');
                ele.setAttribute('readonly', true);
                td.appendChild(ele);
            }
          }

          document.getElementById('prefijo').value = "";
          document.getElementById('desde').value = "";
          document.getElementById('hasta').value = "";
          document.getElementById('autorizacionNo').value = "";
          document.getElementById('fecha_venc').value = "";        }
    },
});

 
        }
        }
        function removeRow(oButton) {
        var empTab = document.getElementById('tablaprueba');
        empTab.deleteRow(oButton.parentNode.parentNode.rowIndex);       // BUTTON -> TD -> TR.
    }


   
</script>
