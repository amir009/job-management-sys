<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />
         <link rel="stylesheet" href="css/main.css" type="text/css" />
         <link rel="stylesheet" href="css/navbar.css" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/validationEngine.jquery.css"/>
        <link href="css/bootstrap.css" rel="stylesheet">
        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script type="text/javascript" src="js/jquery.validationEngine.js"></script>
        <script type="text/javascript" src="js/jquery.validationEngine-en.js"></script>
  
<script>
    function gotoabtus(){
window.location.href="aboutus.jsp";
}


function navSelect(menuid,bckclass){

		$(".row li a").removeClass('selected');
		$(menuid).addClass('selected');
		$("#site-nav ul.row").addClass(bckclass);
		$(".btn").addClass(bckclass);
		$(".band").addClass(bckclass);
}
$(document).ready(function(){
           var footerdiv=' <div class="footer"><div>Copyright &copy; 2016 Job Management System - All Rights Reserved.</div><div class="abtUs"><a href="aboutUss.jsp" >About Us</a></div></div>';
            $("body").append(footerdiv);
            
            
        });
</script>

<style>
html {
	overflow: auto;
}

body {
	/* background: #ffffff url(resources/images/IE_body_bkgd.png) repeat-x
		!important;*/
	PADDING-LEFT: 0px !important;
	PADDING-RIGHT: 0px !important;
	FONT-FAMILY: Calibri, Helvetica, sans-serif !important;
	COLOR: #000000 !important;
	margin: 0px !important;
	
}

.header {
	
	width: 100%;
	min-height: 16.43px !important;
	/*margin-top: 8px !important;*/
	/*padding: 12px !important;*/
	border-collapse: none !important;
	/*	border-bottom: 1px solid #e5e5e5 !important;
	border-top-left-radius: 6px !important;
	border-top-right-radius: 6px !important;*/
	border-radius: 0;
}

.topcorner {
	position: absolute;
	right: 20%;
	top: 40px;
}

#bgvid {
	position: fixed;
	top: 50%;
	left: 50%;
	min-width: 100%;
	min-height: 100%;
	width: auto;
	height: auto;
	z-index: -1;
	opacity: 1;
	filter: alpha(opacity = 1);
	-webkit-transform: translateX(-50%) translateY(-50%);
	transform: translateX(-50%) translateY(-50%);
	background-size: cover;
}
</style>

<div id="wait" style="display:none;width:69px;height:89px;position:absolute;top:50%;left:50%;padding:2px;z-index: 1000;"><img  width="64" height="64" /></div>

 
<nav class="navbar navbar-default header">
	
		
		<%-- Display menu only if user is logged in --%>
						
		
					
			
				<div id="site-nav" class="container">
                    <ul class="row">
                        <li id="logo" class="col-xs-2"onclick="gotoabtus()"></li>
                        

		<li id="li-user" class="dropdown  active col-xs-1">
                                      <% if(session.getAttribute("username")!=null && session.getAttribute("userId") !=null) { %>
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <span class="icon icon-user" style="padding-top: 10px;"> </span>
                        <span class="menuLabel"><% out.print(session.getAttribute("username")); %></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="employerprofile.jsp">My Profile</a></li>

                        <li><a href='logout.jsp'><span class="glyphicon glyphicon-log-in"></span>
                                &nbsp;&nbsp;&nbsp;&nbsp; LogOut</a></li>
                    </ul>
                    <% } else {  %>
                    <a class="" data-toggle="" href="login.jsp">
                        <span class="icon icon-user" style="padding-top: 10px;"> </span>
                        <span class="menuLabel">Login</span>
                    </a>
                    <% } %>
                 </li>
						
						
						
			
			<li id="li-offerings" class="col-xs-1">
                            <a href="myPosts.jsp">
                                <div class="stacked">
                                    <span class="icon icon-inventory"></span>
                                    <span>Jobs & Applicants</span>
                                </div>
                            </a>
                        </li>
                   

                        <li id="li-search" class="col-xs-1">
                            <a href="jobpost.jsp">
                                <div class="stacked">
                                    <span class="icon icon-solutions"></span>
                                    <span>Post Job</span>
                                </div>
                            </a>
                        </li>
							
					

                       
                    </ul>
                </div>
 

		
	
</nav>

</html>
