/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.BoletaDaoImp;
import dao.ClienteDaoImp;
import dao.DetalleTicketDaoImp;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author adoha
 */
@WebServlet(name = "AgregarTicket", urlPatterns = {"/AgregarTicket"})
public class AgregarTicket extends HttpServlet {

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
            response.setContentType("text/html;charset=UTF-8");
            
            HttpSession session = request.getSession();
            if (((ClienteDto) session.getAttribute("cliente")) == null) {
                    ClienteDto cliente = new ClienteDto();
                    cliente.setRut(Integer.parseInt(request.getParameter("txtRut")));
                    cliente.setNombre(request.getParameter("txtNombre"));
                    cliente.setTelefono(request.getParameter("txtTelefono"));
                    cliente.setEmail(request.getParameter("txtEmail"));

                    new ClienteDaoImp().agregar(cliente);
                    session.setAttribute("cliente", cliente);

                if (new BoletaDaoImp().getBoletaNoLista(Integer.parseInt(request.getParameter("txtRut"))) == 0) {
                    BoletaDto boleta = new BoletaDto();
                    boleta.setForma_de_pago("temp");
                    boleta.setOp_de_envio("temp");
                    boleta.setRut_cliente(Integer.parseInt(request.getParameter("txtRut")));
                    boleta.setTotal_boleta(0);
                    new BoletaDaoImp().agregar(boleta);
                }
            }

            DetalleTicketDto ticket = new DetalleTicketDto();
            ticket.setId_estacionamiento(Integer.parseInt(request.getParameter("estacionamiento")));
            ticket.setN_boucher(new BoletaDaoImp().getUltimaBoleta());

            new DetalleTicketDaoImp().agregar(ticket);

            request.getRequestDispatcher("pages/PaginaPrincipal.jsp").forward(request, response);
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
