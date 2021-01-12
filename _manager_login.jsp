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
	String id = "";
	String guestpw = request.getParameter("password");
	String query = "";
	
	if(guestpw != null){
		Connection conn = DBUtil.getMySQLConnection();
		ResultSet rs = null;
		Statement stmt = null;
		query = "select * from ADMIN where Pw = password(\"" + guestpw + "\")";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		id = "";
		while(rs.next()){
			id = rs.getString("Id");
		}
		conn.close();
		rs.close();
		stmt.close();
	}
	if(id.equals("admin")){ //비밀번호 맞음
		session.setAttribute("page", "");
		session.setAttribute("s_id", "100");
	}
	else{
		session.setAttribute("page", "");
		session.setAttribute("s_id", "");
	}
%>
<script>
	window.onload = function(){
		if("<%=guestpw%>" == ""){
			alert("비밀번호를 입력해주세요");
			history.back(-1);
		}
		else if("<%=id%>" == "admin"){
			location.href = "manager.jsp";
		}
		else{
			alert("비밀번호가 틀립니다");
			history.back(-1);
		}
	}
</script>
</body>
</html>