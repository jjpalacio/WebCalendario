<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
	<%@ page import= 'java.sql.*' %> 
 	<%@	page import= 'java.io.*'  %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta http-equiv="refresh" content="0; url=../index.jsp" >
<title>Insert title here</title>
</head>
<body>
	
	<%
	
		out.println("año recibida: "+ request.getParameter("anio"));
		out.println("mes recibido: "+ request.getParameter("mes"));
		out.println("dia recibido: "+ request.getParameter("dia"));
		out.println("calendario recibido: "+ request.getParameter("calendario"));
		out.println("hora inicio recibida: "+ request.getParameter("hora"));
		out.println("minuto inicio recibido: "+ request.getParameter("minuto"));
		out.println("duración recibida: "+ request.getParameter("duracion"));
		out.println("nombre evento recibido: "+ request.getParameter("nombre"));
		
		
		
		try{
			String conexion = "jdbc:mysql://localhost:3306/webcalendario";
			Connection conecction = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conecction = DriverManager.getConnection(conexion, "jjpalacio", "amorpropio");
			
			Statement stm = conecction.createStatement();
			
			stm.executeUpdate("Insert into eventos values (Null, "+request.getParameter("calendario")+", '"+request.getParameter("nombre")+"', "+request.getParameter("anio")+""
															+", "+request.getParameter("mes")+", "+request.getParameter("dia")+", "+request.getParameter("hora")+", "+request.getParameter("minuto")+""
															+", 0, "+request.getParameter("duracion")+" )");
			
			stm.close();
			conecction.close();
		} 
		catch(Exception ej){
			
			out.println(ej.getMessage().toString());
			
		}
	
	 %>	
	
</body>
</html>