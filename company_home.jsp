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
company_id = request.getParameter("company_id");

String company_name = "";
String company_area = "";
String company_as_warranty = "";
String company_as_fee = "";
String company_as_provide = "";
String company_career = "";
String company_img = "";
ArrayList<String> company_abilities = new ArrayList<String>();
String company_introduction = "";

query = "select * from COMPANY where Id = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();

while(rs.next()){
	company_name = rs.getString("Name");
	company_area = rs.getString("Address");
	company_as_warranty = rs.getString("As_warranty");
	company_as_fee = rs.getString("As_fee");
	company_as_provide = rs.getString("As_provide");
	company_career = rs.getString("Career");
	company_img = rs.getString("Profile_img");
	company_introduction = rs.getString("introduction");
}

int i =0;
query = "select A.Title from SPECIALIZED S, COMPANY_ABILITIES A where S.Company_num = ? and S.Ability_num = A.Id";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
rs = pstmt.executeQuery();
while(rs.next()){
	company_abilities.add(rs.getString("A.Title"));
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
		<div id="profile_img"></div>
		<div id="company_name"><%=company_name%></div>
		<%
		if(company_as_provide.equals("1")){
			%>
			<div class="as_provide<%=company_as_provide%>">A/S 제공</div>
			<div id="company_address"><%=company_area%></div>
			<div id="company_address">A/S 기간  <%=company_as_warranty%></div>
			<div id="company_address">A/S 금액  <%=company_as_fee%></div>
			<%
		}
		%>	
		<div id="company_address">경력 기간 <%=company_career%></div>
		<div id="company_abilities">
			<%
			for(i=0;i<company_abilities.size();i++){
				%>
				<div>
				<%out.print(company_abilities.get(i));%>
				</div>
				<%
			}
			%>
		</div>
		<hr>
		<div id="introduction"><div><%=company_introduction%></div></div>
		<div id="request_btn">견적상담받기</div>
		<%
		if(s_id.equals(company_id)){
			%>
			<div id="edit_info">정보 수정하기</div>
			<%
		}
		%>
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
	$("#edit_info").click(function(){
		location.href="company_edit.jsp";
	})
$(document).ready(function(){
	$('#profile_img').css("background", "url(<%=company_img%>) 50% 50% / 198px");
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