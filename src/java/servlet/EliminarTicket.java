/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.BoletaDaoImp;
import dao.DetalleTicketDaoImp;
import dao.EstacionamientoDaoImp;
import dto.BoletaDto;
import dto.ClienteDto;
import dto.DetalleTicketDto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Serph
 */
@WebServlet(name = "EliminarTicket", urlPatterns = {"/EliminarTicket"})
public class EliminarTicket extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            request.setCharacterEncoding("UTF-8");
            
            
            String mensaje="No existe registro!!";
            DetalleTicketDto far = new DetalleTicketDaoImp().getTicket(Integer.parseInt(request.getParameter("txtN_ticket")));
            int n_boleta = far.getN_boucher();
            if (far != null){
                if(new DetalleTicketDaoImp().eliminar(far))
                    mensaje="REGISTRO ELIMINADO!!"; 
                else
                    mensaje ="No se puede eliminar";
            }
            
            
            
            BoletaDto boleta = new BoletaDaoImp().getBoleta(n_boleta);
            int total = 0;
            for (DetalleTicketDto ticket : new DetalleTicketDaoImp().listarPorBoucher(n_boleta)) {
                total += new EstacionamientoDaoImp().getEstacionamiento(ticket.getId_estacionamiento()).getMonto();
            }
            boleta.setTotal_boleta(total);
            new BoletaDaoImp().modificar(boleta);
            
            
            
            
            request.setAttribute("boleta", new BoletaDaoImp().getBoleta(Integer.parseInt(request.getParameter("txtN_Boleta"))));
            request.setAttribute("mensaje", mensaje);
              request.getRequestDispatcher("pages/EntragaDeBoleta.jsp").forward(request, response); 
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
