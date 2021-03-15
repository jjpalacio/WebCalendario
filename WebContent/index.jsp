<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 	<%@ page import= 'java.sql.*' %> 
 	<%@	page import= 'java.io.*'  %>
 	
 	<%
 		if (session.getAttribute("anio") == null){session.setAttribute("anio", 2021);}
 		if (session.getAttribute("mes") == null){session.setAttribute("mes", 4);}
 		
 		int mesnumero = (Integer)session.getAttribute("mes");
 		
 		if (request.getParameter("mes") != null){
	 		if (request.getParameter("mes").contains("anterior")){session.setAttribute("mes", mesnumero - 1);}
	 		if (request.getParameter("mes").contains("siguiente")){session.setAttribute("mes", mesnumero + 1);}
 		}
 	%>
 	
<!DOCTYPE html>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>
			<%out.println(request.getParameter("mes")+session.getAttribute("mes"));%>		
		</title>	
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!--<link rel="shortcut icon" href="http://webcalendario.com/favicons/09.ico">	-->
		<script src="lib/jquery-1.10.1.min.js"></script>
		<script src="lib/jquery-ui.js"></script>
		<script src="js/codigo.js">
		
		</script>
		<link rel="stylesheet" type="text/css" href="css/estilo.css">
		<link rel="stylesheet" type="text/css" href="css/header.css">
	</head>
	<body>
	<div id="tituloprint">www.webcalendario.com</div>
	<header>
		<div id="logo">
			
				<h1>webcalendario.com</h1>
				<h2>Tu calendario en la nube</h2>
			</div>
			<nav>
				<ul>
					<li>
						Inicio
					</li>
					<li>
						FAQ
					</li>
					<li id="botonlogin">
						Inicia sesion
					</li>
					<li id="botonsignin">
						Regístrate
					</li>
					<li id="contacto">
						Contacto
					</li>
					<li id="contacto">
						<a href="">Cerrar Sesion</a>
					</li>
				</ul>
			</nav>
	</header>
	<table width="100%">
	<tbody><tr>
	<td id="aniotitulo">
		<h2><%out.println(session.getAttribute("mes"));%></h2><h1><%out.println(session.getAttribute("anio"));%></h1></td>
		<td id="botones">
			<a href="?mes=anterior"><button> &lt;&lt; </button></a>
			<a href="?mes=siguiente"><button> &gt;&gt; </button></a>
		</td>
		<td>
			<div id="calendarios">
				
				<%
				
					try{
						String conexion = "jdbc:mysql://localhost:3306/webcalendario";
						Connection conecction = null;
						Class.forName("com.mysql.jdbc.Driver").newInstance();
						conecction = DriverManager.getConnection(conexion, "jjpalacio", "amorpropio");
						
						Statement stm = conecction.createStatement();
						ResultSet rst;
						
						String peticion = "Select * from calendarios";
						
						rst = stm.executeQuery(peticion);
						
						while(rst.next()){
							
							out.println("<span class='calendariocol' idcalendario='1' style='width:80px;background:rgb("+rst.getString("color")+");'>"+rst.getString("nombre")+"<div class='eliminar'><a style='color:#d7d7d7;' href='acciones/eliminarCalendario.jsp?idcalendario="+rst.getInt("idcalendario")+"'>X</a></div></span>");
							
						} 
						
						stm.close();
						conecction.close();
					} 
					catch(Exception ej){
						
						out.println(ej.getMessage().toString());
						
					}
				
				 %> 
				
			<button id="botonanadircomentario">
				Añadir comentario
			</button>
			</div>
			<span class="calendariocol" style="background:grey;" id="ocultacalendarios"> &gt; </span>
			</td>
		</tr>
		</tbody></table>
		<div style="clear:both;"></div>
		<div id="calendario">
		
		<%
			try{
				String conexion = "jdbc:mysql://localhost:3306/webcalendario";
				Connection conecction = null;
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conecction = DriverManager.getConnection(conexion, "jjpalacio", "amorpropio");
				
				Statement stm = conecction.createStatement();
				ResultSet rst;
				
				for (int dia = 1; dia <= 31; dia ++){
					
					String peticion = "SELECT a.*,b.color FROM `eventos` as a inner join `calendarios` as b on a.calendario = b.idcalendario where a.anio = '"+session.getAttribute("anio")+"' and a.mes = '"+session.getAttribute("mes")+"' and dia = "+dia+"";
					
					rst = stm.executeQuery(peticion);
					
					out.println("<div class='dia ui-droppable' dia='"+dia+"' style='position:relative;'><div class='numerodia'><b>"+dia+"</b></div>");
					
					while(rst.next()){
						
						out.println("<div idcaldia='7' anio='2014' mes='9' dia='13' hora='9' nombre='IMF' class='evento ui-draggable' style='background:rgb("+rst.getString("color")+");width:90%;height:"+(rst.getInt("duracion")*0.2) +"%;position:absolute;top:"+((rst.getInt("hora")*4)+12)+"%;'>"+rst.getInt("hora")+":"+rst.getInt("minuto")+"-"+(rst.getInt("hora")+(rst.getInt("duracion")/60))+":00	<span class='motivoevento'>-"+rst.getString("nombre")+"</span><div class='eliminar'><a style='color:#d7d7d7;' href='acciones/eliminarEvento.jsp?idevento="+rst.getInt("idevento")+"'>X</a></div></div>");	
						
					}
						
					out.println("</div>");
				}
				 
				
				stm.close();
				conecction.close();
			} 
			catch(Exception ej){
				
				out.println(ej.getMessage().toString());
				
			}
		
			
		%>
		
			<!--  <div class="dia ui-droppable" dia="1" style="position:relative;"><div class="numerodia"><b>1</b></div></div>
			<div class="dia ui-droppable" dia="2" style="position:relative;"><div class="numerodia"><b>2</b></div></div>
			<div class="dia ui-droppable" dia="3" style="position:relative;"><div class="numerodia"><b>3</b></div></div>
			<div class="dia ui-droppable" dia="4" style="position:relative;"><div class="numerodia"><b>4</b></div></div>
			<div class="dia ui-droppable" dia="5" style="position:relative;"><div class="numerodia"><b>5</b></div></div>
			<div class="dia ui-droppable" dia="6" style="background:rgba(0,0,0,0.2);position:relative;"><div class="numerodia"><b>6</b></div></div>
			<div class="dia ui-droppable" dia="7" style="background:rgba(0,0,0,0.2);position:relative;"><div class="numerodia"><b>7</b></div></div>
			<div style="clear:both;"></div>
			<div class="dia ui-droppable" dia="8" style="position:relative;"><div class="numerodia"><b>8</b></div></div>
			<div class="dia ui-droppable" dia="9" style="background:white !important;position:relative;"><div class="numerodia"><b>9</b></div></div>
			<div class="dia ui-droppable" dia="10" style="position:relative;"><div class="numerodia"><b>10</b></div></div>
			<div class="dia ui-droppable" dia="11" style="position:relative;"><div class="numerodia"><b>11</b></div></div>
			<div class="dia ui-droppable" dia="12" style="position:relative;"><div class="numerodia"><b>12</b></div></div>
			<div class="dia ui-droppable" dia="13" style="background:rgba(0,0,0,0.2);position:relative;">
				<div class="numerodia"><b>13</b></div>
				<div idcaldia="7" anio="2014" mes="9" dia="13" hora="9" nombre="IMF" class="evento ui-draggable" style="background:#d7d7d7;width:90%;height:19.2%;position:absolute;top:48%;">
					9:0-15:00
						<span class="motivoevento">
							-Evento 1
						</span>
						<div class="eliminar">
							<a style="color:#d7d7d7;" href="http://webcalendario.com/php/calendario.php?operacion=eliminar&anio=2014&mes=9&dia=13&nombre=IMF">
								X
							</a>
						</div>
					</div>
				</div>
			<div class="dia ui-droppable" dia="14" style="background:rgba(0,0,0,0.2);position:relative;"><div class="numerodia"><b>14</b></div></div>
			<div style="clear:both;"></div><div class="dia ui-droppable" dia="15" style="position:relative;"><div class="numerodia"><b>15</b></div></div>
			<div class="dia ui-droppable" dia="16" style="position:relative;"><div class="numerodia"><b>16</b></div></div>
			<div class="dia ui-droppable" dia="17" style="position:relative;"><div class="numerodia"><b>17</b></div></div>
			<div class="dia ui-droppable" dia="18" style="position:relative;"><div class="numerodia"><b>18</b></div></div>
			<div class="dia ui-droppable" dia="19" style="position:relative;"><div class="numerodia"><b>19</b></div></div>
			<div class="dia ui-droppable" dia="20" style="background:rgba(0,0,0,0.2);position:relative;"><div class="numerodia"><b>20</b></div></div>
			<div class="dia ui-droppable" dia="21" style="background:rgba(0,0,0,0.2);position:relative;"><div class="numerodia"><b>21</b></div></div>
			<div style="clear:both;"></div><div class="dia ui-droppable" dia="22" style="position:relative;"><div class="numerodia"><b>22</b></div></div>
			<div class="dia ui-droppable" dia="23" style="position:relative;"><div class="numerodia"><b>23</b></div></div>
			<div class="dia ui-droppable" dia="24" style="position:relative;"><div class="numerodia"><b>24</b></div></div>
			<div class="dia ui-droppable" dia="25" style="position:relative;"><div class="numerodia"><b>25</b></div></div>
			<div class="dia ui-droppable" dia="26" style="position:relative;"><div class="numerodia"><b>26</b></div></div>
			<div class="dia ui-droppable" dia="27" style="background:rgba(0,0,0,0.2);position:relative;"><div class="numerodia"><b>27</b></div></div>
			<div class="dia ui-droppable" dia="28" style="background:rgba(0,0,0,0.2);position:relative;"><div class="numerodia"><b>28</b></div></div>
			<div style="clear:both;"></div><div class="dia ui-droppable" dia="29" style="position:relative;"><div class="numerodia"><b>29</b></div></div>
			<div class="dia ui-droppable" dia="30" style="position:relative;"><div class="numerodia"><b>30</b></div></div>
			<div class="dia ui-droppable" dia="31" style="position:relative;"><div class="numerodia"><b>31</b></div></div>
			-->
			</div>
			<div id="nuevoevento" style="display: none;">
				<div id="contieneform">
					<div id="cerrarnuevoevento">X</div>
					<form action="http://localhost:8080/WebCalendario/acciones/nuevoEvento.jsp" method="POST">
					<input type="hidden" name="anio">
						<input type="hidden" name="mes">
						<h3>Nuevo evento</h3>
					<table width="100%" id="tablanuevoevento" cellpadding="0" cellspacing="0">
						<tbody><tr>
							<td>
								Año:
							</td>
							<td>
								2121		
							</td>
						</tr>
						<tr>
							<td>
							Mes:	
							</td>
							<td>
								Sep							</td>
						</tr>
						<tr>
							<td>
								Dia:
							</td>
							<td>
								<input type="text" name="dia" id="dimedia">
							</td>
						</tr>
						<tr>
							<td>
								Calendario:
							</td>
							<td>
								<select name="calendario">
								<%
				
								try{
									String conexion = "jdbc:mysql://localhost:3306/webcalendario";
									Connection conecction = null;
									Class.forName("com.mysql.jdbc.Driver").newInstance();
									conecction = DriverManager.getConnection(conexion, "jjpalacio", "amorpropio");
									
									Statement stm = conecction.createStatement();
									ResultSet rst;
									
									String peticion = "Select * from calendarios";
									
									rst = stm.executeQuery(peticion);
									
									while(rst.next()){
										
										out.println("<option value='"+rst.getInt("idcalendario")+"'>"+rst.getString("nombre")+"</option>");
										
									} 
									
									stm.close();
									conecction.close();
								} 
								catch(Exception ej){
									
									out.println(ej.getMessage().toString());
									
								}
							
							 %>
								
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Hora de inicio:
							</td>
							<td>
								<select name="hora">
									<%
										for(int hora=0; hora <= 24; hora ++){

											out.println("<option value='"+hora+"'>"+hora+"</option>");
										}
									%>
								</select>:
						
								<select name="minuto">
									<%
										for(int minuto=0; minuto <= 60; minuto += 5){

											out.println("<option value='"+minuto+"'>"+minuto+"</option>");
										}
									%>						
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Duración:
							</td>
							<td>
								<select name="duracion">
						<option value="0">0</option><option value="30">0:30</option><option value="60">1</option><option value="90">1:30</option><option value="120">2</option><option value="150">2:30</option><option value="180">3</option><option value="210">3:30</option><option value="240">4</option><option value="270">4:30</option><option value="300">5</option><option value="330">5:30</option><option value="360">6</option><option value="390">6:30</option><option value="420">7</option><option value="450">7:30</option><option value="480">8</option><option value="510">8:30</option><option value="540">9</option><option value="570">9:30</option><option value="600">10</option><option value="630">10:30</option><option value="660">11</option><option value="690">11:30</option><option value="720">12</option><option value="750">12:30</option><option value="780">13</option><option value="810">13:30</option><option value="840">14</option><option value="870">14:30</option><option value="900">15</option><option value="930">15:30</option><option value="960">16</option><option value="990">16:30</option><option value="1020">17</option><option value="1050">17:30</option><option value="1080">18</option><option value="1110">18:30</option><option value="1140">19</option><option value="1170">19:30</option><option value="1200">20</option><option value="1230">20:30</option><option value="1260">21</option><option value="1290">21:30</option><option value="1320">22</option><option value="1350">22:30</option><option value="1380">23</option><option value="1410">23:30</option>						</select>
							</td>
						</tr>
						<tr>
							<td>
								Nombre del evento:
							</td>
							<td>
								<input type="text" name="nombre" placeholder="nombre">
							</td>
						</tr>
						<tr>
							<td>
								
							</td>
							<td>
								<input type="submit">
							</td>
						</tr>
						
					</tbody></table>	
				</form>
			</div>
			</div>
			
			<!--/////// -->
			<div id="nuevocalendarioform" style="display: none;">
				<div id="contieneform">
					<div id="cerrarnuevocalendario">X</div>
					<form action="http://localhost:8080/WebCalendario/acciones/nuevoCalendario.jsp" method="POST">
					<input type="hidden" name="anio">
					<input type="hidden" name="mes">
						<h3>Nuevo calendario</h3>
							<input type="text" name="nombrecalendario">
							<input type="submit" >			
					</form>
				</div>
			</div>
			
			
			<!--/////// -->
			
		<div id="ajax"></div>
	
</body></html>
