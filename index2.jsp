<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
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
@import url(https://fonts.googleapis.com/earlyaccess/nanumgothic.css);
@font-face{
font-family:'Nanum Gothic',sans-serif;
}
*{
font-family:'Nanum Gothic',sans-serif;
}
select{
/*ios대응*/
-webkit-appearance: none;
-moz-appearance: none; 
appearance: none;
}
select::-ms-expand{ 
display:none; /* 화살표 없애기 for IE10, 11*/
}
.select__arrow{
  position: absolute;
  top :14px;
  right: 7%;
  width :0;
  height :0;
  pointer-events: none;
  border-style :solid;
  border-width: 8px 5px 0 5px;
  border-color: #999 transparent transparent transparent;
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
#container{
width:100%;
max-width:700px;
margin:0 auto;
box-shadow: 0px 0px 20px #f4f4f4;
}
a{
text-decoration:none;
}
.tag{
color:white; background-color:#ccc; border-radius:5px;padding:2px;
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
/*border-bottom: 1px solid #c8c8c8;*/
display: inline-block;
height: fit-content;
width: 100%;
padding: 39px 0 11px;
}
#somun_logo{
/*border: 1px solid blue;*/
display: block;
/*background: url("img/somunhouselogo.png") no-repeat;*/
width: max-content;
/*float:left;*/
position: relative;
font-weight: bold;
color: #31b1f2;
font-size: 36px;
margin:auto;
}
#somun_logo a{
color: #31b1f2;
}
#somun_logo a:visited{
color: #31b1f2;
}
#somun_logo a:hover{
color: #31b1f2;
}
#somun_logo a:active{
color: #31b1f2;
}
#somun_search{
width:100%;
min-width:40px;
max-width:700px;
left: 25px;
height:fit-content;
}
.search_item{
width:91%;
display: block;
/*border: 1px solid black;*/
margin:auto;
}
#search_item1{
width:70%;
height:40px;
border-radius:20px;
border: 1px solid #c8c8c8;
line-height:40px;
float:left;
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
.btn{
height:33px;
background-color:white;
border:1px solid #9d9d9d;
border-radius: 3px;
}

#search_item2>div>select{
border: none;
padding: 5px;
margin: 0 7px 0 0;
}

#main{
width:100%;display:inline-block;
}
.center{
height: 420px;
overflow: hidden;
}
#recommend #ref{
    padding: 12% 0;
    font-size: 15pt;
    width: fit-content;
    left: 48%;
    position: relative;
    transform: translate(-50%, 0);
}
#ref{
	display: none;
}
#ref::before{
	content: ;
    background-image: url(img/thumbs.png);
    background-size: 45px 45px;
    width: 42px;
    height: 40px;
    display: inline-block;
    line-height: 48px;
}
.ajax_click{
    text-align: center;
    padding: 3% 0 0%;
}
.center img{
}
.center_img{
	box-sizing:border-box;
	border:10px solid white;
}
.center_img div{
	width:100%;
	height:400px;
	border-radius:10px;
	overflow: hidden;
}
#searcharea{
    margin: auto;
    width: 75%;
    position: relative;
    padding: 11px 0px 4px;
}
#jusobtn{
	appearance: none;
	-webkit-appearance: none;
	-webkit-border-radius: 0;
	min-width: 50px;
    width: 70px;
    height: 37px;
    border-radius: 14px;
    border: 0;
    background: #5babff;
    color: white;
    position: absolute;
    left: 4px;
    bottom: 7px;
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
left:50%;
transform:translate(-50%, 0%);
height: 300px;
top: -30px;
}
.itemdiv{
overflow:hidden;
border-radius: 10px;
padding:1px;
height:100%;
position:relative;
}
.req_btn{
width:153px;
height:59px;
position:absolute;
float:right;
right:0px;
bottom:15px;
background-image:url(img/reqbtn2.png);
background-size:153px 59px;
}

