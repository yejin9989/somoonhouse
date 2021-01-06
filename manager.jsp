<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar" %>
<%@ page language="java" import="myPackage.*" %> 
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<%
	Connection conn = DBUtil.getMySQLConnection();
	ResultSet rs = null;
	Statement stmt = null;
	String query = "select * from ADMIN";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(query);
	String pw = "";
	while(rs.next()){
		pw = rs.getString("Pw");
	}
	String guestpw = request.getParameter("pw");
	////////
	conn.close();
	rs.close();
	stmt.close();
	if(true){
		session.setAttribute("page", "");
		session.setAttribute("s_id", "100");
		response.sendRedirect("index.jsp");
	}
	else{
		session.setAttribute("page", "");
		session.setAttribute("s_id", "100");
		response.sendRedirect("index.jsp");
	}
%>
</body>
</html>