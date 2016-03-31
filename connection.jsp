<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%! 
	Connection conn = null;
	Statement st = null;

%>
<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost/changeboss?user=root");
	st=conn.createStatement();
%>