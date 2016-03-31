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
        String secret_ans	=  request.getParameter("secret_ans");
        if(isemployer==null || !isemployer.equals("true")){
        ps=conn.prepareStatement("select uid from employee where username= ? and secret_ans = ?");
        ps.setString(1,username);
	ps.setString(2,secret_ans);
        rs=ps.executeQuery();
	if(rs.next()){
        uid=rs.getInt(1);
        Integer userId= new Integer(uid);
        ps=conn.prepareStatement("update employee set password= ? where uid = ?");
         ps.setString(1,password);
         ps.setInt(2,uid);
	int i=ps.executeUpdate();
        out.print("<div id='successmessage' >success</div>");
        }else{
        out.print("<div id='successmessage' >failed</div>");
        }

            }
        else{
        ps=conn.prepareStatement("select uid from employer where username= ? and secret_ans = ?");
        ps.setString(1,username);
	ps.setString(2,secret_ans);
        rs=ps.executeQuery();
	if(rs.next()){
        uid=rs.getInt(1);
        Integer userId= new Integer(uid);
	 ps=conn.prepareStatement("update employer set password= ? where uid = ?");
         ps.setString(1,password);
         ps.setInt(2,uid);
	int i=ps.executeUpdate();
        out.print("<div id='successmessage' >success</div>");
        }
        else{
        out.print("<div id='successmessage' >failed</div>");
        }

        
            }
    }
    catch(Exception e){
        session.removeAttribute("userId");
        out.print(e);
//   String site = new String(baseURL+"registration.jsp?error=1");
//   response.setStatus(response.SC_MOVED_TEMPORARILY);
//   response.setHeader("Location", site);
    
    }
    %>
