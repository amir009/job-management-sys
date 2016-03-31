<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            String ErrorMessage="";
    String error	  = request.getParameter("error");
    if(error!=null && !error.equals("")){
    ErrorMessage="Invalid Credentials";
    
    }
            %>
        <style>
            

*[role="form"] {
    max-width: 600px;
    min-width: 600px;
    padding: 15px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 0.3em;
}

*[role="form"] h2 {
   text-align: center;
    margin-bottom: 1em;
}
#getQue .form-group{
    
    margin-left: 0px !important;
    margin-right: 0px !important;
}

            
        </style>
  
    <body>
     
        <%@ include file="header.jsp" %>
       <script  type="text/javascript" >
           $(document).ready(function () {
                $("#submitlogform").on("click",function(){
           var validForm=$("#logform").validationEngine('validate');
			if(validForm){
				$("#logform").submit();
			} 
        });
               
               var employer=false;
               $("#fwdPasswordDiv").dialog({
			autoOpen : false,
			modal : true,
			resizable : false,
			draggable : false,
			width:600,
                        height:400
		});
               $("#epmlogswitch").on('click',function(){
                   if(employer){
                       $("#epmlogswitch").html("Login as Employer");
                       $("#loginTit").html("Employee Login");
                       $("#empreg").attr("href","registration.jsp");
                       $("#isemployer").val("");
                       $("#sideimg").attr("src","images/j3.jpg");
                       
                       employer=false;
                   }else{
                       $("#epmlogswitch").html("Login as Employee");
                       $("#empreg").attr("href","proregistration.jsp");
                       $("#loginTit").html("Employer Login");
                       $("#isemployer").val("true");
                       $("#sideimg").attr("src","images/j5.jpg");
                       employer=true;
                   }
                   
               });
               
               
               
           }); 
            function getSecque(){
                $( "#getQue" ).html( "" );
               var isemp= $("#isemployer").val();
               var uname=  $("#uname").val();
               if(uname!==""){
                $.post( "secretQuestion.jsp?username="+uname+"&isemployer="+isemp, function( data ) {
                    $( "#getQue" ).html( data );
                  });
              }else{
                 alert("please enter username");
              } 
                
                
            }
            function openDialog(){
                $( "#getQue" ).html( "" );
                 $("#uname").val("");
                $("#fwdPasswordDiv").dialog('open');
            }
            function changePassword(){
                var validForm=$("#changePwdfrm").validationEngine('validate');
		if(validForm){
		$.post( "fwdpassword.jsp", $( "#changePwdfrm" ).serialize() ).done(function( data ) {
                   $("#resultdiv").html(data);
                   var dat=$("#successmessage").val();
                    if(dat==="success"){
                        alert( "Password chnaged successfully ");
                       $("#fwdPasswordDiv").dialog('close'); 
                    }else{
                        alert( "Incorect details provided ");
                    }
                     
                    });
			} 
                
            }
        function confirmPwd(field, rules, i, options){
	if (field.val() !== $("#pass").val()) {
         return "Passwords Don't Match";
	}
	}
        </script>
        <div class="" style="padding: 20px">
            <div class="col-md-5 col-lg-5 " align="center">
	<img id="sideimg"  src="images/j3.jpg" width="400" height="400" />
         
            </div>
        
            <div class=" col-md-6 col-lg-6 well">
       
            <form class="form-horizontal" role="form" id="logform" method="post" action="loginCheck.jsp">
                <h2 id="loginTit">Employee Login</h2>
                <div ><span style="color:red;font-weight: bold"><%=ErrorMessage%></span></div>
                <div class="form-group">
                    <label for="username" class="col-sm-3 control-label">User Name</label>
                    <div class="col-sm-7">
                        <input type="text" id="username" placeholder="username" name="username" class="form-control validate[required]" autofocus>
                        <input type="hidden" id="isemployer" name="isemployer" value="" >
                       
                    </div>
                </div>
 
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">Password</label>
                    <div class="col-sm-7">
                        <input type="password" id="password" placeholder="Password" name="password" class="form-control validate[required]">
                    </div>
                </div>
			
		
		
		

                <div class="form-group">
                    <div class="col-sm-3 col-sm-offset-3">
                        <button type="button" class="btn btn-primary btn-block" id="submitlogform">Login</button>
                        <br>
                        <a href="#" onclick="openDialog()" style="font-style: italic;font-size: 16px">Forgot password</a>
                    </div>
                    <div class="col-sm-4 ">
                     <a id="empreg" href="registration.jsp" ><button type="button" class="btn btn-primary btn-block ">Register</button></a>
                     <br>
                     <a id="epmlogswitch" class="pointer" style="font-style: italic;font-size: 16px">Login as Employer</a>
                    </div>
                    
                </div>
            </form> 
        </div> 
        </div> 
        <div id="fwdPasswordDiv" title="Forgot Pasword" >
            
            <div class="form-group">
                    <label for="username" class="col-sm-3 " style="text-align: right;padding: 10px">User Name</label>
                    <div class="col-sm-4">
                        <input type="text" id="uname" placeholder="username" name="username" class="form-control" autofocus>  
                    </div>
                    <div class="col-sm-3">
                        <button type="button" onclick="getSecque()" class="btn btn-primary btn-block">Next</button>
                    </div>
            </div>
            
            <div id="getQue" style="background: white none repeat scroll 0% 0%; margin-top: 50px;" ></div>   
            
            
            <div id="resultdiv" style="display:none" ></div>
        </div>
       
    </body>
</html>
