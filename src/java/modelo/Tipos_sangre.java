/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

public class Tipos_sangre {
    private int id_tipo_sangre;
    private String sangre;

    public Tipos_sangre() {}
    public Tipos_sangre(int id_tipo_sangre, String sangre) {
        this.id_tipo_sangre = id_tipo_sangre;
        this.sangre = sangre;
    }
    public int getId_tipo_sangre() { return id_tipo_sangre; }
    public void setId_tipo_sangre(int id_tipo_sangre) { this.id_tipo_sangre = id_tipo_sangre; }
    public String getSangre() { return sangre; }
    public void setSangre(String sangre) { this.sangre = sangre; }
}

