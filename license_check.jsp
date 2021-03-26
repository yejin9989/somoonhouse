<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "lisence_check.jsp"); %>
<%
//DB에 사용 할 객체들 정의
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
Statement stmt = null;
String query = "";
String sql = "";
ResultSet rs = null;

//세션 생성 create session
session.setAttribute("page", "lisence_check.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

query = "select * from BUSINESS_LICENSE";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
%>
<%!
public class Company{
	String company_id;
	String apply_id;
	String name;
	String license_img;
	String state;
	String state_str;
	String reason;
	public Company(String company_id, String apply_id, String name, String license_img, String state, String state_str, String reason){
		this.company_id = company_id;
		this.apply_id = apply_id;
		this.name = name;
		this.license_img = license_img;
		this.state = state;
		this.state_str = state_str;
		this.reason = reason;
	}
	public String getCompanyId(){
		return company_id;
	}
	public String getApplyId(){
		return apply_id;
	}
	public String getName(){
		return name;
	}
	public String getLicenseImg(){
		return license_img;
	}
	public String getState(){
		return state;
	}
	public String getStateStr(){
		return state_str;
	}
	public String getReason(){
		return reason;
	}
	public void setStateReason(String state, String reason){
		this.state = state;
		this.reason = reason;
	}
	public void updateStateReason(){
		try{
			Connection c_conn = DBUtil.getMySQLConnection();
			PreparedStatement c_pstmt;
			String c_sql = "UPDATE BUSINESS_LICENSE SET Status = ?, Reason = ? ";
			c_sql += "WHERE Apply_id = ? ";
			c_pstmt = c_conn.prepareStatement(c_sql);
			c_pstmt.executeUpdate();
		}
		catch(SQLException ex){
		}
	}
}
%>
<%

LinkedList<Company> company_list = new LinkedList<Company>();

while(rs.next()){ //BL : Business License

	String company_id = rs.getString("Company_id");
	String apply_id = rs.getString("Apply_id");
	String company_name = "";
	String license_img = rs.getString("License_img");
	String state = rs.getString("Status");
	String state_str = "";
	String reason = rs.getString("Reason");
	
	//id를 바탕으로 회사 이름 가져오기
	PreparedStatement pstmt_name;
	String query_name = "select Name from COMPANY where Id = ?";
	pstmt_name = conn.prepareStatement(query_name);
	pstmt_name.setString(1, company_id);
	ResultSet rs_name = pstmt_name.executeQuery();
	while(rs_name.next()){
		company_name = rs_name.getString("Name");
	}
	
	//state 0:대기 1:승인 2:반려
	switch(state){
	case "0" :
		state_str = "대기";
		break;
	case "1" :
		state_str = "승인";
		break;
	case "2" :
		state_str = "반려";
		break;
	}
	
	Company temp_company = new Company(company_id, apply_id, company_name, license_img, state, state_str, reason);
	
	company_list.add(temp_company);
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
<link rel="stylesheet" type="text/css" href="css/company_home.css">
<link rel="stylesheet" type="text/css" href="css/license_check.css">
<style type="text/css">

</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>소문난집</title>
</head>
<body>
	<div id="container">
		<h2>📋 사업자 등록증 목록 (상태별 정렬 / 시간별 정렬)</h2>
		<table>
			<thead>
				<tr>
					<td>no. ▼</td>
					<td>회사이름</td>
					<td>상태 </td>
					<td>사진확인 </td>
				</tr>
			</thead>
			<tbody>
			<% 
				for(Company com : company_list){
					%>
					<tr class="apply-list" id="com<%=com.getApplyId()%>">
						<td><%=com.getApplyId()%></td>
						<td><%=com.getName()%></td>
						<td><div class="status stt<%=com.getState()%>" id="stt<%=com.getApplyId()%>"><%=com.getStateStr()%></div></td>
						<td><a href="#">확인</a></td>
					</tr>
					<%
				}
			%>
			</tbody>
		</table>
			<% 
				for(Company com : company_list){
					%>
					<div class="blank" id="blank<%=com.getApplyId()%>">
						<div class="close">X</div>
						<div class="license-img-area" style="background:url('<%=com.getLicenseImg()%>');background-size:300px 400px;"></div>
						<div class="com-title"><%=com.getName()%></div>
						<div>
							<textarea id="textarea<%=com.getApplyId()%>"><%=com.getReason()%></textarea>
						</div>
						<div class="ok">승인</div>
						<div class="cancel">반려</div>
					</div>
					<%
				}
			%>
	</div>
<%
//DB개체 정리
pstmt.close();
rs.close();
query="";
conn.close();
%>
<script>
$(".apply-list").click(function(){
	var div_id = $(this).attr('id');
	var apply_id = div_id.replace("com", "");
	var blank = $('#blank'+apply_id);
	blank.css("display", "block");
})
$(".close").click(function(){
	$(this).parent().css("display", "none");
})
$(".ok").click(function(){
	var div_id = $(this).parent().attr('id');
	var apply_id = div_id.replace("blank", "");
	$.ajax({
		type : "POST",
		url : "_license_update.jsp",
		data : {
			state : 1,
			reason : "승인 되었습니다.",
			apply_id : apply_id
		},
		dataType : "html",
		error: function(){
			alert("실패했습니다.");
		},
		success : function(res){
			alert("승인되었습니다.");
			console.log(res);
		}
	})
	//승인으로 고치기 -> class = "status stt1", html -> 승인
	var stt = $("#stt"+apply_id);
	stt.html("승인");
	stt.attr('class', 'status stt1');
	//display:none
	$(this).parent().css("display", "none");
})
$(".cancel").click(function(){
	var div_id = $(this).parent().attr('id');
	var apply_id = div_id.replace("blank", "");
	var reason = $("#textarea"+apply_id).val();
	$.ajax({
		type : "POST",
		url : "_license_update.jsp",
		data : {
			state : 2,
			reason : reason,
			apply_id : apply_id
		},
		dataType : "html",
		error: function(){
			alert("실패했습니다.");
		},
		success : function(res){
			alert("반려되었습니다.");
			console.log(res);
		}
	})
	
	//반려로 고치기 -> class = "status stt2", html -> 반려
	var stt = $("#stt"+apply_id);
	stt.html("반려");
	stt.attr('class', 'status stt2');
	//display:none
	$(this).parent().css("display", "none");
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