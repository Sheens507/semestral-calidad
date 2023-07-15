<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/Estilo.css">
<link rel="icon" type="image/x-icon" href="Imagenes/LOGO_SC.ico">
<title>Registro_Usuario</title>
</head>
<body class=mensaje>

<%
// Crear las variables para las entradas del formulario: Nombre, Apellido, Edad, Password
String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String edad = request.getParameter("edad");
String password = request.getParameter("password");

if (nombre == null || apellido == null || edad == null || password == null) {
    out.println("<h1>Error: Los campos de nombre, apellido y contrase�a no pueden estar vac�os.</h1>");
    out.println("<a href='login.html'>Volver al formulario de inicio de sesi�n</a>");
} else {
    try {
        // Conexi�n a la base de datos
        Class.forName("com.mysql.jdbc.Driver");
        Connection dbconect = DriverManager.getConnection("jdbc:mysql://localhost:3306/semestral", "root", "");
        Statement dbstatement = dbconect.createStatement();

        // Verificar si el nombre de usuario ya existe en la base de datos
        String verificarsql = "SELECT * FROM login WHERE Nombre = '" + nombre + "'AND Apellido = '" + apellido +"'AND Password = '" + password +"'";
        ResultSet resultado = dbstatement.executeQuery(verificarsql);

        if (resultado.next()) {
        	//Redirige a la página UsuarioExistente
            response.sendRedirect("../UsuarioExistente.html");
        } else {
            // Insertar los datos en la base de datos
            String insertarsql = "INSERT INTO login (Nombre, Apellido, Edad, Password) VALUES ('" + nombre + "', '" + apellido + "', '" + edad + "', '" + password + "')";
            dbstatement.executeUpdate(insertarsql);
            response.sendRedirect("../RegistroExitoso.html");
        }

        resultado.close();
        dbstatement.close();
        dbconect.close();
    } catch (Exception e) {
        // Manejo de excepciones
        e.printStackTrace();
        out.println("<h2>Error de conexi�n a la base de datos.</h2>");
    }
}
%>

</body>
</html>