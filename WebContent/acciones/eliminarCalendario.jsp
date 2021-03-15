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
	

		out.println("Id Calendario recibido: "+ request.getParameter("idcalendario"));
		
		
		
		try{
			String conexion = "jdbc:mysql://localhost:3306/webcalendario";
			Connection conecction = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conecction = DriverManager.getConnection(conexion, "jjpalacio", "amorpropio");
			
			Statement stm = conecction.createStatement();
			
			stm.executeUpdate("Delete from calendarios where idcalendario = "+request.getParameter("idcalendario"));
			stm.executeUpdate("Delete from eventos where calendario = "+request.getParameter("idcalendario"));
			
			stm.close();
			conecction.close();
		} 
		catch(Exception ej){
			
			out.println(ej.getMessage().toString());
			
		}
	
	 %>
</body>
</html>