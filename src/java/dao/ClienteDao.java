/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ClienteDto;
import java.util.List;

/**
 *
 * @author Serph
 */
public interface ClienteDao extends BaseDao<ClienteDto>{
    
    public List<String> listarRut();
    public ClienteDto getCliente(int rut);
    
}
