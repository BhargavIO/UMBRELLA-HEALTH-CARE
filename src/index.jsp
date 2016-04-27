

<%@page
	import="org.oscarehr.common.service.AcceptableUseAgreementManager"%>
<%@page
	import="oscar.OscarProperties, javax.servlet.http.Cookie, oscar.oscarSecurity.CookieSecurity, oscar.login.UAgentInfo"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/caisi-tag.tld" prefix="caisi"%>
<caisi:isModuleLoad moduleName="ticklerplus">
	<%
    if(session.getValue("user") != null) {
        response.sendRedirect("provider/providercontrol.jsp");
    }
%>
</caisi:isModuleLoad>
<%
OscarProperties props = OscarProperties.getInstance();

// clear old cookies
Cookie rcpCookie = new Cookie(CookieSecurity.receptionistCookie, "");
Cookie prvCookie = new Cookie(CookieSecurity.providerCookie, "");
Cookie admCookie = new Cookie(CookieSecurity.adminCookie, "");
rcpCookie.setPath("/");
prvCookie.setPath("/");
admCookie.setPath("/");
response.addCookie(rcpCookie);
response.addCookie(prvCookie);
response.addCookie(admCookie);

// Initialize browser info variables
String userAgent = request.getHeader("User-Agent");
String httpAccept = request.getHeader("Accept");
UAgentInfo detector = new UAgentInfo(userAgent, httpAccept);

// This parameter exists only if the user clicks the "Full Site" link on a mobile device
if (request.getParameter("full") != null) {
    session.setAttribute("fullSite","true");
}

// If a user is accessing through a smartphone (currently only supports mobile browsers with webkit),
// and if they haven't already clicked to see the full site, then we set a property which is
// used to bring up iPhone-optimized stylesheets, and add or remove functionality in certain pages.
if (detector.detectSmartphone() && detector.detectWebkit()  && session.getAttribute("fullSite") == null) {
    session.setAttribute("mobileOptimized", "true");
} else {
    session.removeAttribute("mobileOptimized");
}
Boolean isMobileOptimized = session.getAttribute("mobileOptimized") != null;
%>
<html:html locale="true">
<head>
<link rel="shortcut icon" href="images/Oscar.ico" />

<script type="text/javascript"
	src="<%= request.getContextPath() %>/js/global.js"></script>
	<script src="js/umbrella.js" type="text/javascript"></script>

    <script type="text/javascript" src="js/jssor.slider.mini.js"></script>

<script src="js/jquery-2.2.0.min.js" type="text/javascript"></script>
<html:base />

<title>
	<% if (props.getProperty("logintitle", "").equals("")) { %> <bean:message
		key="loginApplication.title" /> <% } else { %> <%= props.getProperty("logintitle", "")%>
	<% } %>
</title>


	
    <script>
    
    $(document).ready(function(){
		$("#login-box").hide();
	});
    
        jQuery(document).ready(function ($) {
            
            var jssor_1_SlideoTransitions = [
              [{b:5500,d:3000,o:-1,r:240,e:{r:2}}],
              [{b:-1,d:1,o:-1,c:{x:51.0,t:-51.0}},{b:0,d:1000,o:1,c:{x:-51.0,t:51.0},e:{o:7,c:{x:7,t:7}}}],
              [{b:-1,d:1,o:-1,sX:9,sY:9},{b:1000,d:1000,o:1,sX:-9,sY:-9,e:{sX:2,sY:2}}],
              [{b:-1,d:1,o:-1,r:-180,sX:9,sY:9},{b:2000,d:1000,o:1,r:180,sX:-9,sY:-9,e:{r:2,sX:2,sY:2}}],
              [{b:-1,d:1,o:-1},{b:3000,d:2000,y:180,o:1,e:{y:16}}],
              [{b:-1,d:1,o:-1,r:-150},{b:7500,d:1600,o:1,r:150,e:{r:3}}],
              [{b:10000,d:2000,x:-379,e:{x:7}}],
              [{b:10000,d:2000,x:-379,e:{x:7}}],
              [{b:-1,d:1,o:-1,r:288,sX:9,sY:9},{b:9100,d:900,x:-1400,y:-660,o:1,r:-288,sX:-9,sY:-9,e:{r:6}},{b:10000,d:1600,x:-200,o:-1,e:{x:16}}]
            ];
            
            var jssor_1_options = {
              $AutoPlay: false,
              $SlideDuration: 2000,
              $SlideEasing: $Jease$.$OutQuint,
              $CaptionSliderOptions: {
                $Class: $JssorCaptionSlideo$,
                $Transitions: jssor_1_SlideoTransitions
              },
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };
            
            var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);
            
            //responsive code begin
            //you can remove responsive code if you don't want the slider scales while window resizing
            function ScaleSlider() {
                var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
                if (refSize) {
                    refSize = Math.min(refSize, 1920);
                    jssor_1_slider.$ScaleWidth(refSize);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }
            ScaleSlider();
            $(window).bind("load", ScaleSlider);
            $(window).bind("resize", ScaleSlider);
            $(window).bind("orientationchange", ScaleSlider);
            //responsive code end
        });
    </script>
     