input[name="Daegu"]{
position: absolute;
width:1px;
height:1px;
padding:0;
margin:-1px;
overflow:hidden;
clip:rect(0,0,0,0);
border:0;
}
select[name="Apart"]{
width: 91%;
    height: 35px;
    border-radius: 10px;
    padding: 0px 16px;
}
input[type="radio"]:checked + label{
color : white;
background-color : #6aacff;
border: 1px solid #6aacff;
}
.mylabel{
display:inline-block;
postion:relative;
cursor:pointer;
-webkit-user-select:none;
-moz-user-select:none;
-ms-user-select:none;
border: 1px solid #d4d4d4;
border-radius: 51px;
padding: 5px 10px;
margin: 3px 1px;
background-color: #efeff2;
color: #636363;
}
.mylabel2{
display:inline-block;
postion:relative;
cursor:pointer;
-webkit-user-select:none;
-moz-user-select:none;
-ms-user-select:none;
border: 1px solid #d4d4d4;
border-radius: 51px;
padding: 5px 0px;
margin: 3px 1px;
background-color: #efeff2;
color: #636363;
font-size: 12px;
}
.line{
height:10px;
display:block;
content: "☆"
}
#topBtn,
#applyBtn{
position:fixed;
right:2%;
width:50px;
height:50px;
display:block;
color: #fff;
font-size:13px;
text-align:center;
border-radius:24px;
z-index:11;
box-shadow: 1px 3px 7px #a9a9a9;
}
#topBtn{
bottom:10px;
background: #000;
line-height:50px;
}
#applyBtn{
bottom: 70px;
background: #4098f4;
}
#applyBtn div{
padding: 9px;
}
.pagenumber a:link{
color:black;
}.pagenumber a:active{
color:black;
}.pagenumber a:hover{
color:black;
}.pagenumber a:visited{
color:black;
}
.pagenumber{
text-align:center;
font-size:20px;
float:left;
width:100%;
padding:30px 0;
}
input[type=submit] {-webkit-appearance:none;}
.slick-dots li button:before {
content:'.';
font-size:40px; /*33 50*/
color: white;
padding: 0;
text-shadow: -1px 0 0px #0000002e, 0 1px 0px #0000002e, 1px 0 0px #0000002e, 0 -1px 0px #0000002e;
}
.slick-dots li{
margin: 0;
width: 13px;
}
.slick-dots{
bottom: 17px; /*13 21*/
padding: 0;
}
.slick-dots li.slick-active button:before{
opacity: .85;
color: white;
}
.slick-prev:before, .slick-next:before{
font-size: 16px;
}
input#search {
    background: url(img/search_btn.png);
    background-repeat: no-repeat;
    width: 23px;
    height: 23px;
    border: 0;
    background-size: 23px 23px;
    right: 2%;
    display: inline-block;
    box-sizing: content-box;
    padding: 0;
    top: 54%;
    transform: translate(0, -50%);
    position: absolute;
}
#bdNm{
	height: 27px;
    width: 83%;
    border-radius: 15px;
    border: 1px solid #c3c3c3;
    padding: 7px 0px 7px 87px;
}
@media (max-width : 768px){
	#somun_logo{
	}
	#somun_search{
	left:0px;
	}
@media (max-width : 510px){
	.center{
		height: 220px;
	}
	.center_img{
		border:5px solid white;
	}
	.center_img div{
		height:200px;
	}
	#bdNm{
	font-size:9pt;
	width: 76%;
	padding-left:77px;
	}
	input#search{
	right: 6%;
	}
	#searcharea{
	width: 85%;
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
	input#search{
	right: 1%;
	}
}

