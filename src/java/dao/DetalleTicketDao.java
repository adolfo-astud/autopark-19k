/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.DetalleTicketDto;
import java.util.List;

/**
 *
 * @author Serph
 */
public interface DetalleTicketDao extends BaseDao<DetalleTicketDto> {
    
    public List<DetalleTicketDto> listarPorBoucher(int n_boucher);
    
}
