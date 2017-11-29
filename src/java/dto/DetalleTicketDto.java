/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author CETECOM
 */
public class DetalleTicketDto {
    private int n_boucher;
    private int id_estacionamiento;
    private int n_ticket;

    public DetalleTicketDto(int n_boucher, int id_estacionamiento, int n_ticket) {
        this.n_boucher = n_boucher;
        this.id_estacionamiento = id_estacionamiento;
        this.n_ticket = n_ticket;
    }

    public DetalleTicketDto() {
    }

    public int getN_boucher() {
        return n_boucher;
    }

    public void setN_boucher(int n_boucher) {
        this.n_boucher = n_boucher;
    }

    public int getId_estacionamiento() {
        return id_estacionamiento;
    }

    public void setId_estacionamiento(int id_estacionamiento) {
        this.id_estacionamiento = id_estacionamiento;
    }

    public int getN_ticket() {
        return n_ticket;
    }

    public void setN_ticket(int n_ticket) {
        this.n_ticket = n_ticket;
    }

    @Override
    public String toString() {
        return "DetalleTicketDto{" + "n_boucher=" + n_boucher + ", id_estacionamiento=" + id_estacionamiento + ", n_ticket=" + n_ticket + '}';
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 79 * hash + this.n_ticket;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final DetalleTicketDto other = (DetalleTicketDto) obj;
        if (this.n_ticket != other.n_ticket) {
            return false;
        }
        return true;
    }
    
    
}
