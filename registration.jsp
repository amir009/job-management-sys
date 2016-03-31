<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
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


            
        </style>
    <body>
        <%@ include file="header.jsp" %>
        <script>
            $(document).ready(function(){
              
        $("#submitform").on("click",function(){
           var validForm=$("#regform").validationEngine('validate');
			if(validForm){
				$("#regform").submit();
			} 
        });
             
                
                
            });
            
      function confirmPwd(field, rules, i, options){
	if (field.val() !== $("#password").val()) {
     return "Passwords Don't Match";
	}
	}
   
            
            
            
        </script>
        <div class="container">
            <form class="form-horizontal" role="form" id="regform" method="post" action="RegisterSubmit.jsp">
                <h2>Employee Register</h2>
                <div class="form-group">
                    <label for="username" class="col-sm-3 control-label">User Name</label>
                    <div class="col-sm-9">
                        <input type="text" id="username" placeholder="username" name="username" class="form-control validate[required]" autofocus
                               data-errormessage="Username is required." >
                        <span class="help-block">Login user name : alphaNumeric with _</span>
                    </div>
                </div>
 
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">Password</label>
                    <div class="col-sm-9">
                        <input type="password" id="password" placeholder="Password" name="password" class="form-control validate[required]">
                    </div>
                </div>
				<div class="form-group">
                    <label for="confrmpassword" class="col-sm-3 control-label">Confirm Password</label>
                    <div class="col-sm-9">
                        <input type="password" id="confrmpassword" placeholder="Confirm Password" class="form-control validate[required,funcCall[confirmPwd]]">
                    </div>
                </div>
				<div class="form-group">
                    <label for="secret_ques" class="col-sm-3 control-label">Secret question</label>
                    <div class="col-sm-9">
                        <select id="secret_ques" name="secret_ques" class="form-control validate[required]">
                            <option>What was the name of your elementary / primary school?</option>
                            <option>In what city or town does your nearest sibling live?</option>
                            <option>What time of the day were you born? (hh:mm)</option>
                            <option>In what year was your father born?</option>
                            <option>What is the name of the place your wedding reception was held?</option>
                            <option>What was your childhood nickname?</option>
                            <option>What is your favorite team?</option>
                            <option>What is your favorite movie?</option>
                        </select>
                    </div>
                </div>
				<div class="form-group">
                    <label for="secret_ans" class="col-sm-3 control-label ">Secret Answer</label>
                    <div class="col-sm-9">
                        <input type="text" id="secret_ans" placeholder="secret_ans" name="secret_ans" class="form-control validate[required]">
                    </div>
                </div>
				<div class="form-group">
                    <label for="first_name" class="col-sm-3 control-label">First Name</label>
                    <div class="col-sm-9">
                        <input type="text" id="first_name" placeholder="first_name" name="first_name" class="form-control validate[required]">
                    </div>
                </div>
				<div class="form-group">
                    <label for="last_name" class="col-sm-3 control-label">Last Name</label>
                    <div class="col-sm-9">
                        <input type="text" id="last_name" placeholder="last_name" name="last_name" class="form-control validate[required]">
                    </div>
                </div>
                <div class="form-group">
                    <label for="dob" class="col-sm-3 control-label">Date of Birth</label>
                    <div class="col-sm-9">
                        <input type="date" id="dob" name="dob" class="form-control validate[required,custom[date1]]">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-3">Gender</label>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="radio-inline">
                                    <input type="radio" id="femaleRadio" class="validate[required]" name="gender" value="Female">Female
                                </label>
                            </div>
                            <div class="col-sm-4">
                                <label class="radio-inline">
                                    <input type="radio" id="maleRadio" class="validate[required]" name="gender" checked="checked" value="Male">Male
                                </label>
                            </div>
                            
                        </div>
                    </div>
                </div> 

                <div class="form-group">
                    <label for="email" class="col-sm-3 control-label">Email Id</label>
                    <div class="col-sm-9">
                        <input type="email" id="email" name="email" placeholder="Email" class="form-control validate[required,custom[email]]">
                    </div>
                </div>
				 <div class="form-group">
                    <label for="cellno" class="col-sm-3 control-label">Mobile no.</label>
                    <div class="col-sm-9">
                        <input type="text" id="cellno" name="cellno" placeholder="Mobile Number" class="form-control validate[required,custom[phone]]">
                    </div>
                </div>
				 <div class="form-group">
                    <label for="hobbies" class="col-sm-3 control-label">Hobbies</label>
                    <div class="col-sm-9">
                        <input type="text" id="hobbies" name="hobbies" placeholder="Hobbies" class="form-control validate[required]">
                    </div>
                </div>
        
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <button type="button" id="submitform" class="btn btn-primary btn-block">Register</button>
                    </div>
                </div>
            </form> 
        </div> 
    </body>
</html>