</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>
<script>
//jQuery.noConflict();
</script>
<script>
    function slicky(a){
    	if( $(a).hasClass('slick-initialized') ){
    		$(a).slick('unslick');//슬릭해제

    		}
    	else{
    		$(a).slick({
    			  	lazyLoad: 'ondemand',
    			  	dots: true,
    				arrows:true,
    				//autoplay: true,
    				autoplaySpeed: 2000
    		});
    	}
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
<div id="container">
<div>
<span id="topBtn">top</span>
<span id="applyBtn"><div>상담<br>신청</div></span>
</div>
<script>
var topEle = $('#topBtn');
var delay = 1000;
topEle.on('click', function(){
	$('html, body').stop().animate({scrollTop:0}, delay);
})
</script>
<script>
var applyEle = $('#applyBtn');
applyEle.on('click', function(){
	location.href = "remodeling_form.jsp?item_num=0";
})
</script>

<div id="somun_navbar">
	<div id="somun_menu"></div>
	<div style="float:left;width:100%;height:max-content;margin-bottom:10px;text-align:center;">
	<div id="somun_logo"><a href="index.jsp"><img style="width:105px;"src="img/somunlogo.png"></a></div>
	<div style="margin:auto;width:max-content;color: #6d6d6d;font-size:10pt;">대구 리모델링 플랫폼</div>
	</div>
</div>
<div id="main">
	<div id="recommend">
		<div id="ref">소문 pick 추천 사례</div>
		<div class="center">
	<%
	//추천 사례 받아오기
	query = "select * from REMODELING where Root_area = -1 order by Number DESC LIMIT 1";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	String recitem[][] = new String[100][18];
	int i = 0;
	while(rs.next()){
		recitem[i][0] = rs.getString("Number");
		recitem[i][1] = rs.getString("Id");
		recitem[i][2] = rs.getString("Title");
		i++;
	}
	//out.println(pstmt);
	int recnum = i;
	//추천 사례 사진 받아오기
	for(i=0; i<recnum; i++){
    	pstmt = null;
    	query = "SELECT * FROM RMDL_IMG WHERE Number = ? order by Number2";
    	rs = null;
    	pstmt = conn.prepareStatement(query);
    	pstmt.setString(1, recitem[i][0]);
    	rs = pstmt.executeQuery();
    	while(rs.next()){
    		String imgstr = rs.getString("Path");
    		imgstr = imgstr.replaceAll("%", "%25");
    		%>
			<div><div class="center_img"><div>
			<a href = "_hit1.jsp?num=<%=recitem[i][0]%>" target="_self">
    		<img src="<%=imgstr%>" class="eotkd">
    		</a>
    		</div></div></div>
    		<%
    	}
    	%>
	<%
	}
	%>
			</div>
	</div>
	<form action="index.jsp" method="GET">

	</form>
	<div id="somun_search">
		<!-- div class = "search_item" id="search_item1">
			<input type="text" id="bdNm"  name="bdNm" placeholder = "아파트 명으로 찾기">
			<input type="submit" value="">
		</div-->
		<div class = "search_item" id="search_item2">
		<form action="index.jsp" method="GET">
		<%
		
		String[] request_areas = request.getParameterValues("Daegu");
		if(request_areas==null || request_areas[0].equals("undefined")){ 
			request_areas = new String[9];
			request_areas[0] = "all";
			}
		%>
		<!-- input type="radio" name="Daegu" id="all" value="all"><label for="all" class="mylabel">대구전체</label-->
		<div class="ajax_click">
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="jung-gu" value="141"<%if(Arrays.asList(request_areas).contains("141")) out.println("checked");%>><label for="jung-gu" class="mylabel">중구</label>
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="dong-gu" value="142"<%if(Arrays.asList(request_areas).contains("142")) out.println("checked");%>><label for="dong-gu" class="mylabel">동구</label>
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="seo-gu" value="143"<%if(Arrays.asList(request_areas).contains("143")) out.println("checked");%>><label for="seo-gu" class="mylabel">서구</label>
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="nam-gu" value="144"<%if(Arrays.asList(request_areas).contains("144")) out.println("checked");%>><label for="nam-gu" class="mylabel">남구</label>
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="buk-gu" value="145"<%if(Arrays.asList(request_areas).contains("145")) out.println("checked");%>><label for="buk-gu" class="mylabel">북구</label>
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="suseong-gu" value="146"<%if(Arrays.asList(request_areas).contains("146")) out.println("checked");%>><label for="suseong-gu" class="mylabel">수성구</label>
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="dalseo-gu" value="147"<%if(Arrays.asList(request_areas).contains("147")) out.println("checked");%>><label for="dalseo-gu" class="mylabel">달서구</label>
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="dalseong-gun" value="148"<%if(Arrays.asList(request_areas).contains("148")) out.println("checked");%>><label for="dalseong-gun" class="mylabel">달성군</label>
		<input class="area1" onClick="ajax_click(this)" type="radio" name="Daegu" id="kyeongbook" value="15"<%if(Arrays.asList(request_areas).contains("15")) out.println("checked");%>><label for="kyeongbook" class="mylabel">경북</label>
		<!-- input class="area1" onClick="ajax_click(this)" type="submit" class="mylabel" style="width:48px; padding: 7px 0px; font-size:15px;" value="검색"-->
		</div>
		<!--
		<div style="width: 100%;margin: auto auto;left: 5%;position: relative;">
		<div class="apartmen2" style="text-align: center; display: inline-block; width:79%; position: relative; float:left">
		<select name="Apart">
		<option class="apart" id="all" value="all">아파트 전체</option>
		<%
		String apartment = request.getParameter("Apart")+"";
		if(apartment == null || apartment.equals("null")){
			apartment = "";
			session.setAttribute("apartment", "");
		}
		else{
			session.setAttribute("apartment", apartment);
		}
		if(!(request_areas==null || request_areas[0].equals("undefined"))){
			if(request_areas[0].equals("15")){
				query = "Select distinct Apart_name from REMODELING where Root_area = ? order by Apart_name asc";
			}
			else{
				query = "Select distinct Apart_name from REMODELING where Second_area = ? order by Apart_name asc";
			}
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, request_areas[0]);
			rs=pstmt.executeQuery();
			while(rs.next()){
				String tempstr = rs.getString("Apart_name");
				%>
				<option class="apart" id="<%=tempstr%>" value="<%=tempstr%>"<%if(apartment.equals(tempstr)) out.println("selected");%>><%=tempstr%></option>
				<%
			}
		}
		%>
		</select>
		<div class="select__arrow"></div>
		</div>
		<input type="submit" id="search" name="submit" alt="search" value="">
		</div> -->
		</form>
		<script type="text/javascript">
		/*$(document).ready(function(){
			$(".mylabel").click(function(){
				alert("눌림");
				var areaArray = [];
				$('input[name="Daegu"]:checked').each(function(i){
					areaArray.push($(this).val());
				});
				$.ajax({
					url:'index.jsp',
					method:'post',
					//traditional : true,
					data: areaArray,
					success: function(data){
						alert("완료!");
					},
					error: function(jqXHR, textStatus, errorThrown){
						alert("에러발생 ~~\n" + textStatus + ":" + errorThrown);
					}
				})
				.done(function(result) {
	                $(".content").html(result);
	                function a (retVal){
						if(retVal.code == "OK"){
							alert(retVal.message);
						} else{
							alert(retVal.message);
						}
					}
	            })
	            alert("hmm");
			});

			
		})*/
		</script>
		<!-- 
			<div>
				<input type="button" id="jusobtn" class="btn" onClick="goPopup();" value="주소찾기"/>
				<%
					query = "Select * from ROOT_AREA";
					pstmt = conn.prepareStatement(query);
					rs=pstmt.executeQuery();
					
					while(rs.next()){
						String rootarea_name = rs.getString("Area_name");
						int rootarea_num = rs.getInt("Area_number");
						%>
						< option value="<%=rootarea_num%>"><%=rootarea_name%></option> >
						<button class="rootarea" value="<%=rootarea_num%>" onclick = "get_secondarea()"><%=rootarea_name%></button>
						<%
					}
				%>
				<script>
					function get_secondarea(){
						var e = window.event,
							btn = e.target || e.srcElement;
						alert(btn.value);
					}
				</script>
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
			 -->
		</div>

	</div>
    <div>
    <form id="form" name="form" method="POST" action="index.jsp">
      	<div id="searcharea">
			<input type="text" id="bdNm"  name="bdNm" placeholder="아파트명, 회사명으로 사례를 찾아보세요"/>
			<input type="button" onClick="goPopup();" value="주소찾기" id="jusobtn"/>
    		<input id="search" type="submit" value="">
		</div>
    
    <%String classes = "0"; %>
    	<input type="hidden" style="width:40px;height:30px;" id="building" name="building" />
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
    <div id="content" style="float:left;width:100%;margin:14px auto;">
    
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
<%
// 세션 생성 create session
session.setAttribute("page", "index.jsp"); // 현재 페이지 current page
// 세션 가져오기 get session
String pagenumstr = request.getParameter("pagenumstr")+"";
if(pagenumstr == null || pagenumstr.equals("null") || pagenumstr.equals("undefined")) pagenumstr = "1";
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";
String attr = request.getParameter("attr")+"";
String itemname = request.getParameter("itemname")+"";
String tag = request.getParameter("tag")+"";
%>
<%
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
if (xx != null && !xx.equals("")) x = Float.parseFloat(xx);
if (yy != null && !yy.equals("")) y = Float.parseFloat(yy);
pstmt = null;
query = "";
conn = DBUtil.getMySQLConnection();
rs = null;
String build = null;
build = request.getParameter("bdNm");
query = "Select * from REMODELING";

