<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "sample_collect.jsp"); %>
<!DOCTYPE html>
<html>
<head>
<link rel="SHORTCUT ICON" href="img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick-1.8.1/slick/slick-theme.css"/>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style type="text/css">
@font-face{
font-family:"Nanum";
src:url("fonts/NANUMBARUNGOTHIC.TTF");
}
*{
font-family:"Nanum";
}
body {
  position: absolute;
  padding: 0;
  margin: 0;
  border:0px;
  width: 100%;
  height: 100%;
  background-color: #fff;
  align-items: center;
  justify-content: center;
  background-color:white;
}
a{
text-decoration:none;
}
.tag{
color:white; background-color:#ccc; border-radius:5px;padding:2px;
}
#search{
padding:6px; position:relative; top:-1px; background-color:white; border: 1px solid #9d9d9d;height:33px;
}
.slick-prev{
left:5px;
z-index: 10;
}
.slick-next{
right:5px;
z-index : 10;
}
#somun_navbar{
/*border: 1px solid red;*/
border-bottom: 1px solid #c8c8c8;
display: inline-block;
/*height: 150px;*/
width: 100%;
}
#somun_logo{
/*border: 1px solid blue;*/
display: block;
/*background: url("img/somunhouselogo.png") no-repeat;*/
height: 70px;
line-height: 50px;
width: 70px;
margin: 8px;
float:left;
position: relative;
left: 25px;
top: 15px;
font-weight: bold;
color: #31b1f2;
font-size: 17px;
}
#somun_search{
margin: 10px;
float:left;
width:70%;
min-width:40px;
max-width:700px;
margin:10px;
position: relative;
left: 25px;
top: 14px;
height:70px;
}
.search_item{
width:100%;
display: block;
/*border: 1px solid black;*/
margin:5px;
}
#search_item1{
width:100%;
height:40px;
border-radius:20px;
border: 1px solid #c8c8c8;
line-height:40px;
}
#search_item1 input[type="text"]{
width: 85%;
border: 0px;
position: relative;
padding:5px 0;
left: 15px;
}
#search_item1 input[type="submit"]{
float:right;
position: relative;
right: 8px;
height:40px;
width: 32px;
background: url(img/search_btn.png) no-repeat;
border: none;
}
#search_item2{
position: relative;
left: 2px;
top:3px;
}
.btn{
height:33px;
background-color:white;
border:1px solid #9d9d9d;
border-radius: 3px;
}

#jusobtn{
width:70px;
margin-right:5px;
}

#search_item2>div>select{
border: none;
padding: 5px;
margin: 0 7px 0 0;
}

.item{
width: 45%;
height:170px;
float: left;
display:inline-block;
padding:8px 0px 8px 11px;
border-radius:6px;
overflow:hidden;
position:relative;
}

.item img{
width:170%;
display:block;
position:relative;
left: -25%;
}
.itemdiv{
overflow:hidden;
border-radius: 10px;
padding:1px;
height:100%;
position:relative;
}
.req_btn{
width:77px;
height:45px;
position:absolute;
float:left;
right:0px;
bottom:15px;
background-image:url(img/req_btn.png);
background-size:77px 45px;
}

@media (max-width : 768px){

#somun_logo{
	left: 3px;
	float: left;
	}
#somun_search{
	left:0px;
}
}
@media (max-width : 370px){
.item img{
width:140px;
}
.itemdiv{
overflow:hidden;
border-radius: 10px;
width:130px;
height:150px;
overflow:hidden;
}
}

</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>

<script>
    function slicky(a){
    	$(a).slick({
    				arrows:true,
    				autoplay: true,
    				autoplaySpeed: 2000
    		});
    	}
</script>
<script language="javascript">

function goPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
	var pop = window.open("jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo,entX,entY){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
			document.form.roadFullAddr.value = roadFullAddr;
			document.form.roadAddrPart1.value = roadAddrPart1;
			document.form.roadAddrPart2.value = roadAddrPart2;
			document.form.addrDetail.value = addrDetail;
			document.form.engAddr.value = engAddr;
			document.form.jibunAddr.value = jibunAddr;
			document.form.zipNo.value = zipNo;
			document.form.admCd.value = admCd;
			document.form.rnMgtSn.value = rnMgtSn;
			document.form.bdMgtSn.value = bdMgtSn;
			document.form.detBdNmList.value = detBdNmList;
			document.form.bdNm.value = bdNm;
			document.form.bdKdcd.value = bdKdcd;
			document.form.siNm.value = siNm;
			document.form.sggNm.value = sggNm;
			document.form.emdNm.value = emdNm;
			document.form.liNm.value = liNm;
			document.form.rn.value = rn;
			document.form.udrtYn.value = udrtYn;
			document.form.buldMnnm.value = buldMnnm;
			document.form.buldSlno.value = buldSlno;
			document.form.mtYn.value = mtYn;
			document.form.lnbrMnnm.value = lnbrMnnm;
			document.form.lnbrSlno.value = lnbrSlno;
			document.form.emdNo.value = emdNo;
			document.form.entX.value = entX;
			document.form.entY.value = entY;
}

