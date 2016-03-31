<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,javax.mail.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

 <%       
        String url = request.getRequestURL().toString();
        String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    	
	PreparedStatement ps=null,ps1=null;
	ResultSet rs=null;
    %>
    
    <%
    try
    {
       
	Integer uid=(Integer)session.getAttribute("userId");
	int jobid=0;
        boolean testRequired=true,updatejob=false;
          String jobidstr= request.getParameter("jobid");
           if(jobidstr!=null && !jobidstr.equals("")){
           jobid=Integer.parseInt(jobidstr);
           if(jobid!=0)
           updatejob=true;
           }
          String  job_title= request.getParameter("job_title");
          String  qualifications= request.getParameter("qualifications");
          String  skills= request.getParameter("skills");
          String  responsibilities= request.getParameter("responsibilities");	
          String  experience= request.getParameter("experience");
          String  lastdate= request.getParameter("lastdate");
          String  location= request.getParameter("location");

         int   employerId= uid;
         int   vacancies= Integer.parseInt(request.getParameter("vacancies"));
         int   Experience= Integer.parseInt(request.getParameter("experience"));
         
         String   testRequiredstr= request.getParameter("testRequired");
        if(testRequiredstr!=null && testRequiredstr.equalsIgnoreCase("false")){
        testRequired=false;
        }
          String  status="ACTIVE";
        // request.getParameter("lastdate");
        //java.sql.Date  lastdate	= new java.sql.Date();
   
        if(updatejob){
        ps=conn.prepareStatement("update jobs set job_title=? ,qualifications=? ,skills=? ,responsibilities=? ,experience=? ,employerId=? ,vacancies=? ,lastdate=? ,testRequired=? ,status=?,location=?  where jobid = ?");
	
	ps.setString(1,job_title);
	ps.setString(2,qualifications);
	ps.setString(3,skills);
	ps.setString(4,responsibilities);
	ps.setInt(5,Experience);
	ps.setInt(6,employerId);
	ps.setInt(7,vacancies);
	ps.setString(8,lastdate);
	ps.setBoolean(9,testRequired);
	ps.setString(10,status);
	ps.setString(11,location);
	ps.setInt(12,jobid);
	int i=ps.executeUpdate();
        
        }
else{

        rs=st.executeQuery("select max(jobid) from jobs");
	if(rs.next())
	jobid=rs.getInt(1)+1;
        ps=conn.prepareStatement("insert into jobs (job_title,qualifications,skills,responsibilities,experience,employerId,vacancies,lastdate,testRequired,status,location,jobid) values(? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,?,?) ");
        ps.setString(1,job_title);
	ps.setString(2,qualifications);
	ps.setString(3,skills);
	ps.setString(4,responsibilities);
	ps.setInt(5,Experience);
	ps.setInt(6,employerId);
	ps.setInt(7,vacancies);
	ps.setString(8,lastdate);
	ps.setBoolean(9,testRequired);
	ps.setString(10,status);
	ps.setString(11,location);
	ps.setInt(12,jobid);
	int i=ps.executeUpdate(); 
        
        }
   try{
        final String username = "mail.jobmanagementsystem@gmail.com";
	final String password = "jobmanagementsystem";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

	Session session1 = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
        
        String Skillsaray=skills.replace(",","|");
        
        String UserQuery="select * from employee_resume er,employee e   where e.uid=er.uid and  skills REGEXP ? and experience >= ?";
        ps1=conn.prepareStatement(UserQuery);
        ps1.setString(1,Skillsaray);
	ps1.setInt(2,Experience);
        rs=ps1.executeQuery();
        while(rs.next()){
        Message message = new MimeMessage(session1);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(rs.getString("email")));
			message.setSubject("New Job");
			message.setText("Dear "+rs.getString("username")
				+ "\n\nThanks for using our portal \n New job posted which matches your profile \n <a href='"+baseURL+"jobdetails.jsp?jobid="+jobid+"'>Click Here</a> to view the job");

			Transport.send(message);
        }
     } catch (Exception e){
         e.printStackTrace();
         String site = new String(baseURL+"jobdetails.jsp?jobid="+jobid);
      response.setStatus(response.SC_MOVED_TEMPORARILY);
     response.setHeader("Location", site);
     } 
        
   String site = new String(baseURL+"jobdetails.jsp?jobid="+jobid);
   response.setStatus(response.SC_MOVED_TEMPORARILY);
   response.setHeader("Location", site);
        
    }
    catch(Exception e){
       // session.removeAttribute("userId");
     // out.println("<div id=\"error\">");
     //e.printStackTrace(new java.io.PrintWriter(out));
   //out.println("</div>");
    String site = new String(baseURL+"login.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);
//   String site = new String(baseURL+"registration.jsp?error=1");
//   response.setStatus(response.SC_MOVED_TEMPORARILY);
//   response.setHeader("Location", site);
    
    }
    %>