if(build != "" && build != null && !build.equals("all")){
	query += " where Apart_name Like \"%"+build+"%\"";
	query += " or Title Like \"%"+build+"%\"";
	query += " or Company Like \"%"+build+"%\"";
}

else if(request_areas != null && !request_areas[0].equals("all")){
	if(request_areas[0].equals("15")){
		query += " Where Root_area = " + request_areas[0];
	}
	else{
		query += " Where Second_area = " + request_areas[0];
	}
	for(i = 1; i < request_areas.length; i++){
		query += " Or Second_area = " + request_areas[i];
	} //147
	if(apartment != "" && apartment != null && !apartment.equals("all")){
		query += " And Apart_name Like \"%"+apartment+"%\"";
	}
}
//else if(request_areas == null){
	//query += " Where Second_area = 147";
//}
//else if(request_areas[0].equals("all")){
	//query += " Where Second_area = 147";
	//if(apartment != "" && apartment != null){
		//query += "Where Apart_name Like %"+apartment+"%";
	//}
//}
query += " order by Apart_name asc"; //limit 10
//out.println(query);
/*if(build != null && !build.equals("null")){
	query = "Select * from REMODELING where Building = ?";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, build);
}
else{*/
	pstmt = conn.prepareStatement(query);
//}
rs = pstmt.executeQuery();
String item[][] = new String[100000][18];
i = 0;
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
	item[i][17] = rs.getString("Hit");
	if(item[i][4].indexOf("남다른") == -1
			&& item[i][4].indexOf("이노") == -1
			&& item[i][4].indexOf("태웅") == -1
			&& item[i][4].indexOf("그레이") == -1
			&& item[i][4].indexOf("JYP") == -1
			&& item[i][4].indexOf("솔트") == -1
			&& item[i][4].indexOf("바르다") == -1
			&& item[i][4].indexOf("굿") == -1
			&& item[i][4].indexOf("AT") == -1)
		continue;
	//거리계산//item[i][12] = String.valueOf(Math.sqrt(((x-Float.parseFloat(item[i][10]))*(x-Float.parseFloat(item[i][10])))+((y-Float.parseFloat(item[i][9]))*(y-Float.parseFloat(item[i][9])))));
	//if(item[i][4].indexOf("오픈하우스") == -1) continue; 오픈하우스를 오픈함
	i++;
}
int itemnum = i;
//리모델링 사례 거리순정렬
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
	<!-- div style="width:100%;">
		<div style="margin:0 auto; width:max-content;">
		<label class="box-radio-input"><input type="radio" name="search_type"> <span>사례찾기</span></label>
		<label class="box-radio-input"><input type="radio" name="search_type"> <span>업체찾기</span></label>
		</div>
	</div-->
	
    <%
	if(s_id.equals("100"))
	{%>
		<div style="width:100%;text-align:center;"><a href="item_upload.jsp" target="_blank"><button style="width:150px;height:45px;margin:40px;border-radius:5px; background-color:#29aef2; color:white; font-size:17px; border:none;">사례등록  ></button></a></div>
	<%}%>
    <%
    //itemnum -> 아이템 개수
    //pageitemnum -> 페이지 총 개수
    //pagenum -> 현재 페이지
    int pageitemnum = 0;
    if(itemnum != 1) pageitemnum = ((itemnum-1)/20)+1;
    else pageitemnum = 1;
    
    int pagenum = Integer.parseInt(pagenumstr);

	%>
    
    <%
    //추천 사례들 먼저 정렬
    for(i=0; i<recnum; i++){
    	
    }
    
    int startnum; //시작하는 번호
    int endnum; //끝나는 번호
    if(pagenum == pageitemnum){ //현재페이지 == 페이지 총 개수
    	startnum = (20*pagenum)-20;
    	endnum = itemnum;
    }
    else{
    	startnum = (20*pagenum)-20;
    	endnum = 20*pagenum;
    }
    for(i=startnum; i<endnum; i++){
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
    		<a href = "_hit1.jsp?num=<%=item[i][0]%>" target="_self">
    		<img src="<%=rs.getString("Path").replaceAll("%25", "%").replaceAll("%", "%25")%>">
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
		<a href = "_hit1.jsp?num=<%=item[i][0]%>" target="_self">
		<div class="item">
		<div class="itemdiv">
		<%classes = Integer.toString(Integer.parseInt(classes)+1);%>
		<div style="font-size:10px;color:#999999"><%=item[i][4]%></div><!-- 닉넴 -->
    	<div style="font-size:14px;font-weight:bold;margin:8px 0;color:#3d3d3d"><%=item[i][2]%></div>
    	<div style="font-size:9px;color:#363636">조회수 <%=item[i][17]%></div>
    	<!-- div style="font-size:9px;color:#363636">스크랩 12개</div-->
    	<!-- div style="font-size:9px;margin:5px 0;">평당 <%=item[i][14]%>/시공기간 <%=item[i][15]%> 이상</div-->
    	<!-- 
    	<%
    	if(item[i][5] == null){
    		%><div style="font-size:19px;font-weight:bold;margin:25px 0 15px 0;color:#3d3d3d"><%=item[i][5]%>만원</div><%
    	}
    	%> -->
    	<!-- div style="font-size:10px;"><span style="border-radius:3px;padding:2px;color:white;background-color:orange"><%/*if(item[i][16].equals("1")) out.println("부분시공불가"); else out.println("부분시공가능");*/%></span></div-->
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
		<a href="remodeling_form.jsp?item_num=<%=item[i][0]%>"><div class="req_btn"></div></a>
		</div>
    	</div>
    	 </a>
    	<%
    }
    %>
    </div>
