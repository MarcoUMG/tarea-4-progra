/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import modelo.Estudiante;
import modelo.Tipos_sangre;
import dao.EstudianteDAO;
import dao.TiposSangreDAO;

@WebServlet(name="EstudianteServlet", urlPatterns={"/EstudianteServlet"})
public class EstudianteServlet extends HttpServlet {
    private EstudianteDAO estudianteDAO = new EstudianteDAO();
    private TiposSangreDAO tiposDAO = new TiposSangreDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action")==null ? "list" : req.getParameter("action");
        try{
            if("delete".equals(action)){
                int id = Integer.parseInt(req.getParameter("id"));
                estudianteDAO.eliminar(id);
                resp.sendRedirect("EstudianteServlet?action=list");
                return;
            }
            // list por defecto
            List<Estudiante> lista = estudianteDAO.listar();
            List<Tipos_sangre> tipos = tiposDAO.listar();
            req.setAttribute("lista", lista);
            req.setAttribute("tipos", tipos);
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }catch(Exception ex){
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        Estudiante e = new Estudiante();
        e.setId_estudiante(Integer.parseInt(req.getParameter("id_estudiante")));
        e.setCarne(req.getParameter("carne"));
        e.setNombres(req.getParameter("nombres"));
        e.setApellidos(req.getParameter("apellidos"));
        e.setDireccion(req.getParameter("direccion"));
        e.setTelefono(req.getParameter("telefono"));
        e.setCorreo_electronico(req.getParameter("correo_electronico"));
        e.setId_tipo_sangre(Integer.parseInt(req.getParameter("id_tipo_sangre")));
        e.setFecha_nacimiento(req.getParameter("fecha_nacimiento"));

        try{
            if("update".equals(action)) estudianteDAO.actualizar(e);
            else estudianteDAO.insertar(e);
            resp.sendRedirect("EstudianteServlet?action=list");
        }catch(Exception ex){
            throw new ServletException(ex);
        }
    }
}
