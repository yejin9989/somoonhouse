<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% session.setAttribute("page", "sample_collect.jsp"); %>
<!DOCTYPE html>
<html>
<head>
<link rel="SHORTCUT ICON" href="img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
<style type="text/css">
@font-face{
font-family:"Nanum";
src:url("fonts/NANUMBARUNGOTHIC.TTF");
}
*{
font-family:"Nanum";
}
a{
text-decoration: none;
}
#container{
margin:auto; 
max-width: 400px;
}
#somun_logo{
width: fit-content;
margin: auto;
margin-top: 80px; 
padding: 25px;
}
#somun_logo img{
width:128px;
}
.login_btn{
width: 297px;
height: 48px;
line-height: 48px;
text-align: center;
background-color: #52b2ff;
color: white;
border-radius: 5px;
font-size: 17px;
margin: 16px auto;
}
.input_wrapper{
margin:auto;
width:fit-content;
}
#input_id{
width:275px;
height:28px;
font-size:15px;
padding:10px;
border-radius: 5px 5px 0px 0px;
border: 1px solid #d0d0d0;
border-bottom:0px;
}
#input_pw{
width:275px;
height:28px;
font-size:15px;
padding:10px;
border-radius: 0px 0px 5px 5px;
border: 1px solid #d0d0d0;
}
input :focus{
outline: blue auto 1px;
}
.signin_action{
text-align:center;
font-size:14px;
color: #4d4d4d;
}
.signin_action a{
padding: 3px 5px;
margin: -3px 10px;
}
.divider{
padding: 30px;
color: gray;
}
.divider_line{
width: 25%;
position: relative;
border-bottom: 1px solid gray;
float: left;
height: 9.2px;
}
.divider_text{
float: left;
width: 50%;
text-align: center;
font-size: 14px;
}
.social_login_btn{
width: 297px;
height: 48px;
line-height: 48px;
text-align: center;
background-color: #1bd136;
color: white;
border-radius: 5px;
font-size: 17px;
margin: 16px auto;
}
.social_login_btn span{
font-weight: bolder;
font-size: 28px;
}
.social_login_btn a{
color:white;
}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>
</head>
<%
String clientId = "G8MVoxXfGciyZW5dF4p1";//애플리케이션 클라이언트 아이디값";
String redirectURI = URLEncoder.encode("http://somoonhouse.com/callback.jsp", "UTF-8");
SecureRandom random = new SecureRandom();
String state = new BigInteger(130, random).toString();
String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
apiURL += "&client_id=" + clientId;
apiURL += "&redirect_uri=" + redirectURI;
apiURL += "&state=" + state;
session.setAttribute("state", state);
%>
<body>
<div id="container">
	<div id="somun_logo"><a href="index.jsp"><img src="img/somunlogo.png"></a></div>
	<div class="input_wrapper"><input type="text" placeholder="ID" id="input_id"></div>
	<div class="input_wrapper"><input type="password" placeholder="PW" id="input_pw"></div>
	<div class="login_btn">로그인</div>
	<div class="signin_action"><a>비밀번호 재설정</a><a>회원가입</a></div>
	<div class="divider">
		<div class="divider_line"></div>
		<div class="divider_text">소셜계정으로 로그인</div>
		<div class="divider_line"></div>
	</div>
	<div class="social_login_btn"><a href="<%=apiURL%>"><span>N</span>네이버 아이디로 로그인</a></div>
	<div id="naver_id_login"></div>
<script type="text/javascript"
		src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
		charset="utf-8"></script>
</div>
</body>
</html>