</script>
</head>
<body>

<div id="somun_navbar">
	    <!-- 
	<input type="button" onClick="goPopup();" value="주소찾기"/>
    <input type="text" id="bdNm"  name="bdNm" />
    <input type="text" id="building" name="building" />동
	<input id="search" type="submit" value="검색">
	-->
	<div id="somun_menu"></div>
	<div id="somun_search">
		<div class = "search_item" id="search_item1">
			<input type="text" id="bdNm"  name="bdNm" placeholder = "아파트 명으로 찾기">
			<input type="submit" value="">
		</div>
		<!-- 
		<div class = "search_item" id="search_item2">
			<div>
				<input type="button" id="jusobtn" class="btn" onClick="goPopup();" value="주소찾기"/>
				<select name = "rootarea" onchange="categoryChange(this)">
				<%
					Connection conn = DBUtil.getMySQLConnection();
					ResultSet rs = null;
					PreparedStatement pstmt = null;
					String query = "";
					
					query = "Select * from ROOT_AREA";
					pstmt = conn.prepareStatement(query);
					rs=pstmt.executeQuery();
					
					while(rs.next()){
						String rootarea_name = rs.getString("Area_name");
						int rootarea_num = rs.getInt("Area_number");
						%>
						<option value="<%=rootarea_num%>"><%=rootarea_name%></option>
						<%
					}
				%>
				</select>
				<%
				query = "Select count(*) from ROOT_AREA";// number of ROOTAREA
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				
				%>
				<select name = "secondarea">
					<option value="대구전체">대구전체</option>
					<option value="중구">중구</option>
					<option value="동구">동구</option>
					<option value="서구">서구</option>
					<option value="남구">남구</option>
					<option value="북구">북구</option>
					<option value="수성구">수성구</option>
					<option value="달서구">달서구</option>
					<option value="달성군">달성군</option>
				</select>
				<select name = "building">
					<option value="침산코오롱하늘채">침산코오롱하늘채</option>
					<option value="성광우방아파트">성광우방아파트</option>
					<option value="칠곡e그린타운아파트">칠곡e그린타운아파트</option>
				</select>
			</div>
		</div>
		 -->
	</div>
	<a href="index.jsp"><div id="somun_logo">소문난집</div></a>
</div>
  <%
    String clientId = "RO12hlpvFt7WEiDVKCDB";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://milymoodlounge.com/callback.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
<%
// 세션 생성 create session
session.setAttribute("page", "remodeling.jsp"); // 현재 페이지 current page
// 세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";
String attr = request.getParameter("attr")+"";
String itemname = request.getParameter("itemname")+"";
String tag = request.getParameter("tag")+"";
%>
<%
now = session.getAttribute("page") + "";
conn = DBUtil.getMySQLConnection();
rs = null;
pstmt = null;
query = "";
//int point=0;
//query="SELECT * FROM USERS WHERE Id = ?";
//pstmt = conn.prepareStatement(query);
//pstmt.setString(1,s_id);
//rs=pstmt.executeQuery();
//while(rs.next()){
	//point = rs.getInt("Point");
//}
//pstmt.close();
//rs.close();
query="";
%>
<!-- jsp:include page="navbar.jsp" flush="false"/ -->
<%
//CSRF 방지를 위한 상태 토큰 검증
//세션 또는 별도의 저장 공간에 저장된 상태 토큰과 콜백으로 전달받은 state 파라미터 값이 일치해야 함

//콜백 응답에서 state 파라미터의 값을 가져옴
state = request.getParameter("state");
%>
<%
String xx = request.getParameter("entX");
String yy = request.getParameter("entY");
float x = 0;
float y = 0;
if (xx != null) x = Float.parseFloat(xx);
if (yy != null) y = Float.parseFloat(yy);
pstmt = null;
query = "";
conn = DBUtil.getMySQLConnection();
rs = null;
String build = null;
build = request.getParameter("bdNm");
/*if(build != null && !build.equals("null")){
	query = "Select * from REMODELING where Building = ?";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, build);
}
else{*/
	query = "Select * from REMODELING order by Apart_name asc";
	pstmt = conn.prepareStatement(query);
