<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

<%! ResultSet rs=null; %>
<%! String username="",qual1="",qual2="",qual3="",qual4="",university1="",university2="",university3="",university4="",userid; %>
<%! String branch="",skills="",qualifications="",otherquali="",experience=""; %>
<%! String addressid="",add1="",add2="",add3="",phonenumber=""; %>
<%! int yearofpass1,yearofpass2,yearofpass3,yearofpass4,zip; %>
<%! float percent1,percent2,percent3,percent4; %>
<%! boolean iscurrentUser=true; %>
<% String url = request.getRequestURL().toString();
    String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    
    
    if(session.getAttribute("username")!=null && session.getAttribute("userId") !=null){
        Integer uid=(Integer)session.getAttribute("userId");
        userid=request.getParameter("profileid");
        if(userid!=null && !userid.equals("")){
            if(uid!=Integer.parseInt(userid)){
            iscurrentUser=false;
            }
        uid=Integer.parseInt(userid);
        }
        if(session.getAttribute("isEmployer")!=null && (Boolean)session.getAttribute("isEmployer")){
        String site = new String(baseURL+"otherdetailspro.jsp?profileid="+userid);
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        }
        rs=st.executeQuery("select * from employee e,employee_edu edu where e.uid=edu.uid and e.uid ="+uid);
        if(rs.next()){
            username=rs.getString("username");
            qual1= rs.getString("qual1");
            qual2= rs.getString("qual2");
            qual3= rs.getString("qual3");
            qual4= rs.getString("qual4");
            university1= rs.getString("university1");
            university2= rs.getString("university2");
            university3= rs.getString("university3");
            university4= rs.getString("university4");
                    
            yearofpass1= rs.getInt("yearofpass1");
            yearofpass2= rs.getInt("yearofpass2");
            yearofpass3= rs.getInt("yearofpass3");
            yearofpass4= rs.getInt("yearofpass4");
          
            percent1= rs.getFloat("percent1");
            percent2= rs.getFloat("percent2");
            percent3= rs.getFloat("percent3");
            percent4= rs.getFloat("percent4");

        }
        rs=st.executeQuery("select * from employee e,employee_resume res where  e.uid=res.uid and e.uid ="+uid);
        if(rs.next()){
            username=rs.getString("username");
            branch= rs.getString("branch");
            skills= rs.getString("skills");
            qualifications= rs.getString("qualifications");
            otherquali= rs.getString("otherquali");
            experience= rs.getString("experience");

          

        }
        rs=st.executeQuery("select * from employee e,address a where e.addressid=a.addressid and e.uid ="+uid);
	if(rs.next()){
            username=rs.getString("username");
            

            addressid= rs.getString("addressid");
            add1= rs.getString("add1");
            add2= rs.getString("add2");
            add3= rs.getString("add3");


            phonenumber= rs.getString("phonenumber");
            zip= rs.getInt("zip");
            

        }
    }
    else{
   String site = new String(baseURL+"login.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
    </head>
    <body>
        <%@ include file="header.jsp" %>
         <script  type="text/javascript" >
           $(document).ready(function () {
                 $("#chgPwddiv").dialog({
			autoOpen : false,
			modal : true,
			resizable : false,
			draggable : false,
			width:600,
                        height:400
		});
                
                $("#securitylink").on("click",function(){
                      $("#chgPwddiv").dialog('open');
                });
               
           });
           
           function changePassword(){
                var validForm=$("#changePwdfrm").validationEngine('validate');
		if(validForm){
		$.post( "changepassword.jsp", $( "#changePwdfrm" ).serialize() ).done(function( data ) {
                   $("#resultdiv").html(data);
                   var dat=$("#successmessage").html();
                    if(dat==="success"){
                        alert( "Password chnaged successfully ");
                       $("#changePwdfrm").dialog('close'); 
                    }else{
                        alert( "Incorect details provided ");
                    }
                     
                    });
			}
                    }
                    
         function confirmPwd(field, rules, i, options){
	if (field.val() !== $("#password").val()) {
         return "Passwords Don't Match";
	}
	}         
           </script>
        <div class="wrapper" >
        <h2>Personal Details</h2>
        <div id="profileDetails" class="profileDetails" >
            <div class="col-md-2 col-lg-2 " align="center">
	<img alt="User Pic" src="images/profile-pic.jpg" width="200px" height="200px" class="img-circle">
         <div class="row">
         <%=username %>
         </div>
            </div>
        
            <div class=" col-md-9 col-lg-9 ">
                <ul class="nav nav-tabs">
                    <li ><a href="profile.jsp">Personal Details</a></li>
                    <li class="active"><a href="#">Professional Details</a></li>
                    <li><a id="securitylink"  href="#">Change password</a></li>
                </ul>
                  <form class="form-horizontal" id="OtherDetailsUpdate" role="form" method="post" action="OtherDetailsUpdate.jsp" style="padding: 30px;">

                     
		<div class="form-group">
                    <span class="band col-md-12" >Education Details</span>
                </div>
		<div class="form-group">
                    <label for="qual1" class="col-sm-4 control-label text-center">Qualification</label>
                    
                    <label for="university1" class="col-sm-4 control-label text-center">University</label>
                    
                     <label for="yearofpass1" class="col-sm-2 control-label text-center">Year of pass</label>
                    
                     <label for="university1" class="col-sm-2 control-label text-center">Percentage</label>
                    
                </div>
		<div class="form-group">
                    
                    <div class="col-sm-4">
                        <span ><%=qual1 %></span>
                    </div>
                    
                    <div class="col-sm-4">
                        <span ><%=university1 %></span>
                    </div>
                   
                    <div class="col-sm-2 text-center">
                        <span ><%=yearofpass1 %></span>
                    </div>
                    
                    <div class="col-sm-2 text-center">
                        <span ><%=percent1 %></span>
                    </div>
                </div>

                 <div class="form-group">
                    
                    <div class="col-sm-4">
                        <span ><%=qual2 %></span>
                    </div>
                    
                    <div class="col-sm-4">
                        <span ><%=university2 %></span>
                    </div>
                   
                    <div class="col-sm-2 text-center">
                        <span ><%=yearofpass2 %></span>
                    </div>
                    
                    <div class="col-sm-2 text-center">
                        <span ><%=percent2 %></span>
                    </div>
                </div>
                    
                 <div class="form-group">
                    
                    <div class="col-sm-4">
                        <span ><%=qual3 %></span>
                    </div>
                    
                    <div class="col-sm-4">
                      <span ><%=university3 %></span>
                    </div>
                   
                    <div class="col-sm-2 text-center">
                        <span ><%=yearofpass3 %></span>
                    </div>
                    
                    <div class="col-sm-2 text-center">
                        <span ><%=percent3 %></span>
                    </div>
                </div>
                    
                 <div class="form-group">
                    
                    <div class="col-sm-4">
                       <span ><%=qual4 %></span>
                    </div>
                    
                    <div class="col-sm-4 ">
                        <span ><%=university4 %></span>
                    </div>
                   
                    <div class="col-sm-2 text-center">
                        <span ><%=yearofpass4 %></span>
                    </div>
                    
                    <div class="col-sm-2 text-center">
                        <span ><%=percent4 %></span>
                    </div>
                </div>
                    
                 <div class="form-group">
                    <span class="band col-md-12" >Professional details</span>
                </div>   
                 <div class="form-group">
                    
                    <label for="Designation" class="col-sm-2 control-label ">Designation</label>
                    <div class="col-sm-3 control-label2">
                        <span ><%=skills %></span>
                    </div>
                    <label for="experience" class="col-sm-2 control-label ">experience</label>
                    <div class="col-sm-3 control-label2">
                        <span ><%=experience %></span>(years)
                    </div>
                </div>   
                 <div class="form-group">
                    
                    <label for="skills" class="col-sm-2 control-label ">Skills</label>
                    <div class="col-sm-8 control-label2">
                        <span ><%=skills %></span>
                    </div>
                </div>
                <div class="form-group">
                    
                    <label for="qualifications" class="col-sm-2 control-label ">qualifications</label>
                    <div class="col-sm-8 control-label2">
                        <span ><%=qualifications %></span>
                    </div>
                </div>  
                <div class="form-group">
                    
                    <label for="otherquali" class="col-sm-2 control-label ">Other qualifications</label>
                    <div class="col-sm-8 control-label2">
                        <span ><%=otherquali %></span>
                    </div>
                </div> 
                 <div class="form-group">
                    <span class="band col-md-12" >Address</span>
                </div> 
                 <div class="form-group">
                    
                    <label for="add1" class="col-sm-2 control-label ">Address 1</label>
                    <div class="col-sm-8 control-label2">
                        <span ><%=add1 %></span>
                        
                    </div>
                </div>
                <div class="form-group">
                    
                    <label for="add2" class="col-sm-2 control-label ">Address 2</label>
                    <div class="col-sm-8 control-label2">
                        <span ><%=add2 %></span>
                    </div>
                </div>
                <div class="form-group">
                    
                    <label for="add3" class="col-sm-2 control-label ">Address 3</label>
                    <div class="col-sm-8 control-label2">
                        <span ><%=add3 %></span>
                    </div>
                </div>
                 <div class="form-group">
                    
                    <label for="phonenumber" class="col-sm-2 control-label ">Phone no.</label>
                    <div class="col-sm-3 control-label2">
                        <span ><%=phonenumber %></span>
                    </div>
                    <label for="zip" class="col-sm-2 control-label ">Zip Code</label>
                    <div class="col-sm-3 control-label2">
                        <span ><%=zip %></span>
                    </div>
                </div> 
                <% if(iscurrentUser){ %>
                <div class="form-group">
                   
                    <div class="col-sm-2 col-sm-offset-6">
                        <a href="otherDetailsEdit.jsp"><button type="button" class="btn btn-primary btn-block">Edit</button></a>
                    </div>
                </div>
                <% } %>
            </form> 
        </div>
        </div>
        
        </div>
            <div id="chgPwddiv" title="Change Pasword" >
            <form class="form-horizontal" method="post" id="changePwdfrm" action="changepassword.jsp">
            <div class="form-group">
                    <label for="oldpassword" class="col-sm-3 " style="text-align: right;padding: 10px">Old Password</label>
                    <div class="col-sm-4">
                        <input type="password" id="oldpassword" placeholder="Old password" name="oldpassword" class="form-control validate[required]" autofocus>  
                        <input type="hidden" id="username"  name="username" class="form-control " value="<%=username %>" >  
                        <input type="hidden" id="isemployer"  name="isemployer" class="form-control " value="" >  
                    </div>
                    
            </div>
            <div class="form-group">
                    <label for="password" class="col-sm-3 " style="text-align: right;padding: 10px">New Password</label>
                    <div class="col-sm-4">
                        <input type="password" id="password" placeholder="Password" name="password" class="form-control validate[required]" >  
                    </div>
                    
            </div>
            <div class="form-group">
                    <label for="confirmPassword" class="col-sm-3 " style="text-align: right;padding: 10px">confirm Password</label>
                    <div class="col-sm-4">
                        <input type="password" id="confirmPassword" placeholder="Confirm Password"  class="form-control validate[required,funcCall[confirmPwd]]" >  
                    </div>
                   
            </div>
            <div class="form-group">
                   
                    <div class="col-sm-3 col-sm-offset-4">
                        <button type="button" onclick="changePassword()" class="btn btn-primary btn-block">Submit</button>
                    </div>
            </div>
            
            
          
            
            
            <div id="resultdiv" style="display:none" ></div>
            </form>
        </div>
    </body>
</html>
