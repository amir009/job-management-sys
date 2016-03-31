<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

 <%       
        String url = request.getRequestURL().toString();
        String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    	
	PreparedStatement ps=null;
	ResultSet rs=null;
    %>
    
    <%
    try
    {
       
	Integer userId=(Integer)session.getAttribute("userId");
	   
    
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");	
        String companyname	= request.getParameter("companyname");
        String gender= request.getParameter("gender");
        String email = request.getParameter("email");
        String cellno	= request.getParameter("cellno");	
        String designation	= request.getParameter("designation");
   

        ps=conn.prepareStatement("update employer set first_name=?,last_name= ?,companyname= ?,gender= ?,email= ?,cellno= ?,designation= ? where uid = ?");
	
	
	
	ps.setString(1,first_name);
	ps.setString(2,last_name);
	ps.setString(3,companyname);
	ps.setString(4,gender);
	ps.setString(5,email);
	ps.setString(6,cellno);
	ps.setString(7,designation);
	ps.setInt(8,userId);
	int i=ps.executeUpdate();
        
        
   
   String site = new String(baseURL+"employerprofile.jsp");
   response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", site);
        
    }
    catch(Exception e){
       // session.removeAttribute("userId");
       out.println("<div id=\"error\">");
     e.printStackTrace(new java.io.PrintWriter(out));
    out.println("</div>");
//   String site = new String(baseURL+"registration.jsp?error=1");
//   response.setStatus(response.SC_MOVED_TEMPORARILY);
//   response.setHeader("Location", site);
    
    }
    %>