</div>
</div>
<div class="pagenumber"><%
	if(pageitemnum == 0){
		%>사례를 준비중 입니다.<%
	}
    if(pageitemnum == 1){ // 총 페이지 개수 :1
    	%>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
    	<%
    }
    else if(pageitemnum == 2){ // 총 페이지 개수 :2
    	if(pagenum == 1){
    		%>
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=2 -->
    		<%
    	}
    	else{
    		%>
        	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
        	<a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a> <!-- index.jsp?pagenumstr=2 -->
        	<%	
    	}
    }
    else if(pageitemnum == 3){ //총 페이지 개수 :3
    	if(pagenum == 1){
    		%>
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<%
    	}
    	else if(pagenum == 2){
    		%>
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<%
    	}
    	else{
    		%>
        	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3" style="color:blue;"><b>3</b></a> <!-- index.jsp?pagenumstr=2 -->
    		<%	
    	}
    }
    else if(pageitemnum == 4){//총 페이지 개수 :4
    	if(pagenum == 1){
    		%>
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
    		<%
    	}
    	else if(pagenum == 2){
    		%>
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
    		<%
    	}
    	else if(pagenum == 3){
    		%>
        	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3" style="color:blue;"><b>3</b></a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
    		<%	
    	}
    	else{
    		%>
        	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4" style="color:blue;"><b>4</b></a> <!-- index.jsp?pagenumstr=2 -->
    		<%	
    	}
    }
    else if(pageitemnum == 5){//총 페이지 개수 :5
    	if(pagenum == 1){
    		%>
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a> <!-- index.jsp?pagenumstr=2 -->
    		<%
    	}
    	else if(pagenum == 2){
    		%>
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a> <!-- index.jsp?pagenumstr=2 -->
    		<%
    	}
    	else if(pagenum == 3){
    		%>
        	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3" style="color:blue;"><b>3</b></a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a> <!-- index.jsp?pagenumstr=2 -->
    		<%	
    	}
    	else if(pagenum == 4){
    		%>
        	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4" style="color:blue;"><b>4</b></a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a> <!-- index.jsp?pagenumstr=2 -->
    		<%	
    	}
    	else{
    		%>
        	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a> <!-- index.jsp?pagenumstr=1 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a> <!-- index.jsp?pagenumstr=2 -->
    		<a class="pageidx" onClick="ajax_click(this)" href="#" title="5" style="color:blue;"><b>5</b></a> <!-- index.jsp?pagenumstr=2 -->
    		<%	
    	}
    }
  //전체 5페이지이상
    else if(pagenum == 1){//맨 앞%>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1" style="color:blue;"><b>1</b></a>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="2">2</a>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
    	<%
    }
    else if(pagenum == 2){//두번째%>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">이전</a>
		<a class="pageidx" onClick="ajax_click(this)" href="#" title="1">1</a>
		<a class="pageidx" onClick="ajax_click(this)" href="#" title="2" style="color:blue;"><b>2</b></a>
		<a class="pageidx" onClick="ajax_click(this)" href="#" title="3">3</a>
		<a class="pageidx" onClick="ajax_click(this)" href="#" title="4">4</a>
		<a class="pageidx" onClick="ajax_click(this)" href="#" title="5">5</a>
		<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
	<%
	}
    else if(pagenum == pageitemnum){ //맨 뒤
    	%>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>">이전</a>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-4%>"><%=pagenum-4%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-3%>"><%=pagenum-3%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-2%>"><%=pagenum-2%></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>"><%=pagenum-1%></a> <!-- index.jsp?pagenumstr=<%=pagenum+1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum%>" style="color:blue;"><b><%=pagenum%></b></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
    	<%
    }
    else if(pagenum == pageitemnum-1){ //맨 뒤에서 두번째
    	%>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>">이전</a>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-3%>"><%=pagenum-3%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-2%>"><%=pagenum-2%></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>"><%=pagenum-1%></a> <!-- index.jsp?pagenumstr=<%=pagenum+1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum%>" style="color:blue;"><b><%=pagenum%></b></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>"><%=pagenum+1%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
    	<%
    }
    else{ //중간
    	%>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>">이전</a>
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-2%>"><%=pagenum-2%></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum-1%>"><%=pagenum-1%></a> <!-- index.jsp?pagenumstr=<%=pagenum+1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum%>" style="color:blue;"><b><%=pagenum%></b></a> <!-- index.jsp?pagenumstr=<%=pagenum%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>"><%=pagenum+1%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+2%>"><%=pagenum+2%></a> <!-- index.jsp?pagenumstr=<%=pagenum-1%> -->
    	<a class="pageidx" onClick="ajax_click(this)" href="#" title="<%=pagenum+1%>">다음</a>
    	<%
    }
    %>
