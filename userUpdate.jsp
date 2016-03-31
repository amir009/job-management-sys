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
        String dob	= request.getParameter("dob");
        String gender= request.getParameter("gender");
        String email = request.getParameter("email");
        String cellno	= request.getParameter("cellno");	
        String hobbies	= request.getParameter("hobbies");
        
        

        ps=conn.prepareStatement("update employee set first_name=?,last_name= ?,dob= ?,gender= ?,email= ?,cellno= ?,hobbies= ? where uid = ?");
	
	
	
	ps.setString(1,first_name);
	ps.setString(2,last_name);
	ps.setString(3,dob);
	ps.setString(4,gender);
	ps.setString(5,email);
	ps.setString(6,cellno);
	ps.setString(7,hobbies);
	ps.setInt(8,userId);
	int i=ps.executeUpdate();
        
        
   
   String site = new String(baseURL+"profile.jsp");
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
