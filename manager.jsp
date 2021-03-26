<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "remodeling_form.jsp"); %>
<%



//DB에 사용 할 객체들 정의
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
Statement stmt = null;
String query = "";
String sql = "";
ResultSet rs = null;

//세션 생성 create session
session.setAttribute("page", "manager_login.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";
%>

<!DOCTYPE html>
<html>
<head>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-PC15JG6KGN');
</script>
<%
if(s_id.equals("")){
	%><script>
		history.back(-1);
	</script><%
}
%>
<link rel="SHORTCUT ICON" href="img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style type="text/css">
@import url(https://fonts.googleapis.com/earlyaccess/nanumgothic.css);
@font-face{
font-family:'Nanum Gothic',sans-serif;
}
html{
height: 100%;
}
body{
width:100%;
height:100%;
margin: 0;
}
*{
font-family:'Nanum Gothic',sans-serif;
font-size: 11pt;
color: #313131;
-webkit-appearance: none;
-webkit-border-radius: 0;
}
input[type="checkbox"] {
    display:none;
}
input[type="checkbox"] + label span {
    display: inline-block;
    width: 24px;
    height: 24px;
    margin: -2px 10px 0 0;
    vertical-align: middle;
    background: url(img/checkbox.svg) left top no-repeat;
    cursor: pointer;
    background-size: cover;
}
input[type="checkbox"]:checked + label span {
    background:url(img/checkbox.svg)  -26px top no-repeat;
     background-size: cover;
}
#container {
    width: 100%;
    height: 100%;
    max-width: 700px;
    margin: 0 auto;
    /*box-shadow: 0px 0px 20px #f4f4f4;*/
}
#somun_navbar {
    /*border-bottom: 1px solid #c8c8c8;*/
    display: none;
    height: fit-content;
    width: 100%;
    padding: 39px 0 11px;
}
#content{
	max-width: 700px;
	width: 100%;
	min-width: 300px;
    height: 100%;
    margin: 0 auto;
    box-shadow: 0px 0px 9px 5px #0000001c;
    border-radius: 7px;
    background: linear-gradient(45deg, #cc00ffcc, #5118ff);

}
#content-div{
	width: 100%;
    display: inline-block;
    border-radius: 5px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    position: relative;
}
.mybox{
    width: 77%;
    border: 2px solid white;
    margin: 23px auto;
    padding: 13px 12px;
    text-align: center;
    border-radius: 1px;
	color: white;
	font-size:12pt;
	font-weight: bold;
	transition-duration: 200ms;
}
.mybox:hover{
	background: white;
	color:#7920ff;
	cursor: pointer;
}
#admin{
    width: 77%;
    margin: 23px auto;
    padding: 13px 12px;
    text-align: center;
    border-radius: 1px;
	border:none;
	color: white;
	font-size:12pt;
	font-weight: bold;
}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>
</head>
<body>
<div id="content">
		<!------------ 내용물  --------------->
    <div id="content-div">
			<form action="_manager_login.jsp" method="POST">
			<!-- 로그인 구역 -->
				<div id="admin">👨‍🔧소문난집 관리자 페이지👩‍🔧</div>
				<div class="mybox" id="check">신청 건 확인</div>
				<!-- <div class="mybox" id="upload">사례 등록</div> -->
				<div class="mybox" id="searchurl">아파트 사례정보 검색</div>
				<!-- <div class="mybox" id="blog">소문난 블로그</div> -->
				<div class="mybox" id="home">소문난집 홈으로</div>
				<div class="mybox" id="license">사업자등록증</div>
				<div class="mybox" id="certificate">자격증 확인</div>
			</form>
	</div>
		<!------------ 내용물  --------------->
</div>
<%
//DB개체 정리
/*
pstmt.close();
rs.close();
query="";
conn.close();
*/
%>
<script>
	$('.mybox').click(function(){
		if($(this).attr('id') == "check")
			location.href='remodeling_request.jsp';
		else if($(this).attr('id') == "upload")
			location.href='item_upload.jsp';
		else if($(this).attr('id') == "home")
			location.href='index.jsp';
		else if($(this).attr('id') == "blog")
			location.href='https://blog.naver.com/somoonhouse';
		else if($(this).attr('id') == "searchurl")
			location.href='manager_search.jsp';
		else if($(this).attr('id') == "license")
			location.href='license_check.jsp';
		else if($(this).attr('id') == "certificate")
			location.href='certificate_check.jsp';
	})
</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "3602e31fd32c7e";
wcs_do();
</script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</body>
</html>