</div>

<%
pstmt.close();
rs.close();
query="";
conn.close();
%>
<!-- jsp:include page="footer.jsp" flush="false"/ -->
<script>
function ajax_click(obj){
	//alert('테스트 성공');
	var a = $(obj).attr("class");
	
	/*if(a=="pageidx"){
		alert("쪽수클릭");
		alert($(obj).attr("title")+"클릭");
	}
	else if(a == "area1"){
		alert("지역클릭");
		var id = $(obj).attr("id"); 
		if($(obj).is(":checked") == true){
			//alert("ON");
		}
		else
			alert("OFF");
	}*/
	/*var inputValue = $("input[name='Daegu']:checked").val(); //선택한지역번호
	$.ajax({
        url:'index.jsp',
        type: 'post',
        data: {
        	'pagenumstr':$(obj).attr("title"),
        	'Daegu':inputValue
        	},
        success : function(data){
            $("body").html(data);
        }
    });*/
    <%String ApArt = session.getAttribute("apartment") + "";%>
    var Daegu = $("input[name='Daegu']:checked").val();
    var pagenumber = $(obj).attr("title");
    var apartment = "<%=build%>";
    if(apartment == "null") apartment="";
    if(pagenumber == null) pagenumber=1;
    if(a=="pageidx"){
        location.href = "index.jsp?Daegu="+Daegu+"&pagenumstr="+pagenumber+"&bdNm="+apartment;
    }
    else{
    	 location.href = "index.jsp?Daegu="+Daegu+"&pagenumstr="+pagenumber;
    }
}
</script>
<script>
function frame(){
		var div = $(".center div"); // 이미지를 감싸는 div
		var img = $(".eotkd"); // 이미지
		var divWidth = div[0].offsetWidth
		var divHeight = div[0].offsetHeight-10;
		if(divWidth >= 510){
			divHeight -= 10;
			divWidth -= 120;
			//alert("넓");
		}
		else{
			divWidth -= 110;
			//alert("안넓");
		}
		var divAspect = divHeight / divWidth; // div의 가로세로비는 알고 있는 값이다 세로/가로
		//alert("divWidth : "+ divWidth);
		//alert("divHeight : " + divHeight);
		for(var i=0; i<img.length; i++){
			var imgAspect = img[i].height / img[i].width;
			if (imgAspect <= divAspect) {
		   	 	// 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
		    	var imgWidthActual = divHeight / imgAspect;
		    	var imgWidthToBe = divHeight / divAspect;
		    	var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2);
		    	img[i].style.cssText = 'width: auto; height: 100%; margin-left: '
		                      	+ marginLeft + 'px;';
		                      	//alert('납');
		                      	//alert('imgWidthToBe' + imgWidthToBe);
		                      	//alert('imgWidthActual' + imgWidthActual);
			} else {
		    	// 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
		    	var imgHeightActual = divWidth * imgAspect;
		    	var imgHeightToBe = divWidth * divAspect;
		    	//alert("imgHeightActual" + imgHeightActual);
		    	//alert("imgHeightToBe" + imgHeightToBe);
		    	var marginTop = -Math.round((imgHeightActual - imgHeightToBe) / 2);
		    	img[i].style.cssText = 'width: 100%; height: auto; margin-left: 0; margin-top: '
		                      	+ marginTop + 'px;';
		                      	//alert("길");
			}
		}
}

$(window).resize(function(){
	frame()
});
$(document).ready(function(){
	frame()
});

</script>
<script>
$(document).ready(function(){
	$('.center').slick({
		  centerMode: true,
		  centerPadding: '50px',
		  slidesToShow: 1,
		  autoplay: true,
		  autoplaySpeed: 3000,
	      arrows: false
		});
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
</body>
</html>