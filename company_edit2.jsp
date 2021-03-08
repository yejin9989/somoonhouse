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
session.setAttribute("page", "company_home.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

String company_id = request.getParameter("company");
company_id = s_id;


String company_img = "";
String company_name = "";
String company_area = "";
String company_as_warranty = "";
String company_as_fee = "";
String company_career = "";
String company_as_provide = "";
//ArrayList<String> company_abilities = new ArrayList<String>();
HashMap<String, String> company_abilities = new HashMap<String, String>();
String company_introduction = "";

query = "select * from COMPANY where Id = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();

while(rs.next()){
	company_img = rs.getString("Profile_img");
	company_name = rs.getString("Name");
	company_area = rs.getString("Address");
	company_as_warranty = rs.getString("As_warranty");
	company_as_fee = rs.getString("As_fee");
	company_career = rs.getString("Career");
	company_introduction = rs.getString("Introduction");
	company_as_provide = rs.getString("As_provide");
}
company_introduction = company_introduction.replace("<br>", "\n");

String checked = "";
if(company_as_provide.equals("0")){
	checked = "checked";
}

int i =0;
query = "select A.Title, A.Id from SPECIALIZED S, COMPANY_ABILITIES A where S.Company_num = ? and S.Ability_num = A.Id";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();
while(rs.next()){
	company_abilities.put(rs.getString("A.Id"), rs.getString("A.Title"));
}
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
<link rel="stylesheet" type="text/css" href="css/company_home.css">
<style type="text/css">

</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>
</head>
<body>
	<div id="container">
		<form action="_company_edit.jsp" method="post">
		<div id="profile_img"></div>
		<div id="company_name"><%=company_name%></div>
		<input type="checkbox" name="as_provide" class="mycheck" id="as_provide" value="1" <%=checked%>><label id="as_label" for="as_provide">A/S 제공</label>
		<div id="btnarea">
			<div class="submitbtn" id="business_license">사업자등록증 제출하기</div>
			<div class="submitbtn" id="etc_license">기타 자격증 제출</div>
		</div>
		<div id="company_address"><input type="text" name="company_area" value="<%=company_area%>"></div>
		<div id="as_warranty">
			A/S 기간 
			<input type="text" name="company_as_warranty" value="<%=company_as_warranty%>">
		</div>
		<div id="as_fee">A/S 금액  <input type="text" name="company_as_fee" value="<%=company_as_fee%>"></div>
		<div id="company_career">경력 기간 <input type="text" name="company_career" value="<%=company_career%>"></div>
		<div id="company_abilities">
			<%
			for(String key: company_abilities.keySet()){
				%>
				<div>
				<%out.print(company_abilities.get(key));%>
				<span class="delete_ability" id="<%=key%>">X</span>
				</div>
				<%
			}
			%>
			<div id="add_ability"><span>+</span></div>
		</div>
		<hr>
		<div id="introduction"><textarea cols=50 name="company_introduction"><%=company_introduction%></textarea></div>
		<input type="submit" id="edit_btn" value="정보수정하기">
		</form>
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
function checking(){
	if($('input[name=as_provide]').is(":checked")){
		$("#as_label").html("A/S 미제공");
		$("#as_warranty").css("display","none");
		$("#as_fee").css("display","none");
	}
	else{
		$("#as_label").html("A/S 제공");
		$("#as_warranty").css("display","block");
		$("#as_fee").css("display","block");
	}	
}
$("#add_ability").click(function(){
	$(this).before("<div id=\"added\">+<input type=\"text\" class=\"tag\" name=\"tag\"></div>");
})
$(".delete_ability").click(function(){
	alert('hey');
	var url = "delete_ability.jsp?ability_id=";
	alert(url);
	var id = $(this).attr('id');
	url += id;
	location.href = url;
})
$("#as_provide").click(function(){
	checking();
})
$(document).ready(function(){
	checking();
	$('#profile_img').css("background", "url(<%=company_img%>) 50% 0% / 198px");
})
$("#business_license").click(function(){
	location.href = "business_license_upload.jsp";
})
$("#etc_license").click(function(){
	location.href = "etc_license_upload.jsp";
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