<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

<%! ResultSet rs=null; %>
<%! String username,password,secret_ques,secret_ans,first_name,last_name,designation,gender,email,cellno,companyname; %>
<%  
    if(session.getAttribute("username")!=null && session.getAttribute("userId") !=null && session.getAttribute("isEmployer")!=null && (Boolean)session.getAttribute("isEmployer")){
        Integer uid=(Integer)session.getAttribute("userId");
        
        rs=st.executeQuery("select * from employer where uid ="+uid);
	if(rs.next()){
         username	  = rs.getString("username");
         password	= rs.getString("password");
         secret_ques = rs.getString("secret_ques");
         secret_ans = rs.getString("secret_ans");
         first_name = rs.getString("first_name");
         last_name = rs.getString("last_name");	
         designation	= rs.getString("designation");
         gender= rs.getString("gender");
         email = rs.getString("email");
         cellno	= rs.getString("cellno");	
         companyname	= rs.getString("companyname");
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
    </head>
    <body>
        <%@ include file="header2.jsp" %>
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
        <div class="clearfix">
         <%=username %>
         </div>
            </div>
            <div class=" col-md-9 col-lg-9 ">
            
                    <ul class="nav nav-tabs">
                    <li class="active"><a href="#">Personal Details</a></li>
                    <li><a id="securitylink"  href="#">Change Password</a></li>
                    
                  </ul>
                 
                <div class="clearfix">
                    <label for="username" class="col-sm-3 control-label">User Name</label>
                    <div class="col-sm-3">
                        <%=username %>
                        </div>
                </div>
		<div class="clearfix">
                    <label for="first_name" class="col-sm-3 control-label">First Name</label>
                    <div class="col-sm-3">
                        <%=first_name %>
                    </div>
                </div>
				<div class="clearfix">
                    <label for="last_name" class="col-sm-3 control-label">Last Name</label>
                    <div class="col-sm-3">
                        <%=last_name %>
                    </div>
                </div>

                

                <div class="clearfix">
                    <label class="control-label col-sm-3">Gender</label>
                    
                            <div class="col-sm-3">
                                  <%=gender%>   
                            </div>
                    
                </div> 
                <div class="clearfix">
                    <label for="dob" class="col-sm-3 control-label">Designation</label>
                    <div class="col-sm-3">
                        <%=designation%>
                    </div>
                </div>
                <div class="clearfix">
                    <label for="companyname" class="col-sm-3 control-label">Company Name</label>
                    <div class="col-sm-3">
                        <%=companyname%>
                    </div>
                </div>
                <div class="clearfix">
                    <label for="email" class="col-sm-3 control-label">Email Id</label>
                    <div class="col-sm-3">
                       <%=email%>
                    </div>
                </div>
		<div class="clearfix">
                    <label for="cellno" class="col-sm-3 control-label">Mobile no.</label>
                    <div class="col-sm-3">
                        <%=cellno%>
                    </div>
                </div>
		
               
                <div class="clearfix">
                    <div class="col-sm-3 col-sm-offset-3">
                        <a href="employerprofileEdit.jsp"> <button type="button" class="btn btn-primary btn-block">Edit</button></a>
                    </div>
                </div>
                      
                
		
            
        
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
                        <input type="hidden" id="isemployer"  name="isemployer" class="form-control " value="true" >  
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