<style>

        .jssorb05 {
            position: absolute;
        }
        .jssorb05 div, .jssorb05 div:hover, .jssorb05 .av {
            position: absolute;
            /* size of bullet elment */
            width: 16px;
            height: 16px;
            background: url('img/b05.png') no-repeat;
            overflow: hidden;
            cursor: pointer;
        }
        .jssorb05 div { background-position: -7px -7px; }
        .jssorb05 div:hover, .jssorb05 .av:hover { background-position: -37px -7px; }
        .jssorb05 .av { background-position: -67px -7px; }
        .jssorb05 .dn, .jssorb05 .dn:hover { background-position: -97px -7px; }
		.jssora22l, .jssora22r {
            display: block;
            position: absolute;
            /* size of arrow element */
            width: 40px;
            height: 58px;
            cursor: pointer;
            background: url('img/a22.png') center center no-repeat;
            background-color: rgba(0,0,0,.5);
            overflow: hidden;
            border-radius: 5px;
        }
        .jssora22l { background-position: -10px -31px; }
        .jssora22r { background-position: -70px -31px; }
        .jssora22l:hover { background-position: -130px -31px; }
        .jssora22r:hover { background-position: -190px -31px; }
        .jssora22l.jssora22ldn { background-position: -250px -31px; }
        .jssora22r.jssora22rdn { background-position: -310px -31px; }
body{

	width:1350px;
	font: 14px/20px verdena;
	color: #555;
	margin: 0;
	margin-left: auto;
	margin-right: auto;
}
header{
	margin-left: auto;
	margin-right: auto;
	top:0;
	right: auto;
	width:1350px;
	height: 80px;
	background:#333333;
	position: fixed;	
	overflow: hidden;
	z-index:10000;
}
#title
{
float: left; font-size:40px;margin:20px;color: rgb(165,165,165);
}
#top{
	margin:10px;
	float: right;
	width: 50%;
	margin-left: 200px;
}


#top>ul{
	list-style-type: none;
	float: left;
	
		margin-left: 100px;
		margin-top: 10px;
}
#top>ul>li{
	display:inline;
	text-align: center;
	width:200px;
}
#top a{
	text-align: center;
	border-radius:3px;
	padding: 10px;
	background: white;
	text-decoration: none;
		
		margin-right: 10px;
	font-weight: bold;
	color: rgba(6,6,6,.68);
	transition: all .2s ease-in-out;
}

#top a:hover{
	padding: 10px 10px 14px 10px ;
	background:rgba(80,69,69,0.7);
	color: white;
	box-shadow: 0px 0px 2px 1px white;

}

.login{
	float: right;
margin-right: 50px;
}

/*-----------LOGIN BOX=--------*/
#login-box{

	background:rgba(51,51,51,0.68);
	z-index:100;
	height: 180px;
	width: 400px;
	right:0;
		border-top:1px solid white;
	border-radius:0 0 10px 10px;
	position: fixed;
}

#login-box table{
	margin: 20px auto 0 50px;
	color: white;
}

#login-box input{
	padding: 5px;
	border-radius: 5px;
	width: 160px;
}

