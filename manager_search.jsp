<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "remodeling_form.jsp"); %>
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
.item{
height: 200px;
width: 100%;
padding-bottom:20px;
}
.itemdiv{
height:200px;
}
h1{
font-size:20pt;
text-align:center;
padding: 20px;
}
form{
display:inline-block
}
#search{
margin:auto;
width:100%;
text-align:center;
}
#search_result{
    width: 60%;
    margin: auto;
    text-align: center;
    font-size: 10pt;
    padding: 24px 0;
}
</style>
<%
PreparedStatement pstmt = null;
String query = "";
Connection conn = DBUtil.getMySQLConnection();
ResultSet rs = null;
String build = null;
String apartment = request.getParameter("bdNm");
query = "Select * from REMODELING";
int i = 0;
int itemnum = 0;
String item[][] = new String[10000][18];
if(apartment != null){
	query += " Where Apart_name Like \"%"+apartment+"%\"";

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
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
				&& item[i][4].indexOf("썬") == -1
				&& item[i][4].indexOf("굿") == -1)
			continue;
		i++;	
	}
	itemnum = i;
}
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>
</head>
<body>
<h1>사례링크찾기</h1>
<div id="search">
<span>아파트이름검색</span>
<form action="manager_search.jsp" method="POST">
	<input name="bdNm" type="text">
	<input type="submit">
</form>
</div>
<div id="search_result">
<%
String classes = "0";
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
		<a href = "_hit.jsp?num=<%=item[i][0]%>" target="_self">
		<img src="<%=rs.getString("Path")%>">
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
	<div class="itemdiv">
	<%classes = Integer.toString(Integer.parseInt(classes)+1);%>
	<div style="font-size:10px;color:#999999"><%=item[i][4]%></div><!-- 닉넴 -->
	<div style="font-size:14px;font-weight:bold;margin:8px 0;color:#3d3d3d"><%=item[i][2]%></div>
	<div>주소 <%=item[i][6]%></div>
	<div>신청폼링크 https://somoonhouse.com/remodeling_form.jsp?item_num=<%=item[i][0]%></div>
	<a href = "_hit.jsp?num=<%=item[i][0]%>" target="_self">블로그원문보기</a>
	<!-- div style="font-size:10px;"><span style="border-radius:3px;padding:2px;color:white;background-color:orange"><%/*if(item[i][16].equals("1")) out.println("부분시공불가"); else out.println("부분시공가능");*/%></span></div-->
	<!-- div>
	<h2 style="padding:20px;line-height:1.5em;"><%=item[i][2]%></h2>
	작성일시 : <%=item[i][3]%><br> 
	시공사 : <%=item[i][4]%><br> 
	시공비용 : <%=item[i][5]%><br>
	상세주소 : <br>
	<%=item[i][7]%>
	<%=item[i][8]%> 동<br>
	거리 : <%=item[i][12] %><br>
item[i][14] = rs.getString("Price_area");
item[i][15] = rs.getString("Period");
item[i][16] = rs.getString("Part");
	</div-->
	</div>
	<%
}
%>
</div>
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
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</body>
</html>