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
	

		out.println("Id evento recibido: "+ request.getParameter("idevento"));
		
		
		
		try{
			String conexion = "jdbc:mysql://localhost:3306/webcalendario";
			Connection conecction = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conecction = DriverManager.getConnection(conexion, "jjpalacio", "amorpropio");
			
			Statement stm = conecction.createStatement();
			
			stm.executeUpdate("Delete from eventos where idevento = "+request.getParameter("idevento"));
			
			stm.close();
			conecction.close();
		} 
		catch(Exception ej){
			
			out.println(ej.getMessage().toString());
			
		}
	
	 %>
</body>
</html>