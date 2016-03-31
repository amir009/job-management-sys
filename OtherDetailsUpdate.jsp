<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

 <%       
        String url = request.getRequestURL().toString();
        String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    	
	PreparedStatement ps,ps1,ps2,ps3=null;
	ResultSet rs=null;
    %>
    
    <%
    try
    {
       
	Integer uid=(Integer)session.getAttribute("userId");
	int addressId=1;
    
        String qual1 = request.getParameter("qual1");
        String university1 = request.getParameter("university1");
        String yearofpass1 = request.getParameter("yearofpass1");
        String percent1 = request.getParameter("percent1");
        String qual2 = request.getParameter("qual2");
        String university2 = request.getParameter("university2");
        String yearofpass2 = request.getParameter("yearofpass2");
        String percent2 = request.getParameter("percent2");
        String qual3 = request.getParameter("qual3");
        String university3 = request.getParameter("university3");
        String yearofpass3 = request.getParameter("yearofpass3");
        String percent3 = request.getParameter("percent3");
        String qual4 = request.getParameter("qual4");
        String university4 = request.getParameter("university4");
        String yearofpass4 = request.getParameter("yearofpass4");
        String percent4 = request.getParameter("percent4");
        
        String branch = request.getParameter("branch");
        String experience = request.getParameter("experience");
        String skills = request.getParameter("skills");
        String qualifications = request.getParameter("qualifications");
        String otherquali = request.getParameter("otherquali");
        
        String add1 = request.getParameter("add1");
        String addressid = request.getParameter("addressid");
        String add2 = request.getParameter("add2");
        String add3 = request.getParameter("add3");
        String phonenumber = request.getParameter("phonenumber");
        String zip = request.getParameter("zip");

        

        //insert or update emp_edu
        
        rs=st.executeQuery("select * from employee_edu where uid="+uid);
	if(rs.next())
        {
        //update
             ps=conn.prepareStatement("update employee_edu set qual1 = ?,university1 = ?,yearofpass1 = ?,percent1 = ?,qual2 = ?,university2 = ?,yearofpass2 = ?,percent2 = ?,qual3 = ?,university3 = ?,yearofpass3 = ?,percent3 = ?,qual4 = ?,university4 = ?,yearofpass4 = ?,percent4 = ? where uid = ?");
            ps.setString(1,qual1);
            ps.setString(2,university1);
            ps.setInt(3,Integer.parseInt(yearofpass1));
            ps.setFloat(4,Float.parseFloat(percent1));
            ps.setString(5,qual2);
            ps.setString(6,university2);
            ps.setInt(7,Integer.parseInt(yearofpass2));
            ps.setFloat(8,Float.parseFloat(percent2));
            ps.setString(9,qual3);
            ps.setString(10,university3);
            ps.setInt(11,Integer.parseInt(yearofpass3));
            ps.setFloat(12,Float.parseFloat(percent3));
            ps.setString(13,qual4);
            ps.setString(14,university4);
            ps.setInt(15,Integer.parseInt(yearofpass4));
            ps.setFloat(16,Float.parseFloat(percent4));

             
             ps.setInt(17,uid);
            int i=ps.executeUpdate();
             
        }
        else{
            ps=conn.prepareStatement("insert into employee_edu (qual1,university1,yearofpass1,percent1,qual2,university2,yearofpass2,percent2,qual3,university3,yearofpass3,percent3,qual4,university4,yearofpass4,percent4,uid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1,qual1);
            ps.setString(2,university1);
            ps.setInt(3,Integer.parseInt(yearofpass1));
            ps.setFloat(4,Float.parseFloat(percent1));
            ps.setString(5,qual2);
            ps.setString(6,university2);
            ps.setInt(7,Integer.parseInt(yearofpass2));
            ps.setFloat(8,Float.parseFloat(percent2));
            ps.setString(9,qual3);
            ps.setString(10,university3);
            ps.setInt(11,Integer.parseInt(yearofpass3));
            ps.setFloat(12,Float.parseFloat(percent3));
            ps.setString(13,qual4);
            ps.setString(14,university4);
            ps.setInt(15,Integer.parseInt(yearofpass4));
            ps.setFloat(16,Float.parseFloat(percent4));
            ps.setInt(17,uid);
            int i=ps.executeUpdate();
        }
        
         rs=st.executeQuery("select * from employee_resume where uid="+uid);
	if(rs.next())
        {
        //update
            ps1=conn.prepareStatement("update employee_resume set branch = ?,skills = ?,experience = ?,qualifications = ?,otherquali = ? where uid = ?");
            ps1.setString(1,branch);
            ps1.setString(2,skills);
            ps1.setString(3,experience);
            ps1.setString(4,qualifications);
            ps1.setString(5,otherquali);
            ps1.setInt(6,uid);
            int i=ps1.executeUpdate();
             
        }
        else{
            ps1=conn.prepareStatement("insert into employee_resume (branch,skills,experience,qualifications,otherquali,uid) values(?,?,?,?,?,?)");
            ps1.setString(1,branch);
            ps1.setString(2,skills);
            ps1.setString(3,experience);
            ps1.setString(4,qualifications);
            ps1.setString(5,otherquali);
            ps1.setInt(6,uid);
            int i=ps1.executeUpdate();
        }
        
        // address
        if(addressid!=null && !addressid.equals("")){
        // update address
        addressId=Integer.parseInt(addressid);
        ps2=conn.prepareStatement("update address set add1 = ?,add2 = ?,add3 = ?,phonenumber = ?,zip = ? where addressid = ?");
            ps2.setString(1,add1);
            ps2.setString(2,add2);
            ps2.setString(3,add3);
            ps2.setString(4,phonenumber);
            ps2.setInt(5,Integer.parseInt(zip));
            ps2.setInt(6,addressId);
            int i=ps2.executeUpdate();
        }else{
        rs=st.executeQuery("select max(addressid) from address");
	if(rs.next())
	addressId=rs.getInt(1)+1;
        
            ps2=conn.prepareStatement("insert into address (add1,add2,add3,phonenumber,zip,addressid) values(?,?,?,?,?,?) ");
            ps2.setString(1,add1);
            ps2.setString(2,add2);
            ps2.setString(3,add3);
            ps2.setString(4,phonenumber);
            ps2.setInt(5,Integer.parseInt(zip));
            ps2.setInt(6,addressId);
            int i=ps2.executeUpdate();
            ps3=conn.prepareStatement("update employee set addressid = ? where uid = ?");
           ps3.setInt(1,addressId);
           ps3.setInt(2,uid);
           i=ps3.executeUpdate();
        
        }
      
	
	
	
	
        
        
   
   String site = new String(baseURL+"otherDetails.jsp");
   response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", site);
        
    }
    catch(Exception e){
       // session.removeAttribute("userId");
        out.print(e.getCause());
//   String site = new String(baseURL+"registration.jsp?error=1");
//   response.setStatus(response.SC_MOVED_TEMPORARILY);
//   response.setHeader("Location", site);
    
    }
    %>
