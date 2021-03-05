<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "delete_ability.jsp"); %>
<%
//DB에 사용 할 객체들 정의
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
Statement stmt = null;
String query = "";
String sql = "";
ResultSet rs = null;

//세션 생성 create session
session.setAttribute("page", "delete_ability.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

String company_id = request.getParameter("company");
company_id = "1";
String ability_id = request.getParameter("ability_id");

query = "delete from SPECIALIZED where Company_num = ? and Ability_num = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_id);
pstmt.setString(2, ability_id);
pstmt.executeUpdate();
%>

<!DOCTYPE html>
<html>
<head>
<title>소문난집</title>
</head>
<body>
<%
//DB개체 정리
/*
pstmt.close();
rs.close();
query="";
conn.close();
*/
%>
</body>
</html>