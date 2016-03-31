<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>
<%! String secretQue="", isemployer="",username=""; %>
<%! boolean iserror=true; %>
 <%       
        String url = request.getRequestURL().toString();
        String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    	
	PreparedStatement ps=null;
	ResultSet rs=null;
    %>
    
    <%
    try
    {
        int uid=0;
        
         username	  = request.getParameter("username");
       
         isemployer	=  request.getParameter("isemployer");
        if(isemployer==null || !isemployer.equals("true")){
             isemployer="";
        ps=conn.prepareStatement("select * from employee where username= ? ");
        ps.setString(1,username);
	
        rs=ps.executeQuery();
	if(rs.next()){
        secretQue=rs.getString("secret_ques");
        iserror=false;
        }

            }
        else{
            
        ps=conn.prepareStatement("select * from employer where username= ? ");
        ps.setString(1,username);
	
        rs=ps.executeQuery();
	if(rs.next()){
        secretQue=rs.getString("secret_ques");
       iserror=false;
        }

            }
    }
    catch(Exception e){
        session.removeAttribute("userId");
        out.print(e);
//   String site = new String(baseURL+"registration.jsp?error=1");
//   response.setStatus(response.SC_MOVED_TEMPORARILY);
//   response.setHeader("Location", site);
    
    }
    %>
    <% if(!iserror){ %>
    <form class="form-horizontal" method="post" id="changePwdfrm" action="fwdpassword.jsp">
    <div class="form-group">
                    
                    <input type="hidden" name="isemployer" value="<%=isemployer%>" >
                    <label for="secret_ans" class="col-sm-3 control-label">Secret Question</label>
                        <input type="hidden" id="uname"  name="username" value="<%=username%>" class="form-control" >  
                         <div class="col-sm-4" style="padding: 10px !important;"><%=secretQue%></div>
                   
    </div>
    <div class="form-group">
                    <label for="secret_ans" class="col-sm-3 control-label">Secret Answer</label>
                    <div class="col-sm-4">
                          
                  <input type="text" id="secret_ans" placeholder="answer" name="secret_ans" class="form-control validate[required]">
                    </div>
    </div>
    <div class="form-group">
                    <label for="username" class="col-sm-3 control-label">Password</label>
                    <div class="col-sm-4">
                        <input type="password" id="pass" placeholder="Password" name="password" class="form-control validate[required]"> 
                    </div>
    </div>
    <div class="form-group">
                    <label for="username" class="col-sm-3 control-label">Confirm Password</label>
                    <div class="col-sm-4">
                          <input type="password" id="confrmpassword" placeholder="Confirm Password" class="form-control validate[required,funcCall[confirmPwd]]">
                    </div>
    </div>
    <div class="form-group">
                    
                    <div class="col-sm-4 col-sm-offset-3">
                        <button type="button" onclick="changePassword()" class="btn btn-primary btn-block">Change Password</button>
                    </div>
     </div>
    </form>
    <% } else { %>
    
    <span style="color :red" >No User Name</span>
    
    
    
    <% } %>