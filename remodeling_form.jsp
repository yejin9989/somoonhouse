<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "remodeling_form.jsp"); %>
<%
Connection conn = DBUtil.getMySQLConnection();
ResultSet rs = null;
PreparedStatement pstmt = null;
String query = "";
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
<link rel="SHORTCUT ICON" href="img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
@font-face{
font-family:'Nanum Gothic',sans-serif;
}
*{
font-family:'Nanum Gothic',sans-serif;
font-size: 11pt;
color: #313131;
}
#container {
    width: 100%;
    max-width: 700px;
    margin: 0 auto;
    box-shadow: 0px 0px 20px #f4f4f4;
}
#somun_navbar {
    /*border-bottom: 1px solid #c8c8c8;*/
    display: inline-block;
    height: fit-content;
    width: 100%;
    padding: 39px 0 11px;
}
span.nametag{
display:block;
margin-bottom: 20px;
}
div.item{
margin: 20px 0px;
border: 1px solid #d2d2d2;
padding: 18px;
border-radius: 5px;
background: white;
text-align: left;
}
div input[type="text"], select{
border: none;
border-bottom: 1px solid #d2d2d2;
height: 25px;
width: 85%;
margin-right: 6px;
}
select{
width: 98%;
}
div input[type="text"]:focus{
outline:none;
border-bottom: 2px solid #5f92ff;
}
#remodeling_form{
width:95%;
max-width:600px;
margin:auto;
}
#align_form{
margin: 13px auto;
max-width: 332px;
width: 100%;
}
input[type="radio"]{
display:none;
}

input[type="radio"]:checked + label{
color : white;
background-color : #6aacff;
border: 1px solid #6aacff;
}
label{
width: 34%;
display:inline-block;
postion:relative;
cursor:pointer;
-webkit-user-select:none;
-moz-user-select:none;
-ms-user-select:none;
border: 1px solid #cacaca;
border-radius: 5px;
padding: 11px 19px;
margin: 3px 1px;
background-color: white;
color: #747474;
text-align:center;
}
input[type="submit"]{
background-color: #6aacff;
color: white;
width: 100%;
height: 51px;
border-radius: 5px;
border: 0px;
font-size:16px;
-webkit-appearance:none;
-webkit-border-radius:5px;
}
.agree a{
font-size: 10px;
text-decoration: underline;
color:gray;
}
#form_description{
text-align: center;
}
#form_description h2{
font-size: 18pt;
font-weight: unset;
}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>
</head>
<body>
<div id="container">
<div id="somun_navbar">
	<div id="somun_menu"></div>
	<div style="float:left;width:100%;height:max-content;margin-bottom:10px;text-align:center;">
	<div id="somun_logo"><a href="index.jsp"><img style="width:128px;"src="img/somunlogo.png"></a></div>
	<div style="margin:auto;width:max-content;color: #6d6d6d;font-size:10pt;">우리 동네 리모델링 플랫폼</div>
	</div>
</div>
<div id="content">
    <div style="width:100%;display:inline-block;border-radius:5px;">
    <div id="content" style="float:left;width:100%;margin:60px auto;">
<%
// 세션 생성 create session
session.setAttribute("page", "remodeling_form.jsp"); // 현재 페이지 current page
// 세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";
//DB개체들 가져오기
conn = DBUtil.getMySQLConnection();
rs = null;
pstmt = null;
query = "";
//사례번호 가져오기
String item_num = request.getParameter("item_num")+"";
%>
	
	
	
	
	
	
	<!------------ 내용물  --------------->
	<div id="remodeling_form">
	<div id="align_form">
	<form action="_remodeling_form.jsp" method="post"  onSubmit="return formChk();">
	<div id="form_description">
		<h2>상담신청서</h2>
		<div class="item">
			<p>종합 리모델링의 경우 대면 상담이 필요합니다. 전화만으로 상세 견적을 내드리기는 어렵습니다.</p>
			<p>대면 상담을 요청하시고 상세한 견적을 받고 고민해 보시는 걸 추천드립니다.</p>
		</div>
	</div>
	<!-- div class="item">
		사례 사진
	</div-->
	<input type="hidden" name="item_num" value="<%=item_num%>">
	<div class="item agree"><input type="checkbox" name="agree"> 개인정보 활용동의 <a href="personal.html" target="_blank">전문보기</a></div>
	<div class="item"><span class="nametag">성함</span><input type="text" name="name"></div>
	<div class="item"><span class="nametag">휴대폰</span><input type="text" name="phone"></div>
	<div class="item"><span class="nametag">시공예정지 주소</span><input type="text" name="address"></div>
	<div class="item"><span class="nametag">시공예정지 평수</span><input type="text" name="area" pattern="\d*">평</div>
	<div class="item"><span class="nametag">시공예정일</span>
		<input type="radio" name="due" value="1개월 이내" id="due1"><label for="due1">1개월 이내</label>
		<input type="radio" name="due" value="2개월 이내" id="due2"><label for="due2">2개월 이내 </label>
		<input type="radio" name="due" value="2개월 이후" id="due3"><label for="due3">2개월 이후</label>
	</div>
	<div class="item"><span class="nametag">예산</span>
		<select name="budget">
			<option>1천만원 이하</option>
			<option>2천만원 이하</option>
			<option>3천만원 이하</option>
			<option>4천만원 이하</option>
			<option>5천만원 이하</option>
			<option>6천만원 이하</option>
			<option>8천만원 이하</option>
			<option>1억원 이하</option>
			<option>1억원 이상</option>
			<option>미정(상담 후 결정)</option>
		</select>
	</div>
	<div class="item"><span class="nametag">무료방문상담</span>
		<input type="radio" name="visit" value="1" id="visit1"><label for="visit1">필요함</label>
		<input type="radio" name="visit" value="0" id="visit0"><label for="visit0">필요없음</label>
	</div>
	<div class="item"><span class="nametag">비교견적</span><span style="font-size:10pt;display:block;margin-bottom:10px;line-height:1.3em;">다른 업체에서도 상담 연락을 받아보시겠어요?<br>동의하시면 추천업체 2-3곳에 상담신청서가 함께 전달됩니다.</span>
		<input type="radio" name="compare" value="1" id="compare1"><label for="compare1">예</label>
		<input type="radio" name="compare" value="0" id="compare0"><label for="compare0">아니오</label>
	</div>
	<div class="calldiv item"><span class="nametag">연락방식</span><span style="font-size:10pt;display:block;margin-bottom:10px;line-height:1.3em;">업체 배정 후 마이페이지에서 업체별 연락처를 확인하실 수 있습니다</span>
    	<input type="radio" name="call" id="callplease" value="1"><label for="callplease" class="please">전화주세요</label>
    	<input type="radio" name="call" id="callwill"  value="0"><label for="callwill"  class="will">전화 걸게요</label>
    </div>
	<input type="submit" value="무료상담신청">
	</form>
	</div>
	</div>
	<!------------ 내용물  --------------->
	</div>
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
function formChk(){
	return confirm("소문난집에서는 업체의 추천, 업체와의 소통에 도움은 드릴 수 있으나 A/S, 공사와 관련된 일체의 책임은 시공 업체에 있습니다.\n업체 별로 A/S기간과 범위의 차이가 있으니 이를 꼭 확인하시고 계약하시기 바랍니다.");
}
</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "3602e31fd32c7e";
wcs_do();
</script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</div>
</div>
</body>
</html>