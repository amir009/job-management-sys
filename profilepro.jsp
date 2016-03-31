<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

<%! ResultSet rs=null; %>
<%! boolean iscurrentUser=true,testtaken=false; %>
<%! int totalscr=0,escore=0,jobid=0; %>
<%! String username,password,secret_ques,secret_ans,first_name,last_name,dob,gender,email,cellno,hobbies,userid=""; %>
<%
     String url = request.getRequestURL().toString();
    String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    
    if(session.getAttribute("username")!=null && session.getAttribute("userId") !=null){
        int uid=0;
        userid=request.getParameter("profileid");
        if(userid!=null && !userid.equals("")){
            if(uid!=Integer.parseInt(userid)){
            iscurrentUser=false;
         }
        uid=Integer.parseInt(userid);
        }
        jobid=0;
        if(request.getParameter("jobid")!=null && request.getParameter("jobid")!=""){
        jobid=Integer.parseInt(request.getParameter("jobid"));
        }
        if(session.getAttribute("isEmployer")==null || !(Boolean)session.getAttribute("isEmployer")){
        String site = new String(baseURL+"profilepro.jsp?profileid="+userid);
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        }
        rs=st.executeQuery("select * from employee where uid ="+uid);
	if(rs.next()){
         username	  = rs.getString("username");
         password	= rs.getString("password");
         secret_ques = rs.getString("secret_ques");
         secret_ans = rs.getString("secret_ans");
         first_name = rs.getString("first_name");
         last_name = rs.getString("last_name");	
         dob	= rs.getString("dob");
         gender= rs.getString("gender");
         email = rs.getString("email");
         cellno	= rs.getString("cellno");	
         hobbies	= rs.getString("hobbies");
        }
        if(jobid!=0){
        rs=st.executeQuery("select * from test_results where jobid= "+jobid+" and empid="+uid);
        totalscr=0;
        escore=0;
        
        if(rs.next()){
         
         totalscr= rs.getInt("total");
         escore	= rs.getInt("result");
         testtaken = rs.getBoolean("testtaken");
        }
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
        <%@ include file="header2.jsp" %>
               <script type="text/javascript" src="js/canvasjs.min.js"></script>
         <% if(testtaken){ %>
        <script>
        function drawResultChart() {
       var total=<%=totalscr%>;
       var score=<%=escore%>;
        var wrong=total-score;
	var chart = new CanvasJS.Chart("ResultPie",
	{
		theme: "theme2",
		title:{
			text: "Your Score"
		},		
		data: [
		{       
			type: "pie",
			showInLegend: true,
			toolTipContent: "{y} - #percent %",
			//yValueFormatString: "#0.#,,. Million",
			legendText: "{indexLabel}",
			dataPoints: [
				{  y:wrong , indexLabel: "Wrong answers" },
				{  y:score , indexLabel: "Your marks" }
			]
		}
		]
	});
	chart.render();
        $(".canvasjs-chart-credit").hide();
        }
        $(document).ready(function(){
        drawResultChart();
    });
        </script>
        <% } %>
        <div class="wrapper" >
        <h2>Personal Details</h2>
        <div id="profileDetails" class="profileDetails" >
            <div class="col-md-2 col-lg-2 " align="center">
	<img alt="User Pic" src="images/profile-pic.jpg" width="200px" height="200px" class="img-circle">
        <div class="clearfix">
         <%=username %>
         </div>
            </div>
            <div class=" col-md-6 col-lg-6 ">
            
                    <ul class="nav nav-tabs">
                    <li class="active"><a href="#">Personal Details</a></li>
                    <li><a href="otherdetailspro.jsp?profileid=<%=userid%>">Professional Details</a></li>
                    
                    
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
                    <label for="dob" class="col-sm-3 control-label">Date of Birth</label>
                    <div class="col-sm-3">
                        <%=dob%>
                    </div>
                </div>

                <div class="clearfix">
                    <label class="control-label col-sm-3">Gender</label>
                    
                            <div class="col-sm-3">
                                  <%=gender%>   
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
                    <label for="hobbies" class="col-sm-3 control-label">Hobbies</label>
                    <div class="col-sm-3">
                        <%=hobbies%>
                    </div>
                </div>
                
		
            
        
        </div>
                    <div class="col-md-3 col-lg-3 " align="center">
                        <div id="ResultPie" style="height: 300px; width: 80%;"></div>
         
            </div>
                        
                    </div>
        </div>
        
    </body>
</html>
