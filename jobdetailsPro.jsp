<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

<%! ResultSet rs=null; %>
<%! boolean isNewJob=true,testRequired=true; %>
<%! String jobid="",job_title="",qualifications="",skills="",responsibilities="",status="",experience="",companyname="",lastdate="",location=""; %>
<%! String profileid="",applicantname=""; %>
<%! int employerId,vacancies,jobId; %>

<%
     String url = request.getRequestURL().toString();
    String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    
    
    if(session.getAttribute("username")!=null && session.getAttribute("userId") !=null  ){
        
        
        
        Integer uid=(Integer)session.getAttribute("userId");
        jobid=request.getParameter("jobid");
        if(jobid!=null && !jobid.equals("")){
        jobId=Integer.parseInt(jobid);
        if(session.getAttribute("isEmployer")==null || !(Boolean)session.getAttribute("isEmployer")){
        String site = new String(baseURL+"jobdetails.jsp?jobid="+jobid);
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        }
        
        rs=st.executeQuery("select * from jobs j,employer e where e.uid =employerId  and j.jobid= "+jobId);
	if(rs.next()){
            
         companyname	  = rs.getString("companyname");
         job_title	= rs.getString("job_title");
         qualifications = rs.getString("qualifications");
         skills = rs.getString("skills");
         responsibilities = rs.getString("responsibilities");
         experience = rs.getInt("experience")+"";	
         employerId	= rs.getInt("employerId");
         vacancies= rs.getInt("vacancies");
         testRequired = rs.getBoolean("testRequired");
         lastdate	= rs.getString("lastdate");
         location	= rs.getString("location");
         
        }
        }
        else{
        String site = new String(baseURL+"jobsearch.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        }
        }
    
    else{
    String site = new String(baseURL+"login.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
%>

    <body>
        
        <%@ include file="header2.jsp" %>
        <div class="wrapper" >
        <h1 class="text-center " style="color:#719f37">Job Details</h1>
        <div id="profileDetails" class="profileDetails" >
            <div class="col-md-3 col-lg-3 " align="center">
	<img  src="images/j5.jpg" width="300" height="300" />
         
            </div>
        
            <div class=" col-md-6 col-lg-6 ">
                
                 

		<div class="row">
                    <label for="job_title" class="col-sm-3 control-label">Job Title</label>
                    <div class="col-sm-6">
                        <%=job_title %>
                        <input type="hidden" id="job_id"  name="jobid" value="<%=jobId %>" >
                    </div>
                </div>
		<div class="row">
                    <label for="companyname" class="col-sm-3 control-label">Company Name</label>
                    <div class="col-sm-6">
                         <%=companyname %>
                    </div>
                </div>

                <div class="row">
                    <label for="qualifications" class="col-sm-3 control-label">Qualifications Required</label>
                    <div class="col-sm-6">
                        <%=qualifications%>
                        
                    </div>
                </div>

                 <div class="row">
                    <label for="responsibilities" class="col-sm-3 control-label">Responsibilities Required</label>
                    <div class="col-sm-6">
                        <%=responsibilities%>
                        
                    </div>
                </div>
                        
                 <div class="row">
                    <label for="skills" class="col-sm-3 control-label">Skills Required</label>
                    <div class="col-sm-6">
                        <%=skills%>
                        
                    </div>
                </div>
                
                <div class="row">
                    
                    <label for="vacancies" class="col-sm-3 control-label ">Vacancies</label>
                    <div class="col-sm-3">
                        <%=vacancies %>
                    </div>
                    </div>
                <div class="row">
                    <label for="experience" class="col-sm-3 control-label ">Experience required</label>
                    <div class="col-sm-3">
                        <%=experience %> Years
                    </div>
                </div>         
             <div class="row">  
                        <label for="location" class="col-sm-3 control-label ">Location</label>
                    <div class="col-sm-3">
                        <%=location %>
                    </div>
             </div>
             <div class="row"> 
                        <label for="testRequired" class="col-sm-3 control-label ">Test Required</label>
                 
                            <div class="col-sm-3">
                                <label class="radio-inline">
                                   
                                   <% if(testRequired){ %>
                                   Yes
                                   <% } else { %>
                                   No
                                   <% } %>
                                </label>
                            </div>
     
                </div> 
                <div class="row">
                    <div class="col-sm-3 col-sm-offset-3">
                       <a href="jobpost.jsp?jobid=<%=jobid%>"><button type="button" class="btn btn-primary btn-block">Edit</button></a>
                      
                    </div>
                </div>
            
        </div>
                       <div class="col-md-3 col-lg-3 " align="center">
                           <div class="row">
                               <h3>Applicants</h3>
                           </div>
   <%
       int cnnt=0;
         rs=st.executeQuery("select * from test_results  ts,employee e where ts.empid =e.uid  and ts.jobid= "+jobId);
	while(rs.next()){  
            cnnt++;
    profileid=rs.getInt("uid")+"";
    applicantname=rs.getString("first_name")+" "+rs.getString("last_name");
                        %>  
                        <div class="row">
                            <a href="profilepro.jsp?profileid=<%=profileid %>&jobid=<%=jobId %>" style="padding: 10px;" >
                                <span class="icon icon-user" style="display: table-cell;margin-right: 2px"></span>
                                <span><%=applicantname%></span>
                            </a> 
                        </div>
                        
                          <% } if(cnnt==0){ %>
                        <div class="row">
                            No Applicants
                        </div>
 
 <%}%> 
                       </div>
        </div>
        
        </div>
    </body>
</html>