#login-box .submit{

	width: 100px;
	cursor: pointer;
	background: rgba(0,189,244,0.7);
	
	margin:20px;
	font-weight: bold;
	border: 1px solid rgba(0,189,244,0.7);
	border-radius: 0px;
}
/*-----slider*/
#slider{

}
#slider img{
	margin-left: auto;
	margin-right: auto;
	z-index:10;
}
#gap{
	height:80px;

}

#a{
	width: 1350px;
	height: 400px;
	margin-top: 0px;
    background-image: url(blue1.jpg);
    background-attachment: fixed;
    opacity: .8;
    position: absolute;
    z-index: 1;
    background-size: cover;
    box-shadow: 0px 5px 30px 1px black;
}

section{
	margin-top:100px;
	height: 200px;
	width:30%;
	margin-left:2%;
	margin-right:1%;
	float: left;
	color: #E2E2E2;
	text-align: center;
	border-radius: 5px;
	text-align:center;
	z-index: 1000;
	box-shadow: 0px 15px 30px 2px black;
	opacity: 1;
	position:relative;
	cursor: pointer;
	background: rgba(0,0,0,.7);

	transition: all .2s ease-in-out;

}

section:hover{
	background: rgba(0,0,0,.9);	
	color: white;
}
section h1{
	text-shadow: 1px 1px 10px black;
	font-weight: bolder;
	font-family: verdena;
	color: #555;
}

section>.container{
	margin:50px;
}
section>.container p{
	font-size:16px;
}
#section2{
	width: 1350px;
	background: #264563;
	height: 500px;
	margin-top: 400px;
	font-family: Arial;
	font-weight: normal;
}
#section2 .container{
	position: absolute;
	margin: 100px;
	color: #9E9E9E;
	
}
#section2 h1{
	font-size: 45px;
}
#section2 h2{
	font-size: 30px;
}
#section2 p{
	font-size: 20px;
	position: relative;
	margin-left: auto;
	margin-right: auto;
	width: 70%;
}
#section2 #back{
	background: rgba(0,0,0,.6);
	position: absolute;
	height: 500px;
	width:1350px;
}

#footer{
	width: 1350px;
	height: 80px;
	background:rgba(0,0,0,.8);
	position: absolute;
	color: white;
	text-align: center;
}

</style>

<script language="JavaScript">
        function showHideItem(id){
            if(document.getElementById(id).style.display == 'none')
                document.getElementById(id).style.display = 'block';
            else
                document.getElementById(id).style.display = 'none';
        }
        

        </script>

</head>

