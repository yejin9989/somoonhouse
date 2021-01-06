<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "_hit1.jsp"); %>
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
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title></title>
</head>
<body>
<div style="
    background: pink;
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
">
    <div style="
    background: white;
    width: 100%;
    position: absolute;
    height: 90%;
    bottom: 0;
    margin: 0 auto;
    border-radius: 10px;
    box-shadow: 1px -1px 13px 0px #0000002e;
">
<div style="
    font-size: 33pt;
    position: absolute;
    top: -1%;
    right: 4%;
    color: #626262;
">
    x
    </div>

<div style="
    position: absolute;
    height: 93%;
    width: 100%;
    background: aquamarine;
    bottom: 0;
">
    <iframe src="https://www.youtube.com/watch?v=87LxaCjapsE"
    id = "output_iframe_id"
    style="
    	width: 100%;
    	height: 100%;
    	position: absolute;
    	border: 0;
    ">
    </iframe>
</div>
</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</html>
