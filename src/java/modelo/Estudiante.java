/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.util.regex.Pattern;

public class Estudiante {
    private int id_estudiante;
    private String carne;
    private String nombres;
    private String apellidos;
    private String direccion;
    private String telefono;
    private String correo_electronico;
    private int id_tipo_sangre;
    private String fecha_nacimiento; // formato yyyy-MM-dd (compatible con <input type="date">)

    // --- Constructores ---
    public Estudiante() {}

    public Estudiante(int id_estudiante, String carne, String nombres, String apellidos,
                      String direccion, String telefono, String correo_electronico,
                      int id_tipo_sangre, String fecha_nacimiento) {
        this.id_estudiante = id_estudiante;
        this.carne = carne;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.direccion = direccion;
        this.telefono = telefono;
        this.correo_electronico = correo_electronico;
        this.id_tipo_sangre = id_tipo_sangre;
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public Estudiante(String carne, String nombres, String apellidos,
                      String direccion, String telefono, String correo_electronico,
                      int id_tipo_sangre, String fecha_nacimiento) {
        this(0, carne, nombres, apellidos, direccion, telefono, correo_electronico,
             id_tipo_sangre, fecha_nacimiento);
    }

    // --- Getters/Setters ---
    public int getId_estudiante() { return id_estudiante; }
    public void setId_estudiante(int id_estudiante) { this.id_estudiante = id_estudiante; }

    public String getCarne() { return carne; }
    public void setCarne(String carne) { this.carne = carne; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getCorreo_electronico() { return correo_electronico; }
    public void setCorreo_electronico(String correo_electronico) { this.correo_electronico = correo_electronico; }

    public int getId_tipo_sangre() { return id_tipo_sangre; }
    public void setId_tipo_sangre(int id_tipo_sangre) { this.id_tipo_sangre = id_tipo_sangre; }

    public String getFecha_nacimiento() { return fecha_nacimiento; }
    public void setFecha_nacimiento(String fecha_nacimiento) { this.fecha_nacimiento = fecha_nacimiento; }

    // --- Utilidad opcional: validar carné E### ---
    public static boolean esCarneValido(String carne) {
        if (carne == null) return false;
        // E001 a E999
        return Pattern.matches("^E\\d{3}$", carne) && !carne.equals("E000");
    }
}
