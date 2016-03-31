<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 <%       
        String url = request.getRequestURL().toString();
        String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    	int uid=1000;
	PreparedStatement ps=null;
	ResultSet rs=null;
    %>
    
    <%
    try
    {
        rs=st.executeQuery("select max(uid) from employee");
	if(rs.next())
	uid=rs.getInt(1)+1;
	Integer userId= new Integer(uid);
	session.setAttribute("userId",uid);

    
    
        String username	  = request.getParameter("username");
        String password	= request.getParameter("password");
        String secret_ques = request.getParameter("secret_ques");
        String secret_ans = request.getParameter("secret_ans");
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");	
        String dob	= request.getParameter("dob");
        String gender= request.getParameter("gender");
        String email = request.getParameter("email");
        String cellno	= request.getParameter("cellno");	
        String hobbies	= request.getParameter("hobbies");
        

        ps=conn.prepareStatement("insert into employee (uid,username,password,secret_ques,secret_ans,first_name,last_name,dob,gender,email,cellno,hobbies) values(?,?,?,?,?,?,?,?,?,?,?,?)");
	ps.setInt(1,userId);
	ps.setString(2,username);
	ps.setString(3,password);
	ps.setString(4,secret_ques);
	ps.setString(5,secret_ans);
	ps.setString(6,first_name);
	ps.setString(7,last_name);
	ps.setString(8,dob);
	ps.setString(9,gender);
	ps.setString(10,email);
	ps.setString(11,cellno);
	ps.setString(12,hobbies);
	int i=ps.executeUpdate();
        
        
   
   session.setAttribute("username",username);
   String site = new String(baseURL+"profile.jsp");
   response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", site);
        
    }
    catch(Exception e){
        session.removeAttribute("userId");
        out.print(e);
//   String site = new String(baseURL+"registration.jsp?error=1");
//   response.setStatus(response.SC_MOVED_TEMPORARILY);
//   response.setHeader("Location", site);
    
    }
    %>
