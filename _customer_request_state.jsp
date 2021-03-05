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
session.setAttribute("page", "_customer_request_state.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

//apply번호, 회사번호, 상태받아오기
String apply_num = request.getParameter("apply_num");
String state = request.getParameter("state");

//해당 신청내역 상태 업데이트하기
query = "Update ASSIGNED set State = 7 where Apply_num = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, apply_num);
pstmt.executeUpdate();
query = "Update REMODELING_APPLY set State = 4 where Number = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, apply_num);
pstmt.executeUpdate();
%>

<!DOCTYPE html>
<html>
<head>
</head>
<body>
<%=pstmt %>
<script>
window.onload = function(){
	history.back(-1);
}
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
<%
//DB개체 정리
/*
pstmt.close();
rs.close();
query="";
conn.close();
*/
%>