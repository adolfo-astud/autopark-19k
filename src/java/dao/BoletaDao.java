/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BoletaDto;
import java.util.List;

/**
 *
 * @author Serph
 */
public interface BoletaDao extends BaseDao<BoletaDto>{
    
    public List<BoletaDto> listarPorRut(int rut);
    public List<BoletaDto> listarListasPorRut(int rut);
    public String descripcionBoleta(int n_boucher);
    public int getUltimaBoleta();
    public int getBoletaNoLista(int rut);
    public BoletaDto getBoleta(int n_boleta);
    
}
