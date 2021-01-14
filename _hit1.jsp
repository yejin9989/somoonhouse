<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "_hit1.jsp"); %>
<% session.setAttribute("prepage", request.getHeader("referer")); %>
<%
int num = Integer.parseInt(request.getParameter("num"));
Connection conn = DBUtil.getMySQLConnection();
ResultSet rs = null;
PreparedStatement pstmt = null;
String query = "";

query = "update REMODELING set Hit = Hit + 1 where Number = ?";
pstmt = conn.prepareStatement(query);
pstmt.setInt(1, num);
pstmt.executeUpdate();

query = "select * from REMODELING where Number = ?";
pstmt = conn.prepareStatement(query);
pstmt.setInt(1, num);
rs = pstmt.executeQuery();
String URL = "";

while(rs.next()){
	URL = rs.getString("URL");
}
String url = URL.replace("blog.naver.com", "m.blog.naver.com");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title></title>
<style>
html{
	height:100%;
}
body{
	margin: 0;
    height: 100%;
}
.container{
	background: white;
    width: 100%;
	max-width:600px;
    position: relative;
    height: 100%;
    left: 0;
    bottom: 0;
    margin: auto auto;
    box-shadow: 1px -1px 13px 0px #0000002e;
    overflow: scroll;
}
#navbar{
	height:49px;
	width: 100%;
	max-width:600px;
    position: fixed;
    top: 0;
    z-index: 12;
    background:white;
    border-bottom: 1px solid #f7f7f7;
}
#logo{
    font-size: 33pt;
    position: absolute;
    top: -1%;
    color: #626262;
    background-image: url(img/somunlogo.png);
    margin: auto auto;
    position: relative;
    top: 50%;
    transform: translate(0, -50%);
    background-size: 69px 26px;
    height: 26px;
    width: 69px;
}
#x_btn{
    font-size: 33pt;
    position: absolute;
    top: -1%;
    right: 0;
    color: #626262;
    background-image: url(img/XX.png);
    background-size: 41px 43px;
    height: 41px;
    width: 43px;
    top: 50%;
    transform: translate(0, -50%);
    cursor: pointer;
}
#frame_frame{
    position: fixed;
    height: 93%;
    width: 100%;
    max-width: 600px;
    left: 0;
    top: 50px;
    z-index:10;
}
iframe{
    width: 100%;
    height: 100%;
    position: absolute;
    border: 0;
}
.pink{
    position: relative;
    height: 10000px;
    width: 100%;
    background: none; linear-gradient(45deg, #ff00568f, #00ffd094);
    z-index:10;
}
#buttonbar{
	width:100%;
	max-width:600px;
	height: 57px;
	background:white;
	z-index: 12;
	position: fixed;
	bottom: 0;
	border-top: 1px solid #f7f7f7;
}
#rem_req_btn{
    width: 145px;
    height: 56px;
    position: absolute;
    right: 5%;
    background-image: url(img/reqbtn2.png);
    background-size: 145px 56px;
    cursor: pointer;
}
@media(min-width:450px){
	#rem_req_btn{
    	width: 184px;
    	height: 74px;
    	background-size: 184px 74px;
	}
	#buttonbar{
		height: 74px;
	}
}
</style>
</head>
<body>
    <div class="container">
    	<div id="navbar">
    		<div id="logo"></div>
			<div id="x_btn"></div>
		</div>
		<div id="frame_frame">
    		<iframe name="myframe" src="<%=url%>" scrolling="yes" frameborder="0">
    		</iframe>
		</div>
		<div class="pink"></div>
		<div id="buttonbar">
			<div id="rem_req_btn"></div>
		</div>
	</div>
</body>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
$('#rem_req_btn').click(function(){
	location.href="remodeling_form.jsp?item_num="+"<%=num%>";
});

$('#x_btn').click(function(){
	var hreflink = "<%=session.getAttribute("prepage")%>" + "";
	location.href= hreflink;
	//history.back(-1);
})

var mouseon = 0;
var filter = "win16|win32|win64|mac|macintel";
function checkMobile(){
	 
    var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
 
    if ( varUA.indexOf('android') > -1) {
        //안드로이드
        return "android";
    } else if ( varUA.indexOf("iphone") > -1||varUA.indexOf("ipad") > -1||varUA.indexOf("ipod") > -1 ) {
        //IOS
        return "ios";
    } else {
        //아이폰, 안드로이드 외
        return "other";
    }
    
}

function removepink(){
	/*$('.pink').remove();*/
	var pink = $('.pink');
	pink.css('z-index', '9');
}
function appendpink(){
	/*var pink = "<div class=\"pink\"></div>"
	$('.container').append(pink);*/
	var pink = $('.pink');
	pink.css('z-index', '11');
}

$('iframe').on('mouseover', function(){
	if(filter.indexOf( navigator.platform.toLowerCase() ) < 0){
		appendpink();
	}
})
$('body').on('mouseover', function(){
	if(filter.indexOf( navigator.platform.toLowerCase() ) < 0){
		appendpink();
	}
})
$('.container').on('scroll', function(){
	if(filter.indexOf( navigator.platform.toLowerCase() ) < 0){
		removepink();
		setTimeout(function() {
			appendpink();
		}, 2000);
	}
})

function frame(){
	var framediv = $('#frame_frame');
	var windowWidth = $( window ).width();
	var divWidth = framediv.width();
	
	framediv.css('left', (windowWidth-divWidth)/2);
}

$(document).ready(function(){
	$('.container').scrollTop(100);
	mouseon = 0;
	frame();
	if(filter.indexOf( navigator.platform.toLowerCase() ) >= 0){
		removepink();
	}
})

$(window).resize(function(){
	frame();
});

</script>
</html>
