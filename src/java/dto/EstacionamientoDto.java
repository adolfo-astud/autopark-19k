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
public class EstacionamientoDto {
    private int id;
    private String descripcion;
    private int monto;
    private String coordenadas;

    public EstacionamientoDto(int id, String descripcion, int monto, String coordenadas) {
        this.id = id;
        this.descripcion = descripcion;
        this.monto = monto;
        this.coordenadas = coordenadas;
    }

    public EstacionamientoDto() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getMonto() {
        return monto;
    }

    public void setMonto(int monto) {
        this.monto = monto;
    }

    public String getCoordenadas() {
        return coordenadas;
    }

    public void setCoordenadas(String coordenadas) {
        this.coordenadas = coordenadas;
    }

    @Override
    public String toString() {
        return "dtoEstacionamiento{" + "id=" + id + ", descripcion=" + descripcion + ", monto=" + monto + ", coordenadas=" + coordenadas + '}';
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 71 * hash + this.id;
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
        final EstacionamientoDto other = (EstacionamientoDto) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }
}
