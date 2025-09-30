<%-- 
    Document   : index
    Created on : Sep 29, 2025, 11:01:43 PM
    Author     : Marco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Estudiante"%>
<%@page import="modelo.Tipos_sangre"%>
<%
    List<Estudiante> lista = (List<Estudiante>) request.getAttribute("lista");
    List<Tipos_sangre> tipos = (List<Tipos_sangre>) request.getAttribute("tipos");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Estudiantes</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="m-0">Gestión de Estudiantes</h3>
        <div class="d-flex gap-2">
            <a href="EstudianteServlet?action=list" class="btn btn-outline-secondary">Refrescar</a>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalForm"
                    onclick="limpiarFormulario()">Nuevo</button>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle" id="tablaEstudiantes">
                    <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Carné</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Tipo sangre</th>
                        <th>Teléfono</th>
                        <th>Correo</th>
                        <th style="width:110px">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (lista != null) {
                            for (Estudiante e : lista) {
                                String dir = e.getDireccion()==null?"":e.getDireccion().replace("\"","\\\"");
                                String tel = e.getTelefono()==null?"":e.getTelefono();
                                String cor = e.getCorreo_electronico()==null?"":e.getCorreo_electronico();
                                String fec = e.getFecha_nacimiento()==null?"":e.getFecha_nacimiento();
                                String sangre = "";
                                if (tipos != null) {
                                    for (Tipos_sangre t: tipos) {
                                        if (t.getId_tipo_sangre()==e.getId_tipo_sangre()) { sangre=t.getSangre(); break; }
                                    }
                                }
                    %>
                    <tr onclick='cargarEnModal(<%=e.getId_estudiante()%>,"<%=e.getCarne()%>","<%=e.getNombres().replace("\"","\\\"")%>",
                                                "<%=e.getApellidos().replace("\"","\\\"")%>","<%=dir%>",
                                                "<%=tel%>","<%=cor%>",<%=e.getId_tipo_sangre()%>,"<%=fec%>")'>
                        <td><%=e.getId_estudiante()%></td>
                        <td><%=e.getCarne()%></td>
                        <td><%=e.getNombres()%></td>
                        <td><%=e.getApellidos()%></td>
                        <td><%=sangre%></td>
                        <td><%=tel%></td>
                        <td><%=cor%></td>
                        <td>
                            <a class="btn btn-sm btn-danger"
                               href="EstudianteServlet?action=delete&id=<%=e.getId_estudiante()%>"
                               onclick="return confirmarEliminar('<%=e.getCarne()%>')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <small class="text-muted">Tip: haz clic en una fila para abrirla en el modal y editarla.</small>
        </div>
    </div>
</div>

<!-- Modal Form (Insert/Update) -->
<div class="modal fade" id="modalForm" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form class="modal-content needs-validation" method="post" action="EstudianteServlet" novalidate>
      <div class="modal-header">
        <h5 class="modal-title">Estudiante</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" name="action" id="action" value="insert">
        <input type="hidden" name="id_estudiante" id="id_estudiante" value="0">

        <div class="row g-3">
          <div class="col-12 col-md-3">
            <label class="form-label">Carné</label>
            <input type="text" class="form-control" name="carne" id="carne" maxlength="4" placeholder="E001" required>
            <div class="invalid-feedback">Formato: E001…E999</div>
          </div>
          <div class="col-12 col-md-4">
            <label class="form-label">Nombres</label>
            <input type="text" class="form-control" name="nombres" id="nombres" required>
            <div class="invalid-feedback">Requerido</div>
          </div>
          <div class="col-12 col-md-5">
            <label class="form-label">Apellidos</label>
            <input type="text" class="form-control" name="apellidos" id="apellidos" required>
            <div class="invalid-feedback">Requerido</div>
          </div>

          <div class="col-12">
            <label class="form-label">Dirección</label>
            <input type="text" class="form-control" name="direccion" id="direccion">
          </div>

          <div class="col-12 col-md-4">
            <label class="form-label">Teléfono</label>
            <input type="text" class="form-control" name="telefono" id="telefono">
          </div>

          <div class="col-12 col-md-5">
            <label class="form-label">Correo</label>
            <input type="email" class="form-control" name="correo_electronico" id="correo_electronico">
          </div>

          <div class="col-12 col-md-3">
            <label class="form-label">Tipo sangre</label>
            <select class="form-select" name="id_tipo_sangre" id="id_tipo_sangre" required>
              <option value="">Seleccione…</option>
              <%
                if (tipos != null) {
                    for (Tipos_sangre t : tipos) {
              %>
                <option value="<%=t.getId_tipo_sangre()%>"><%=t.getSangre()%></option>
              <%
                    }
                }
              %>
            </select>
            <div class="invalid-feedback">Seleccione un tipo</div>
          </div>

          <div class="col-12 col-md-4">
            <label class="form-label">Fecha de nacimiento</label>
            <input type="date" class="form-control" name="fecha_nacimiento" id="fecha_nacimiento">
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Cancelar</button>
        <button class="btn btn-primary" type="submit">Guardar</button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Validación Bootstrap + carné E### (sin E000)
(() => {
  const form = document.querySelector('.needs-validation');
  form.addEventListener('submit', (e) => {
    const carne = document.getElementById('carne').value.trim();
    const ok = /^E\d{3}$/.test(carne) && carne !== 'E000';
    if (!ok) {
      e.preventDefault(); e.stopPropagation();
      document.getElementById('carne').classList.add('is-invalid');
    }
    form.classList.add('was-validated');
  }, false);
})();

function limpiarFormulario(){
  document.getElementById('action').value='insert';
  document.getElementById('id_estudiante').value=0;
  document.getElementById('carne').value='';
  document.getElementById('nombres').value='';
  document.getElementById('apellidos').value='';
  document.getElementById('direccion').value='';
  document.getElementById('telefono').value='';
  document.getElementById('correo_electronico').value='';
  document.getElementById('id_tipo_sangre').value='';
  document.getElementById('fecha_nacimiento').value='';
}

function cargarEnModal(id, carne, nombres, apellidos, direccion, telefono, correo, idTipo, fecha){
  const modal = new bootstrap.Modal('#modalForm');
  document.getElementById('action').value='update';
  document.getElementById('id_estudiante').value=id;
  document.getElementById('carne').value=carne;
  document.getElementById('nombres').value=nombres;
  document.getElementById('apellidos').value=apellidos;
  document.getElementById('direccion').value=direccion;
  document.getElementById('telefono').value=telefono;
  document.getElementById('correo_electronico').value=correo;
  document.getElementById('id_tipo_sangre').value=idTipo;
  document.getElementById('fecha_nacimiento').value=fecha;
  modal.show();
}

function confirmarEliminar(carne){
  return confirm('¿Eliminar al estudiante ' + carne + '?');
}
</script>
</body>
</html>