<body onLoad="setfocus()" bgcolor="#ffffff">
<header >
		<div id="title" style="">
			UMBRELLA <span style="font-size:30px;">Health Care</span>
		</div>
		<div id="top" >
			<ul >
				<li><a href="#">Home</a></li>
				<li><a href="#">Features</a></li>
				<li><a href="#">Contact Us</a></li>
			</ul>

		<a href="#" class="login ">Login</a>

		</div>

	</header>
	<div>
		<div id="gap"></div>


		<div id="login-box" >
			<table class="leftinput" border="0" width="100%">
		<tr>
			<td id="loginText" >
				<!--- left side --> <html:form action="login">
					<bean:message key="loginApplication.formUserName" />
					<%
                            if(oscar.oscarSecurity.CRHelper.isCRFrameworkEnabled() && !net.sf.cookierevolver.CRFactory.getManager().isMachineIdentified(request)){
                            %><img
						src="gatekeeper/appid/?act=image&/empty<%=System.currentTimeMillis() %>.gif"
						width='1' height='1'>
					<%
                            }
                            %>
	</td>
		<td>			
					<input type="text" name="username" value="" size="15"
						maxlength="15" autocomplete="off" /></td></tr>
					<tr><td>
					<bean:message key="loginApplication.formPwd" /></td><td>
					
					<input type="password" name="password" value="" size="15"
						maxlength="32" autocomplete="off" /></td></tr>
					<tr><td>
					
					
					<bean:message key="index.formPIN" />: 
                    </td><td>
					<input type="password" name="pin" value="" size="15" maxlength="15"
						autocomplete="off" /></td></tr>
					<tr><td colspan="2">
					<input type="submit" value="<bean:message key="index.btnSignIn"/>" class="submit"/></td></tr>
					
					<input type=hidden name='propname'
						value='<bean:message key="loginApplication.propertyFile"/>' />
				</html:form> <%if (AcceptableUseAgreementManager.hasAUA()){ %> <span
				class="extrasmall"> <bean:message key="global.aua" /> &nbsp;
					<a href="javascript:void(0);" onclick="showHideItem('auaText');"><bean:message
							key="global.showhide" /></a>
			</span> <%} %> <!-- left side end-->
			

		</tr>
	</table>

		</div>
 <div id="jssor_1" style="position: relative; margin: 0 auto; top: 0px; left: 0px; width: 1300px; height: 500px; overflow: hidden; visibility: hidden;">
        <!-- Loading Screen -->
        <div data-u="loading" style="position: absolute; top: 0px; left: 0px;">
            <div style="filter: alpha(opacity=70); opacity: 0.7; position: absolute; display: block; top: 0px; left: 0px; width: 100%; height: 100%;"></div>
            <div style="position:absolute;display:block;background:url(images/slider1.jpg') no-repeat center center;top:0px;left:0px;width:100%;height:100%;"></div>
        </div>
        <div data-u="slides" style="cursor: default; position: relative; top: 0px; left: 0px; width: 1300px; height: 500px; overflow: hidden;">
   	<div data-p="225.00" style="display: none;">
                <img data-u="image" src="images/bg_h3.jpg" />
             <div style="position: absolute; top: 30px; left: 30px; width: 480px; height: 120px; font-size: 50px; color: rgba(256,256,256,.7); line-height: 60px;">UMBRELLA <br> <span style="color:rgba(0,105,147,1);">Health Care</span></div>
                <div style="position: absolute; top: 300px; left: 30px; width: 480px; height: 120px; font-size: 30px; color: black; line-height: 38px;"></div>
            </div>
            <div data-p="225.00" style="display: none;">
                <img data-u="image" src="images/3under-umbrella.jpg" />
            </div>
            <div data-p="225.00" style="display: none;">
                <img data-u="image" src="images/2insurance-umbrella.jpg" />
            </div>
        </div>
        <!-- Bullet Navigator -->
        <div data-u="navigator" class="jssorb05" style="bottom:16px;right:16px;" data-autocenter="1">
            <!-- bullet navigator item prototype -->
            <div data-u="prototype" style="width:16px;height:16px;"></div>
        </div>
        <!-- Arrow Navigator -->
        <span data-u="arrowleft" class="jssora22l" style="top:0px;left:12px;width:40px;height:58px;" data-autocenter="2"></span>
        <span data-u="arrowright" class="jssora22r" style="top:0px;right:12px;width:40px;height:58px;" data-autocenter="2"></span>
      
    </div>

	</div>

<div id="a">

<section>
	<div class="container">
		<h1>PORTAL</h1>
		<p>Tasks that you do 8,000x a day are made as simple as possible. Staff actually cheer at how uncomplicated their scheduling is now.</p> 
	</div>
	</section>
	<section>
	<div class="container">
		<h1>BILLING</h1>
		<p>Bill your visits and accept payments in just a couple of clicks, and have Jane do all the math for you – even if you're billing insurers.</p>
	</div>
	</section>
	<section>
	<div class="container">
		<h1>SCHEDULE</h1>
		<p>Tasks that you do 8,000x a day are made as simple as possible. Staff actually cheer at how uncomplicated their scheduling is now.</p>
	</div>
	</section>
</div>
<div id="section2">
<div id="back"></div>
	<div class="container">
	<h1>Our Mission:<h1><br>

<h2>...to help physicians work better.<h2>



<p>"Our objective is to help physicians work better by providing advanced innovative EMR solutions. We aim to build long-term relationships with each one of our clients. Our reputation of service excellence is built upon years of providing quality service and customer support<p>
	</div>
</div>
<div id="footer">
	<p>&copy; Copy right &nbsp;&nbsp; <a href="#" style="color: white;"> Terms and Conditions</a></p>
</div>
	

</body>
</html:html>
