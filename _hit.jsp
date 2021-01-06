<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "_hit.jsp"); %>
<%
int num = Integer.parseInt(request.getParameter("num"));
Connection conn = DBUtil.getMySQLConnection();
ResultSet rs = null;
PreparedStatement pstmt = null;
String query = "";

query = "update REMODELING set Hit = Hit + 1 where Number = ?";
pstmt = conn.prepareStatement(query);
pstmt.setInt(1, num);
pstmt.executeUpdate();

query = "select * from REMODELING where Number = ?";
pstmt = conn.prepareStatement(query);
pstmt.setInt(1, num);
rs = pstmt.executeQuery();
String URL = "";

while(rs.next()){
	URL = rs.getString("URL");
}
%>


<script>
window.onload = function(){
    location.href = "<%=URL%>";
}
</script>
