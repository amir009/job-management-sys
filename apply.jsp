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
    
    try
    {
       
	Integer uid=(Integer)session.getAttribute("userId");
	   
    
    
        int jobid = Integer.parseInt(request.getParameter("jobid"));	

        ps=conn.prepareStatement("insert into  test_results  (jobid,empid,testtaken) values(?,?,?)");
	ps.setInt(1,jobid);
	ps.setInt(2,uid);
	ps.setBoolean(3,false);
	int i=ps.executeUpdate();

        out.print("applied successfully");
       
   
        String site = new String(baseURL+"myJobs.jsp");
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
