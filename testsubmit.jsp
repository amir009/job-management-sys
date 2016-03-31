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
	   
    
        int total = Integer.parseInt(request.getParameter("total"));
        int result = Integer.parseInt(request.getParameter("result"));	
        int jobid = Integer.parseInt(request.getParameter("jobid"));	

        ps=conn.prepareStatement("insert into  test_results  (jobid,empid,result,total,testtaken) values(?,?,?,?,?)");
	ps.setInt(1,jobid);
	ps.setInt(2,userId);
	ps.setInt(3,result);
	ps.setInt(4,total);
	
	ps.setBoolean(5,true);
	int i=ps.executeUpdate();

        out.print("applied successfully");
        
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
