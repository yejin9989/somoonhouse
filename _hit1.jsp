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
}
#navbar{
	height:49px;
	width: 100%;
	max-width:600px;
    position: fixed;
    top: 0;
    z-index: 10;
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
    position: absolute;
    height: 93%;
    width: 100%;
    bottom: 0;
}
iframe{
    width: 100%;
    height: 100%;
    position: absolute;
    border: 0;
}
.pink{
    position: absolute;
    height: 10000px;
    width: 100%;
    background: pink;
    bottom: 0;
    z-index:11;
    overflow-y:scroll;
}
#buttonbar{
	width:100%;
	max-width:600px;
	height: 57px;
	background:white;
	z-index: 10;
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

function removepink(){
	$('.pink').remove();
}
function appendpink(){
	var pink = "<div class=\"pink\"></div>"
	$('#frame_frame').append(pink);
}

$('#buttonbar').on('mouseover', function(){
	if(filter.indexOf( navigator.platform.toLowerCase() ) < 0){
		removepink();
	}
})
$('#navbar').on('mouseover', function(){
	if(filter.indexOf( navigator.platform.toLowerCase() ) < 0){
		removepink();
	}
})
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
$('#frame_frame').on('click', function(){
	if(filter.indexOf( navigator.platform.toLowerCase() ) < 0){
		alert('im pink');
	}
})
$('.pink').on('scroll', function(){
		alert('im scrolling');
})


</script>
</html>
