<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page session="true"%>
<%@ include file="connection.jsp" %>

<%! ResultSet rs=null; %>
<%! boolean iscurrentUser=true; %>
<%! int questioncnt=10; %>
<%! String username,question,opt1,opt2,opt3,opt4,answer_opt,userid="",jobid=""; %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <script type="text/javascript" src="js/canvasjs.min.js"></script>
    <script>
    var ques=[];
    var qcount=0;
    var currentque=-1;
    var selectedAns=[];

    var score=0;
    $(document).ready(function(){
    loadQues();
    $("#nextbtn").on("click",function(){
    var selectedVal = "";
    var selectedanswer = $("#testDiv input[type='radio']:checked");
    if (selectedanswer.length > 0) {
        selectedVal = selectedanswer.val();
         selectedAns[currentque]=selectedVal;
        loadeachQue(selectedAns[++currentque]);
        
    }
    else
    {
    alert("Please Select answer");
    }

    });
    $("#prevbtn").on("click",function(){
    if(currentque!==0){
    loadeachQue(selectedAns[--currentque]);

    }
    });

    $("#StartTst").on("click",function(){
    loadeachQue(selectedAns[++currentque]);

    $("#testInitial").hide();
    $("#prevbtn").hide();
    $("#testDiv").show();
    });
    $("#subtest").on("click",function(){
        
        score=0;
            
                  
           var selectedVal = "";
        var selectedanswer = $("#testDiv input[type='radio']:checked");
        if (selectedanswer.length > 0) {
            selectedVal = selectedanswer.val();
         selectedAns[currentque]=selectedVal;
            for(i=0;i<qcount;i++){
                if(ques[i].ans===selectedAns[i]){
                    score++;
                }
 
            }
            jobid=$("#jobid").val();
            $.post( "testsubmit.jsp","total="+(qcount)+"&result="+score+"&jobid="+jobid, function( data ) {
            $("#testDiv").hide();          
            $("#resultdiv").show();
            drawResultChart();
                  });
        
        }
     else
        {
        alert("Please Select answer");
          }
    });
    });

    function loadeachQue(ans){
    $("#testDiv input[type='radio']").prop("checked",false);
    var curque=ques[currentque];
    $("#questionDiv").html((currentque+1)+". "+curque.question);
    $("#option1").html(curque.option1);
    $("#option2").html(curque.option2);
    $("#option3").html(curque.option3);
    $("#option4").html(curque.option4);

    $("input[type='radio'][value="+ans+"]").prop("checked",true);
    $(".navbtn").show(); 
    $("#subtest").hide(); 
    if(currentque===qcount-1){
          $("#nextbtn").hide();  
          $("#subtest").show();  
            
        }
        if(currentque===0){
           $("#prevbtn").hide(); 
           $("#prevbtn").hide(); 
        }
    
    }


    function loadQues(){
    $(".questions").each(function(index){
    var obj={};
    obj.question=$(this).children(".question").html();
    obj.option1=$(this).children(".option1").html();
    obj.option2=$(this).children(".option2").html();
    obj.option3=$(this).children(".option3").html();
    obj.option4=$(this).children(".option4").html();
    obj.ans=$(this).children(".answerkey").html();
    ques[qcount]=obj;
    qcount++;


    });
    $("#allQues").empty();

    }
    function drawResultChart() {
       
        wrong=qcount-score;
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
    
</script>
    <div id="allQues" style="display:none;">
<%
     String url = request.getRequestURL().toString();
    String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
    
    if(session.getAttribute("username")!=null && session.getAttribute("userId") !=null){
        Integer uid=(Integer)session.getAttribute("userId");
        jobid=request.getParameter("jobid");
        if(session.getAttribute("isEmployer")!=null && (Boolean)session.getAttribute("isEmployer")){
        String site = new String(baseURL+"profilepro.jsp?profileid="+userid);
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
        }
        rs=st.executeQuery("select * from test_results where jobid= "+jobid+" and empid="+uid);
        if(rs.next()){
        String site = new String(baseURL+"jobdetails.jsp?jobid="+jobid);
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);  
        }
        rs=st.executeQuery("select * from test order by rand() limit 0, "+questioncnt);
	while(rs.next()){
           
         question = rs.getString("question");
         opt1	  = rs.getString("opt1");
         opt2	  = rs.getString("opt2");
         opt3	  = rs.getString("opt3");
         opt4	  = rs.getString("opt4");
         answer_opt = rs.getString("answer_opt");
   
        %>
        <div class="questions">
        <div class="question"><%=question%></div>
        <div class="option1"><%=opt1%></div>
        <div class="option2"><%=opt2%></div>
        <div class="option3"><%=opt3%></div>
        <div class="option4"><%=opt4%></div>
        <div class="answerkey"><%=answer_opt%></div>
        </div>
 
        <%
        }
    }
    else{
     String site = new String(baseURL+"login.jsp");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    }
%>
    </div>
        <div class="well" >
        <div class="insideWell" style="min-height: 300px">
        
        <div id="testInitial" style="padding:3% 15%">
            <div class="row" style="padding: 10px;">
             <div class="col-sm-6">
            <h1>Instructions</h1>
            </div>
            </div>
            <div class="row" style="padding: 10px;">
                <div class="col-sm-6">
            <ol>
                <li style="padding: 10px;">Attempt all Questions</li> 
                <li style="padding: 10px;">Total number of questions <%=questioncnt%></li> 
                <li style="padding: 10px;">All multiple choice questions</li> 
                
            </ol>
                </div></div>
            <div class="row" style="padding: 10px;">
                  <div class="col-sm-3 col-sm-offset-3">
        <input type="button" value="Start" class="btn btn-primary btn-block col-sm-3" id="StartTst">
                  </div>
                  </div>
        
        </div>
        <div id="testDiv" style="display:none;padding: 3% 10%;">
        <table class="table-curved"  style="">
        <tr><td  id="questionDiv"></td></tr>
        <tr><td >1) <input type="radio" name="option" value="1" style="margin: 0 10px"><span id="option1"></span> </td></tr>
        <tr><td >2) <input type="radio" name="option" value="2" style="margin: 0 10px"><span id="option2"> </span></td></tr>
        <tr><td >3) <input type="radio" name="option"  value="3" style="margin: 0 10px"><span id="option3"> </span></td></tr>
        <tr><td >4) <input type="radio" name="option" value="4" style="margin: 0 10px"><span id="option4"> </span></td></tr>

        <tr><td style="border-top: 4px solid whitesmoke;"><div class="col-sm-3"><input type="button" value="Back" class="btn btn-primary btn-block navbtn" id="prevbtn"></div>
                <div class="col-sm-3 col-sm-offset-6"><input type="button" value="Next" class="btn btn-primary btn-block navbtn" id="nextbtn">
        <input type="button" value="Submit" class="btn btn-primary btn-block navbtn" id="subtest">
        <input type="hidden" value="<%=jobid%>" id="jobid"></div></td></tr>

        </table>

        </div>
        <div id="resultdiv" style="display:none;width: 100%;text-align: center;">
            <strong style="color :green;width:100%;text-align: center;margin-bottom: 15px;">Test Successfully submitted </strong>
            <div id="ResultPie" style="height: 300px; width: 80%;"></div>
        </div>
        </div>
        </div>
    </body>
</html>
