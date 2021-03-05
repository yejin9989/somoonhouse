<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
/*현재 페이지 저장
String now = "_remodeling_form.jsp";
*/

//DB에 사용 할 객체들 정의
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
Statement stmt = null;
String query = "";
String sql = "";
ResultSet rs = null;

//세션 생성 create session
session.setAttribute("page", "company_request.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

//업체별 신청내용 받아오기. 세션이 있을 경우. 세션이 없는경우는 현재 테스트를 위해 다 보이도록 해두었지만
////////**********추후에 세션이 없는 경우에는 접근 못하도록 수정 해야함 ***********/////////
query = "select * from ASSIGNED";
//out.println("로그인된 아이디는 " + s_id);
if(!s_id.equals("null") && !s_id.equals("NULL") && !s_id.equals("Null") && s_id != null && !s_id.equals("")){
	query += " where Company_num = " + s_id;
}
else{
	query += " where Apply_num = -1";
}
query += " order by Apply_num desc";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();

LinkedHashMap<String, String> assignedmap = new LinkedHashMap<String, String>();
while(rs.next()){
	
	String apply_num = rs.getString("Apply_num");
	String state_eng = rs.getString("State");
	String state = "";
	if(state_eng.equals("0"))
		state = "상담 대기";
	else if(state_eng.equals("1"))
		state = "상담 중";
	else if(state_eng.equals("2"))
		state = "상담 완료";
	else if(state_eng.equals("3"))
		state = "통화 불가";
	else if(state_eng.equals("4"))
		state = "계약 대기 중";
	else if(state_eng.equals("5"))
		state = "계약 성사";
	else
		state = "계약 불발";
	
	assignedmap.put(apply_num, state_eng);
	
}

//신청정보 가져오기
LinkedList<LinkedHashMap<String, String>> applylist = new LinkedList<LinkedHashMap<String, String>>();

for(String key : assignedmap.keySet()){
	LinkedHashMap applymap = new LinkedHashMap<String, String>();
	
	query = "select * from REMODELING_APPLY where Number = ?";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, key);
	rs = pstmt.executeQuery();
	while(rs.next()){
		String item_number = rs.getString("Number");
		String item_itemnum = rs.getString("Item_num");
		String item_name = rs.getString("Name");
		String item_phone = rs.getString("Phone");
		String item_address = rs.getString("Address");
		String item_area = rs.getString("Area");
		String item_due = rs.getString("Due");
		String item_budget = rs.getString("Budget");
		String item_visit = rs.getString("Visit");
		String item_compare = rs.getString("compare");
		String item_applydate = rs.getString("Apply_date");
		String item_state = rs.getString("State");
		String item_calling = rs.getString("Calling");

		applymap.put("number", item_number);
		applymap.put("itemnum", item_itemnum);
		applymap.put("name", item_name);
		applymap.put("phone", item_phone);
		applymap.put("address", item_address);
		applymap.put("area", item_area);
		applymap.put("due", item_due);
		applymap.put("budget", item_budget);
		applymap.put("visit", item_visit);
		applymap.put("compare", item_compare);
		applymap.put("applydate", item_applydate);
		applymap.put("state", item_state);
		applymap.put("calling", item_calling);
		
		applylist.add(applymap);
	}
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
-webkit-appearance: none;
-moz-applearance: none;
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
#divider{
	width:100%;
	height:20px;
	border-top: 1px solid black;
	border-radius: 5px;
}
#content{
    margin: 60px auto;
    max-width: 600px;
}
.item {
    width: 43%;
    display: inline-block;
    margin: 1%;
    border-radius: 5px;
    padding: 2%;
    background: #fbfbfb;
    box-shadow: 0px 0px 6px #e2e2e2;
}
.item .no{
	color: #909090;
    font-size: 10pt;
}
.item_wrapper{
	padding:20px;
}
.item_wrapper div.info{
	margin-bottom: 15px;
    padding-bottom: 4px;
    border-bottom: 3px dotted #e5e5e5;
    width: 91%;
}
.item_wrapper span{
	display: block;
	font-size:9pt;
	margin-bottom: 5px;
	color:gray;
}
#stt0, #stt1, #stt2, #stt3{
	color: white;
	font-size: 9pt;
    border-radius: 5px;
    padding: 1px 4px;
    width: fit-content
}
#stt0{
	background: #476aba;
}
#stt1{
	background: #ba4747;
}
#stt2{
	background: #47ba47;
}
#stt3{
	background: #8e47ba;
}
.company{
	padding-top:20px;
}
.company div{
	padding: 9px;
}
.submit_btn{
	text-align:center;
	padding:10px;
	
}
.submit_btn input{
	width: 100%;
    border: none;
    border-radius: 5px;
    height: 32px;
    background: #eaeaea;
}
select{
    width: 100%;
    height: 39px;
    padding: 7px;
    border-radius: 10px;
}
.selectbox{
	position:relative;
}
.selectbox:before {
    content: "";
    position: absolute;
    top: 50%;
    right: 15px;
    width: 0;
    height: 0;
    margin-top: -1px;
    border-left: 5px solid transparent;
    border-right: 5px solid transparent;
    border-top: 5px solid #333;
}
#company_profile{
	width:fit-content;
	padding:10px;
	margin: 10px auto 30px;
	border-radius: 5px;
    background: #62a5ff;
    color: white;
    box-shadow: 0px 0px 5px #6aa9ff;
    cursor:pointer;
}
@media (max-width : 530px){
/*반응형*/
	.item {
    	width: 90%;
    	min-width:300px;
	}
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
	<div style="margin:auto;width:max-content;color: #31b1f2;font-size:10pt;">대구 1등 리모델링 플랫폼</div>
	</div>
</div>
<div></div>
<div id="content">
    <div style="width:100%;display:inline-block;border-radius:5px;">
<%
%>
	<!------------ 내용물  --------------->
	<div id="company_profile">회사 프로필 보기 / 수정</div>
	<div>
	<%
	//Arraylist- itemlist에 있는 개수만큼 반복하기
	for(LinkedHashMap<String, String> hm : applylist){
	%>
    	<div class="item">
    	<div class="no">no.<%out.println(hm.get("number"));%></div>
    		<div class="item_wrapper">
    			<div class="info"><span>이름</span> <%out.println(hm.get("name"));%></div>
    			<div class="info"><span>전화번호</span> <%out.println(hm.get("phone"));%></div>
    			<div class="info"><span>주소</span> <%out.println(hm.get("address"));%></div>
    			<div class="info"><span>평수</span> <%out.println(hm.get("area"));%></div>
    			<div class="info"><span>예정일</span> <%out.println(hm.get("due"));%></div>
    			<div class="info"><span>예산</span> <%out.println(hm.get("budget"));%></div>
    			<div class="info"><span>방문상담</span> <%if(hm.get("visit").equals("1")) out.println("예"); else out.println("아니오");%></div>
    			<div class="info"><span>비교견적</span> <%if(hm.get("compare").equals("1")) out.println("예"); else out.println("아니오");%></div>
    			<div class="info"><span>신청날짜</span> <%out.println(hm.get("applydate"));%></div>
    			<div class="info"><span>연락방식</span> <%if(hm.get("calling").equals("1")) out.println("업체의 전화를 기다리고 있습니다."); else out.println("고객님이 직접 전화하실 예정입니다.");%></div>
    			<div class="info"><span>처리상태</span> <div class="state"><%if(assignedmap.get(hm.get("number")).equals("0")){%><div id="stt0"><% out.println("상담 대기");%></div><%}%>
    																	<%if(assignedmap.get(hm.get("number")).equals("1")){%><div id="stt0"><% out.println("상담 중");%></div><%}%>
    																	<%if(assignedmap.get(hm.get("number")).equals("2")){%><div id="stt1"><% out.println("상담 완료");%></div><%}%>
    																	<%if(assignedmap.get(hm.get("number")).equals("3")){%><div id="stt2"><% out.println("통화 불가");%></div><%}%>
    																	<%if(assignedmap.get(hm.get("number")).equals("4")){%><div id="stt2"><% out.println("계약 대기중");%></div><%}%>
    																	<%if(assignedmap.get(hm.get("number")).equals("5")){%><div id="stt3"><% out.println("계약 성사");%></div><%}%>
    																	<%if(assignedmap.get(hm.get("number")).equals("6")){%><div id="stt4"><% out.println("계약 불발");%></div><%}%>
    																	<%if(assignedmap.get(hm.get("number")).equals("7")){%><div id="stt4"><% out.println("상담 취소");%></div><%}%>
    												</div>
    			</div>
    			<%// 처리상태 - 상담전, 상담중, 상담완료, 거래성사 %>
    			<div class="company">
    				<form action="_company_request_state.jsp" method="GET" target="_self">
    				<input type="hidden" name="apply_num" value="<%out.print(hm.get("number"));%>">
    					<div class="selectbox">
    					<select name="state" id="select">
    						<option value="0" selected>상담 대기</option>
    						<option value="1">상담 중</option>
    						<option value="2">상담 완료</option>
    						<option value="3">통화불가</option>
    						<option value="4">계약 대기중</option>
    						<option value="5">계약 성사</option>
    						<option value="6">계약 불발</option>
    						<option value="7">상담 취소</option>
    					</select>
    					</div>
    				<input type="hidden" name="apply_num" value="<%=hm.get("number")%>">
    				<div class="submit_btn">
    					<input type="submit" value="수정">
    				</div>
    				</form>
    			</div>
   		 	</div>
    	</div>
    	<%}%>
	</div>
	<a href="_logout.jsp">로그아웃</a>
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
window.onload = function(){
	if("<%=s_id%>" == "" || s_id == "null"){
		alert("유효하지 않은 접근입니다!");
		history.back();
	}
}
$('#company_profile').click(function(){
	location.href="company_edit.jsp"
})
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