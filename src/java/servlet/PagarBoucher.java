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
 * @author adoha
 */
@WebServlet(name = "PagarBoucher", urlPatterns = {"/PagarBoucher"})
public class PagarBoucher extends HttpServlet {

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
            request.setCharacterEncoding("UTF-8");
            BoletaDto boleta = new BoletaDto();
            boleta.setForma_de_pago(request.getParameter("formaPago"));
            boleta.setOp_de_envio(request.getParameter("envioBoleta"));
            boleta.setRut_cliente(((ClienteDto) request.getSession().getAttribute("cliente")).getRut());
            boleta.setN_boucher(new BoletaDaoImp().getBoletaNoLista(((ClienteDto) request.getSession().getAttribute("cliente")).getRut()));
            int total = 0;
            for (DetalleTicketDto ticket : new DetalleTicketDaoImp().listarPorBoucher(
                    new BoletaDaoImp().getBoletaNoLista(((ClienteDto) request.getSession().getAttribute("cliente")).getRut()))) {
                total += new EstacionamientoDaoImp().getEstacionamiento(ticket.getId_estacionamiento()).getMonto();
            }

            boleta.setTotal_boleta(total);

            new BoletaDaoImp().modificar(boleta);

            request.setAttribute("boleta", boleta);
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
