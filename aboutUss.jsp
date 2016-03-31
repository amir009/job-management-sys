<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page session="true"%>
<!DOCTYPE html>
<% String url = request.getRequestURL().toString();
    String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    
if(session.getAttribute("isEmployer")==null || !(Boolean)session.getAttribute("isEmployer")){
        String site = new String(baseURL+"aboutus.jsp");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        }

%>
<html>
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
        <style>
            
            #abtus p{
                
                color: white;
    font-size: 20px !important;
    font-style: italic;
}
            

            
        </style>
    <body>
        <%@ include file="header2.jsp" %>
        
        
            <div style='min-height: 550px;    background-image: url("./images/b3.jpg");background-repeat: no-repeat;    background-size: cover;padding:15px'>
                <div class="col-lg-12" id="abtus" style= "    background: rgba(105, 92, 76, 0.37);    padding-left: 100px;    padding-right: 100px;">
                <h1 align="center" style="    color: green;    font-size: 48px;    font-weight: bold;">About US</h1>
            <p>We are a group of 6 dynamic individual who would like to revolutionize the world  and help individuals to find the right jobs and the employers the right candidates.
            We come from different facets of modern society , our brains put together will digitize the corporate recruiting world.
            </p><p>Our website  will help the employers to find the right candidates ,post jobs ,and review the resumes.
            For the job seeking individuals ,they can see the list of employers ,participate in taking an aptitude test.
            </p><p>The aptitude test helps the Individuals and the employers to filter the candidates at the time of applying the job itself. 
            </p><p> The employer has to login in the employer login page and the candidates who r looking for the jobs have to login through the employee login page.
            </p>
            
            <div style="float:right" >
                
                <h3 style="    color: blue;    font-size: 30px;">Contact Us</h3>
                <p>Team 09
                <br>Mail us at: mail.jobmanagementsystem@gmail.com
              </p>  </div>
        </div> 
        </div> 
        
    </body>
</html>
