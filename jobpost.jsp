<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

<%! ResultSet rs=null; %>
<%! boolean isNewJob=true,testRequired=true; %>
<%! String jobid="",job_title="",qualifications="",skills="",responsibilities="",status="",experience="",companyname="",lastdate="",location=""; %>
<%! int employerId,vacancies,jobId; %>

<%
    
    if(session.getAttribute("username")!=null && session.getAttribute("userId") !=null   && session.getAttribute("isEmployer")!=null && (Boolean)session.getAttribute("isEmployer")){
        Integer uid=(Integer)session.getAttribute("userId");
        jobid=request.getParameter("jobid");
        if(jobid!=null && !jobid.equals("")){
            
            isNewJob=false;
            jobId=Integer.parseInt(jobid);
        }
        if(!isNewJob){
        rs=st.executeQuery("select * from jobs j,employer e where e.uid =j.employerId and e.uid="+uid +" and j.jobid= "+jobId);
	if(rs.next()){
            
         companyname	  = rs.getString("companyname");
         job_title	= rs.getString("job_title");
         qualifications = rs.getString("qualifications");
         skills = rs.getString("skills");
         responsibilities = rs.getString("responsibilities");
         experience = rs.getString("experience");	
         employerId	= rs.getInt("employerId");
         vacancies= rs.getInt("vacancies");
         testRequired = rs.getBoolean("testRequired");
         lastdate	= rs.getString("lastdate");
         location	= rs.getString("location");
   
        }else{
        jobId=0;
        }
        
        }
    }
    else{
    String url = request.getRequestURL().toString();
    String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    String site = new String(baseURL+"login.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
%>

    <body>
        <%@ include file="header2.jsp" %>
                <script>
            $(document).ready(function(){
              
        $("#savejobbtn").on("click",function(){
           var validForm=$("#jobfrm").validationEngine('validate');
			if(validForm){
				$("#jobfrm").submit();
			} 
        });
             
                
                
            });
            
      function confirmPwd(field, rules, i, options){
	if (field.val() !== $("#password").val()) {
     return "Passwords Don't Match";
	}
	}
   
            
            
            
        </script>
        <div class="wrapper" >
        <h1 class="text-center " style="color:#719f37">Post Job</h1>
        <div id="profileDetails" class="profileDetails" >
            <div class="col-md-3 col-lg-3 " align="center">
	<img  src="images/j4.jpg" width="300" height="300" />
         
            </div>
        
            <div class=" col-md-9 col-lg-9 ">
                
                  <form class="form-horizontal" role="form" id="jobfrm" method="post" action="jobUpdate.jsp" style="padding: 30px;">

		<div class="form-group">
                    <label for="job_title" class="col-sm-3 control-label">Job Title</label>
                    <div class="col-sm-6">
                        <input type="text" id="job_title" placeholder="Job Title" name="job_title" value="<%=job_title %>" class="form-control validate[required]">
                        <input type="hidden" id="job_id"  name="jobid" value="<%=jobId %>" class="form-control">
                    </div>
                </div>
		<div class="form-group">
                    <label for="companyname" class="col-sm-3 control-label">Company Name</label>
                    <div class="col-sm-6">
                        <input type="text" id="companyname" placeholder="Company Name" name="companyname" value="<%=companyname %>" class="form-control validate[required]">
                    </div>
                </div>

                <div class="form-group">
                    <label for="qualifications" class="col-sm-3 control-label">Qualifications Required</label>
                    <div class="col-sm-6">
                        
                        <input type="text" id="qualifications" placeholder="Qualifications" name="qualifications" value="<%=qualifications %>" class="form-control">
                    </div>
                </div>

                 <div class="form-group">
                    <label for="responsibilities" class="col-sm-3 control-label">Responsibilities Required</label>
                    <div class="col-sm-6">
                        <textarea id="responsibilities" name="responsibilities" class="form-control validate[required]" ><%=responsibilities%></textarea>
                        
                    </div>
                </div>
                        
                 <div class="form-group">
                    <label for="skills" class="col-sm-3 control-label">Skills Required</label>
                    <div class="col-sm-6">
                        <textarea id="skills" name="skills" class="form-control validate[required]" ><%=skills%></textarea>
                        
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="location" class="col-sm-3 control-label ">Location</label>
                    <div class="col-sm-2">
                        <input type="text" id="location" placeholder="location" name="location" value="<%=location %>" class="form-control validate[required]">
                    </div>
                    <label for="vacancies" class="col-sm-2 control-label ">Vacancies</label>
                    <div class="col-sm-1">
                        <input type="text" id="vacancies" placeholder="vacancies" name="vacancies" value="<%=vacancies %>" class="form-control validate[required,custom[number]]">
                    </div>
                    
                </div>         
                    <div class="form-group"> 
                        <label for="experience" class="col-sm-3 control-label ">Experience required</label>
                    <div class="col-sm-2">
                        <input type="text" id="experience" placeholder="zero" name="experience" value="<%=experience %>" class="form-control validate[required,custom[integer]]">(years)
                    </div>
                        <label for="testRequired" class="col-sm-2 control-label ">Test Required</label>
                 <% if(testRequired){ %>
                            <div class="col-sm-1">
                                <label class="radio-inline">
                                   
                                    <input type="radio" id="testRequiredRadio" name="testRequired" checked="checked" value="true">Yes
                                </label>
                            </div>
                            <div class="col-sm-1">
                                <label class="radio-inline">
                                    <input type="radio" id="testnotRequiredRadio" name="testRequired"  value="false">No
                                </label>
                            </div>
                           <% } else{ %>
 
                            <div class="col-sm-1">
                                <label class="radio-inline">
                                   
                                    <input type="radio" id="testRequiredRadio" name="testRequired"  value="true">Yes
                                </label>
                            </div>
                            <div class="col-sm-1">
                                <label class="radio-inline">
                                    <input type="radio" id="testnotRequiredRadio" name="testRequired" checked="checked" value="false">No
                                </label>
                            </div>
                           <% } %>       
                        
            </div> 
              <div class="form-group">
                    <label for="lastdate" class="col-sm-3 control-label">Last Date</label>
                    <div class="col-sm-3">
                        <input type="date" id="lastdate" name="lastdate" class="form-control validate[required,custom[date]]">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-2 col-sm-offset-5">
                        <button type="button" id="savejobbtn" class="btn btn-primary btn-block">Save</button>
                    </div>
                    <div class="col-sm-2">
                        <a href="myPosts.jsp"><button type="button" class="btn btn-primary btn-block">cancel</button></a>
                    </div>
                </div>
            </form> 
        </div>
        </div>
        
        </div>
    </body>
</html>
