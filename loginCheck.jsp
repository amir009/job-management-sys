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
        int uid=0;
        String username	  = request.getParameter("username");
        String password	=  request.getParameter("password");
        String isemployer	=  request.getParameter("isemployer");
        if(isemployer==null || !isemployer.equals("true")){
        ps=conn.prepareStatement("select uid from employee where username= ? and password = ?");
        ps.setString(1,username);
	ps.setString(2,password);
        rs=ps.executeQuery();
	if(rs.next()){
        uid=rs.getInt(1);
        Integer userId= new Integer(uid);
	session.setAttribute("userId",uid);
        session.setAttribute("username",username);
        session.setAttribute("isEmployer",false);
        String site = new String(baseURL+"profile.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
        }
        else{
        String site = new String(baseURL+"login.jsp?error=1");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
        }

        
            }
        else{
        ps=conn.prepareStatement("select uid from employer where username= ? and password = ?");
        ps.setString(1,username);
	ps.setString(2,password);
        rs=ps.executeQuery();
	if(rs.next()){
        uid=rs.getInt(1);
        Integer userId= new Integer(uid);
	session.setAttribute("userId",uid);
        session.setAttribute("username",username);
        session.setAttribute("isEmployer",true);
        String site = new String(baseURL+"employerprofile.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
        }
         else{
        String site = new String(baseURL+"login.jsp?error=1");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
        }

        
            }
    }
    catch(Exception e){
        session.removeAttribute("userId");
        out.print(e);
 String site = new String(baseURL+"registration.jsp?error=1");
  response.setStatus(response.SC_MOVED_TEMPORARILY);
  response.setHeader("Location", site);
    
    }
    %>
