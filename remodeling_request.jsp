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
session.setAttribute("page", "remodeling_request.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

//신청내용들 받아오기
String state = request.getParameter("state")+"";
if(!s_id.equals("100"))
	query = "select * from REMODELING_APPLY where Number < 0";
else query = "select * from REMODELING_APPLY";

//특정상태에 대한 결과를 받아오는 탭일 경우
if(!state.equals("null") && !state.equals("NULL") && !state.equals("Null") && state != null){
	query += " where State = " + state;
}
query += " order by State asc, Number desc";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
LinkedList<HashMap<String, String>> itemlist = new LinkedList<HashMap<String, String>>();

while(rs.next()){
	HashMap<String, String> itemmap = new HashMap<String, String>();
	
	String item_number = rs.getString("Number")+"";
	String item_itemnum = rs.getString("Item_num")+"";
	//String agree = rs.getString("agree");
	String item_name = rs.getString("Name")+"";
	String item_phone = rs.getString("Phone")+"";
	String item_address = rs.getString("Address")+"";
	String item_area = rs.getString("Area")+"";
	String item_due = rs.getString("Due")+"";
	String item_budget = rs.getString("Budget")+"";
	String item_visit = rs.getString("Visit")+"";
	String item_compare = rs.getString("compare")+"";
	String item_applydate = rs.getString("Apply_date")+"";
	String item_state = rs.getString("State")+"";
	String item_company = "";
	String item_title = "";
	String item_url = "";
	String item_calling = rs.getString("Calling")+"";
	
	//통합 신청일 경우(item number가 0임)
	if(item_itemnum.equals("0")){
		item_company = "";
		item_title = "통합 신청 버튼으로 신청한 사례";
		item_url = "#";
	}
	else if(item_itemnum.equals("1")){
		item_company = "";
		item_title = "블로그를 통해 신청한 사례";
		item_url = "#";
	}
	else{
		//신청한 사례 원본 가져오기
		String query2 = "select * from REMODELING where Number = ?";
		pstmt = conn.prepareStatement(query2);
		pstmt.setString(1, item_itemnum);
		ResultSet rs2 = pstmt.executeQuery();
		while(rs2.next()){
			item_company = rs2.getString("Company");
			item_title = rs2.getString("Title");
			item_url = rs2.getString("URL");
		}
	}
	
	itemmap.put("company", item_company);
	itemmap.put("title", item_title);
	itemmap.put("url", item_url);
	itemmap.put("number", item_number);
	itemmap.put("itemnum", item_itemnum);
	itemmap.put("name", item_name);
	itemmap.put("phone", item_phone);
	itemmap.put("address", item_address);
	itemmap.put("area", item_area);
	itemmap.put("due", item_due);
	itemmap.put("budget", item_budget);
	itemmap.put("visit", item_visit);
	itemmap.put("compare", item_compare);
	itemmap.put("applydate", item_applydate);
	itemmap.put("state", item_state);
	itemmap.put("calling", item_calling);
	
	itemlist.add(itemmap);
}

//회사 받아오기
query = "Select * from COMPANY where State = 1";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
LinkedList<HashMap<String, String>> company = new LinkedList<HashMap<String, String>>();
while(rs.next()){
	HashMap<String, String> mymap = new HashMap<String, String>();
	mymap.put("id", rs.getString("Id"));
	mymap.put("name", rs.getString("Name"));
	company.add(mymap);
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
.phone :after{
	content:"";
	
	
	border: 1px solid black;
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
textarea{
	width: 100%;
    font-size: 9pt;
    overflow: hidden;
}
@media (max-width : 400px){
/*반응형*/
	.item {
    	width: 93%;
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
	<div>
	<%
	//Arraylist- itemlist에 있는 개수만큼 반복하기
	for(HashMap<String, String> hm : itemlist){
	%>
    	<div class="item">
    	<div class="no">no.<%out.println(hm.get("number"));%></div>
    		<div class="item_wrapper">
    			<div class="info"><span><%out.print(hm.get("company"));%></span><a href="<%out.println(hm.get("url"));%>"><%out.println(hm.get("title"));%></a></div>
    			<div class="info"><span>이름</span> <%out.println(hm.get("name"));%></div>
    			<div class="info phone"><span>전화번호</span> <%out.println(hm.get("phone"));%></div>
    			<div class="info"><span>주소</span> <%out.println(hm.get("address"));%></div>
    			<div class="info"><span>평수</span> <%out.println(hm.get("area"));%></div>
    			<div class="info"><span>예정일</span> <%out.println(hm.get("due"));%></div>
    			<div class="info"><span>예산</span> <%out.println(hm.get("budget"));%></div>
    			<div class="info"><span>방문상담</span> <%if(hm.get("visit").equals("1")) out.println("예"); else out.println("아니오");%></div>
    			<div class="info"><span>비교견적</span> <%if(hm.get("compare").equals("1")) out.println("예"); else out.println("아니오");%></div>
    			<div class="info"><span>신청날짜</span> <%out.println(hm.get("applydate"));%></div>
    			<div class="info"><span>연락방식</span> <%if(hm.get("calling").equals("1")) out.println("업체의 전화를 기다리고 있습니다."); else out.println("고객님이 직접 전화하실 예정입니다.");%></div>
    			<div class="info"><span>처리상태</span> <div class="state"><%if(hm.get("state").equals("0")){%><div id="stt0"><% out.println("신청완료");%></div><%}%>
    																	<%if(hm.get("state").equals("1")){%><div id="stt1"><% out.println("업체전달완료");%></div><%}%>
    																	<%if(hm.get("state").equals("2")){%><div id="stt2"><% out.println("상담완료");%></div><%}%>
    																	<%if(hm.get("state").equals("3")){%><div id="stt3"><% out.println("거래성사");%></div><%}%>
    												</div>
    			</div>
    			<div class="info"><span>고객페이지</span>
    			<textarea id="textarea<%out.print(hm.get("number"));%>">https://somoonhouse.com/customer_login.jsp?customer_num=<%out.print(hm.get("number"));%></textarea>
    			<input type="button" value="링크복사" onclick="myFunction('textarea<%out.print(hm.get("number"));%>')">
    			</div>
    			<%// 처리상태 - 0:신청완료 1:업체전달완료 2:상담완료 3:거래성사 %>
    			<div class="company">
    				<div>어느 회사로 넘길까요?</div>
    				<form action="_assign_company.jsp" method="GET" target="_self">
    				<input type="hidden" name="apply_num" value="<%out.print(hm.get("number"));%>">
    				<%
    				for(HashMap<String, String> hm2 : company){
    					%>
    					<div><input type="checkbox" name="company" value="<%out.print(hm2.get("id"));%>" id="<%out.println(hm.get("number"));%>company<%out.print(hm2.get("id"));%>"><label for="<%out.println(hm.get("number"));%>company<%out.print(hm2.get("id"));%>" ><span></span><%out.print(hm2.get("name"));%></label></div>
    					<%
    				}
    				%>
    				<div class="submit_btn">
    					<input type="submit" value="넘기기">
    				</div>
    				</form>
    			</div>
   		 	</div>
    	</div>
    	<%}%>
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
function myFunction(a) {
	var copyText = document.getElementById(a);
	copyText.select();
	copyText.setSelectionRange(0, 99999); /*For mobile devices*/
	document.execCommand("copy");
	alert("복사되었습니다");
	}
</script>
<script>
window.onload = function(){
	if("<%=s_id%>" != "100" || "<%=s_id%>" == null){
		history.back();
	}
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