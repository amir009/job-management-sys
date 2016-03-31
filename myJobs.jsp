<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

<%! ResultSet rs=null; %>
<%! boolean isNewJob=true,testRequired=true; %>
<%! String jobid="",job_title="",qualifications="",skills="",responsibilities="",status="",experience="",companyname="",lastdate="",location="",pageNo=""; %>
<%! int employerId,vacancies,total,myscr,uid,jobId,prevpg=0,pageno=0,cnt=0,exp=0,perpage=5,prv=0; %>
<%! String pageUrlparams,exper,skill,loc,searchQ=""; %>
<%
     String url = request.getRequestURL().toString();
    String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    
    
    if(session.getAttribute("username")!=null && session.getAttribute("userId") !=null  ){
       Integer  uid=(Integer)session.getAttribute("userId");
        //jobid=request.getParameter("jobid");
        pageNo="";
        exper="";
        skill="";
        searchQ="";
        pageNo=request.getParameter("pageno");
        pageno=0;
        pageUrlparams="";
        
        if(pageNo!=null&&!pageNo.equals("")){
        pageno=Integer.parseInt(pageNo);
        prevpg=pageno;
        //pageUrlparams="pageNo="+pageNo;
        }
        exper=request.getParameter("exper");
        if(exper!=null&&!exper.equals("")){
        pageUrlparams=pageUrlparams+"&exper="+exper;
        
        searchQ=" and experience > "+exp;
        }
        skill=request.getParameter("skill");
        if(skill!=null&&!skill.equals("")){
        pageUrlparams=pageUrlparams+"&skill="+skill;
        searchQ=searchQ+" and LOWER(skills) like LOWER('%"+skill+"%') ";
        }
        loc=request.getParameter("loc");
        if(loc!=null&&!loc.equals("")){
        pageUrlparams=pageUrlparams+"&loc="+loc;
        searchQ=searchQ+" and LOWER(location) like LOWER('%"+loc+"%') ";
        }

        if(session.getAttribute("isEmployer")!=null && (Boolean)session.getAttribute("isEmployer")){
        String site = new String(baseURL+"myPosts.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        }
        %>
        <body>
  
        <%@ include file="header.jsp" %>
         <script  type="text/javascript" >
            $(document).ready(function () {

                  $("#searchbtn").on("click",function(){
                      searchit();
                  });
                  $('#searchinp').keypress(function (e) {
                      if (e.which == 13) {
                          searchit();
                      }
                      });
                  });
             function searchit(){
                 alert("Searching");
             
                val= $("#searchque").val();
                str= $("#searchinp").val();
                exp= $("#exp").val();
                urlprm="";
               
                 if(val==1){
                     urlprm="?skill="+str;
                }else{
                    urlprm="?loc="+str;
                }
                if(exp!==0){
                   urlprm=urlprm+ "&exp="+exp;
                }
                
                 window.location="myJobs.jsp"+urlprm;
             }    
            </script>
        <div class="wrapper" >
        <h1 class="text-center " style="color:#719f37">My Jobs</h1>
        <div id="profileDetails" class="profileDetails" >
            <div class="col-md-3 col-lg-3 " align="center">
	<img  src="images/j10.jpg" width="300" height="300" />
         
            </div>
        
            <div class=" col-md-9 col-lg-9 ">
                <div class="searchDiv ">

                <div id="custom-search-input">
                            <div class=" col-sm-4 " style="display: table">
                                <input type="text" id="searchinp" class="  search-query form-control" placeholder="Search" />
                                <span class="input-group-btn">
                                    <button id="searchbtn" class="btn btn-danger" type="button">
                                        <span class=" glyphicon glyphicon-search"></span>
                                    </button>
                                </span>
                            </div>
                    <div class="col-sm-2">
                        <select id="searchque" name="" class="form-control">
                            <option value="1">Skills</option>
                            
                            <option value="2">Location</option>                      
                        </select>
                        </div>
                    <div class="col-sm-2">
                          <label  class="col-sm-3 control-label">Experience</label>   
                    </div>
                        </div>
                    
                    
                    <div class="col-sm-2">
                        <select id="exp" name="" class="form-control">
                            <option value="0">0+</option>                     
                            <option value="1">1+</option>                     
                            <option value="2">2+</option>                     
                            <option value="3">3+</option>                     
                            <option value="4">4+</option>                     
                            <option value="5">5+</option>                     
                            <option value="6">6+</option>                     
                            <option value="7">7+</option>                     
                            <option value="8">8+</option>                     
                            <option value="9">9+</option>                     
                            <option value="10">10+</option>                       
                        </select>
                    </div>
                    
               
                </div>
                
            <table class="table table-striped table-bordered" style="margin-top: 50px">
                <thead>
                <tr  >
                <th class="col-sm-3">
                    <strong class="Theader">Job Title & Company</strong> 
                </th>
                <th class="col-sm-2">
                    <strong class="Theader">Qualification</strong> 
                </th>
                <th class="col-sm-2">
                    <strong class="Theader">Location</strong> 
                </th>
                <th class="col-sm-1">
                    <strong class="Theader">Vacancies</strong> 
                </th>
                              
                <th class="col-sm-1">
                    <strong class="Theader">My Score </strong> 
                </th> 
                <th class="col-sm-3">
                    <strong class="Theader">Last Date To Apply</strong> 
                </th> 
            </tr>
            </thead>
            <tbody>
        <%
            int start=perpage*pageno;
            String query="SELECT * FROM jobs j LEFT JOIN employer e ON j.employerId = e.uid LEFT JOIN test_results t ON j.jobid = t.jobid where Status='ACTIVE' and t.empid= "+uid+" ";
            String orderby="   order by j.jobid desc limit "+start+","+perpage;
             cnt=0;
        rs=st.executeQuery(query+searchQ+orderby);
	while(rs.next()){
            if(cnt==perpage-1){
            pageno++;
            }
         jobid=rs.getString("jobid");
         companyname	  = rs.getString("companyname");
         job_title	= rs.getString("job_title");
         qualifications = rs.getString("qualifications");
         skills = rs.getString("skills");
         responsibilities = rs.getString("responsibilities");
         experience = rs.getInt("experience")+"+ years";	
         employerId	= rs.getInt("employerId");
         vacancies= rs.getInt("vacancies");
         testRequired = rs.getBoolean("testRequired");
         lastdate	= rs.getString("lastdate");
         location	= rs.getString("location");
         total	= rs.getInt("total");
         myscr	= rs.getInt("result");
         cnt++;
        %>
          <tr class=" jtable" >
                <td class="col-sm-3 pointer">
                    <a href="jobdetails.jsp?jobid=<%=jobid%>"> <span class="row" style="color:#990033;font-size: 15px;font-weight:bold "><%=job_title%></span>   
                        <span class="row" style="color:#000099;font-size: 15px;font-weight:bolder;font-style: italic;"><%=companyname%></span>   </a>
                </td>
                <td class="col-sm-2">
                     <span class=""><%=qualifications%></span>  
                </td>
                <td class="col-sm-2">
                    <span class=""><%=location%></span> 
                </td>
                <td class="col-sm-1">
                     <span class=""><%=vacancies%></span> 
                </td>
                <td class="col-sm-1">
                     <span class=""><%=myscr%>/<%=total%></span> 
                </td>
                <td class="col-sm-3">
                    <span class=""><%=lastdate%></span> 
                </td>               
            </tr>

        <%
         
        }
        if(cnt==0){
        %>
        <tr class=" jtable" ><td colspan="5">No More Jobs Available</td></tr>
            
            <% }


        }
        
        
    
    else{
    String site = new String(baseURL+"login.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
%>
</tbody>
            </table> 
        
        <% if(pageno>=1 && prevpg >=1 ){ 
            prv=pageno-1;
        %> 
        
        <div class="pull-left"><a href="myPosts.jsp?pageno=<%=prv+pageUrlparams%>"><button type="button" class="btn btn-primary btn-block ">Back</button></a></div>
        <%}%>
        <% if(cnt>=perpage){ %>

<div class="pull-right "><a href="myPosts.jsp?pageno=<%=pageno+pageUrlparams%>"><button type="button" class="btn btn-primary btn-block ">Next</button></a></div>
<%}%>
        </div>    
        </div>
        </div>
        
       
    </body>
</html>