//}
rs = pstmt.executeQuery();
String item[][] = new String[10000][17];
int i = 0;
while(rs.next()){
	item[i][0] = rs.getString("Number");
	item[i][1] = rs.getString("Id");
	item[i][2] = rs.getString("Title");
	item[i][3] = rs.getString("Write_date");
	item[i][4] = rs.getString("Company");
	item[i][5] = rs.getString("Fee");
	item[i][6] = rs.getString("Address");
	item[i][7] = rs.getString("Apart_name");
	item[i][8] = rs.getString("Building");
	item[i][9] = rs.getString("Xpos");
	item[i][10] = rs.getString("Ypos");
	item[i][11] = rs.getString("Content");
	item[i][12] = "0";
	item[i][13] = rs.getString("URL");
	item[i][14] = rs.getString("Price_area");
	item[i][15] = rs.getString("Period");
	item[i][16] = rs.getString("Part");
	//거리계산//item[i][12] = String.valueOf(Math.sqrt(((x-Float.parseFloat(item[i][10]))*(x-Float.parseFloat(item[i][10])))+((y-Float.parseFloat(item[i][9]))*(y-Float.parseFloat(item[i][9])))));
	i++;
}
int itemnum = i;
//거리순정렬
/*
int min = 0;
int j;
String temp[] = new String[14];
for(i = 0; i < item.length; i++){
	min = i;
	for(j = i+1; j < item.length; j++){
		if (Float.parseFloat(item[min][12]) > Float.parseFloat(item[j][12])) min = j;
	}
	temp = item[i];
	item[i] = item[j];
	item[j] = temp;
}*/
%>
<div>
    <%
    //검색창 & 필터 만들기!
    %>
    <div style="width:100%;display:block;">
    <form id="form" name="form" method="POST" action="remodeling.jsp">
    <!--  
    <input type="button" style="height:33px;width:70px;background-color:white;border:1px solid #9d9d9d;"onClick="goPopup();" value="주소찾기"/>
    <input type="text"  style="width:170px;height:30px;" id="bdNm"  name="bdNm" />
    <input type="text" style="width:40px;height:30px;" id="building" name="building" />동
	<input id="search" type="submit" value="검색">
    -->
    <%String classes = "0"; %>
    	<input type="hidden"  style="width:500px;" id="jibunAddr"  name="jibunAddr" />
    	<input type="hidden"  style="width:500px;" id="roadFullAddr"  name="roadFullAddr" />
		<input type="hidden"  style="width:500px;" id="roadAddrPart1"  name="roadAddrPart1" />
		<input type="hidden"  style="width:500px;" id="addrDetail"  name="addrDetail" />
		<input type="hidden"  style="width:500px;" id="roadAddrPart2"  name="roadAddrPart2" />
		<input type="hidden"  style="width:500px;" id="engAddr"  name="engAddr" />			
		<input type="hidden"  style="width:500px;" id="zipNo"  name="zipNo" />
		<input type="hidden"  style="width:500px;" id="admCd"  name="admCd" />
		<input type="hidden"  style="width:500px;" id="rnMgtSn"  name="rnMgtSn" />
		<input type="hidden"  style="width:500px;" id="bdMgtSn"  name="bdMgtSn" />
		<input type="hidden"  style="width:500px;" id="detBdNmList"  name="detBdNmList" />
		<input type="hidden"  style="width:500px;" id="bdKdcd"  name="bdKdcd" />
		<input type="hidden"  style="width:500px;" id="siNm"  name="siNm" />
		<input type="hidden"  style="width:500px;" id="sggNm"  name="sggNm" />
		<input type="hidden"  style="width:500px;" id="emdNm"  name="emdNm" />
		<input type="hidden"  style="width:500px;" id="liNm"  name="liNm" />
		<input type="hidden"  style="width:500px;" id="rn"  name="rn" />
		<input type="hidden"  style="width:500px;" id="udrtYn"  name="udrtYn" />
		<input type="hidden"  style="width:500px;" id="buldMnnm"  name="buldMnnm" />
		<input type="hidden"  style="width:500px;" id="buldSlno"  name="buldSlno" />
		<input type="hidden"  style="width:500px;" id="mtYn"  name="mtYn" />		
		<input type="hidden"  style="width:500px;" id="lnbrMnnm"  name="lnbrMnnm" />
		<input type="hidden"  style="width:500px;" id="lnbrSlno"  name="lnbrSlno" />
		<input type="hidden"  style="width:500px;" id="emdNo"  name="emdNo" />
		<input type="hidden"  style="width:500px;" id="entX"  name="entX" />
		<input type="hidden"  style="width:500px;" id="entY"  name="entY" />
	</form>	
    <div style="float:left;width:100%;margin:10px auto;">
    <%
	if(!s_id.equals("") && !s_id.equals("null"))
	{%>
	<div style="width:100%;text-align:center;"><a href="item_upload.jsp" target="_blank"><button style="width:150px;height:45px;margin:40px;border-radius:5px; background-color:#29aef2; color:white; font-size:17px; border:none;">사례등록  ></button></a></div>
	<%}%>
    <%
    for(i=0; i<itemnum; i++){
    	%>
    	<div class="item">
    	<%
    	pstmt = null;
    	query = "SELECT * FROM RMDL_IMG WHERE Number = ? order by Number2";
    	rs = null;
    	pstmt = conn.prepareStatement(query);
    	pstmt.setString(1, item[i][0]);
    	rs = pstmt.executeQuery();
    	%><div class="slider<%=classes%>" style="overflow:hidden;height:100%;border-radius:7px;"><%
    	while(rs.next()){
    		%>
    		<div class="itemdiv">
    		<a href = <%=item[i][13]%> target="_self">
    		<img src="<%=rs.getString("Path")%>" loading="lazy" >
    		</a>
    		</div>
    		<%
    	}
    	%>
		</div>
		<script>
		$(document).ready(function(){slicky(".slider<%=classes%>")});
		</script>
		</div>
		<!-- 견적요청버튼 -->
		<a href = <%=item[i][13]%> target="_self">
		<div class="item">
		<div class="itemdiv">
		<%classes = Integer.toString(Integer.parseInt(classes)+1);%>
		<div style="font-size:10px;color:#999999"><%=item[i][4]%></div><!-- 닉넴 -->
    	<div style="font-size:14px;font-weight:bold;margin:8px 0;color:#3d3d3d"><%=item[i][2]%></div>
    	<!-- div style="font-size:9px;color:#363636">스크랩 12개</div-->
    	<!-- div style="font-size:9px;margin:5px 0;">평당 <%=item[i][14]%>/시공기간 <%=item[i][15]%> 이상</div-->
    	<%
    	//if(!item[i][5].equals("NULL")){
    		%><div style="font-size:19px;font-weight:bold;margin:25px 0 15px 0;color:#3d3d3d"><%=item[i][5]%>만원</div><%
    	//}
    	%>
    	<div style="font-size:10px;"><span style="border-radius:3px;padding:2px;color:white;background-color:orange"><%if(item[i][16].equals("1")) out.println("부분시공불가"); else out.println("부분시공가능");%></span></div>
    	<!-- div>
    	<h2 style="padding:20px;line-height:1.5em;"><%=item[i][2]%></h2>
    	작성일시 : <%=item[i][3]%><br> 
    	시공사 : <%=item[i][4]%><br> 
    	시공비용 : <%=item[i][5]%><br>
    	상세주소 : <%=item[i][6]%><br>
    	<%=item[i][7]%>
    	<%=item[i][8]%> 동<br>
    	거리 : <%=item[i][12] %><br>
    item[i][14] = rs.getString("Price_area");
	item[i][15] = rs.getString("Period");
	item[i][16] = rs.getString("Part");
    	</div-->
    	<%
		if(s_id.equals("100") || s_id.equals(item[i][1]))//관리자 계정이거나 본인 글 일 경우
		{%>
			<a href="_dropremodeling.jsp?num=<%=item[i][0]%>" target="_blank" style="color:red; text-decoration:underline;">X삭제</a>
			<a href="remodeling_edit.jsp?num=<%=item[i][0]%>" target="_blank" style="color:blue;text-decoration:underline;">수정</a>
		
		<%}%>
    	<a href="https://docs.google.com/forms/d/e/1FAIpQLSctI2NMgTGL-Mk-Lhxza-XhoqQAurzInycasGOIyso3t9O0Aw/viewform"><div class="req_btn"></div></a>
		</div>
    	</div>
    	</a>
    	<%
    }
	pstmt.close();
	rs.close();
	query="";
	conn.close();
    %>
    </div>
</div>
</div>
<!-- jsp:include page="footer.jsp" flush="false"/ -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "3602e31fd32c7e";
wcs_do();
</script>

<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</body>
</html>