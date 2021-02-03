<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
  
  <%
  	int error = 0;

  	String id = request.getParameter("id");
  	String pw = request.getParameter("pw");
	Connection conn = DBUtil.getMySQLConnection();
  	PreparedStatement pstmt = null;
  	ResultSet rs = null;
  	String query = "Select * from USERS where SITE_ID = ? and PW = password(?)";
  	pstmt = conn.prepareStatement(query);
  	pstmt.setString(1, id);
  	pstmt.setString(2, pw);
  	rs = pstmt.executeQuery();
  	String name = null;
  	String s_id = null;
  	while(rs.next()){
  		name = rs.getString("USERNAME");
  		s_id = rs.getString("ID");
  	}
  	if(s_id == null){
  		error++;
  	}
  %>
  
<script>
	if("<%=error%>" == "0"){
		confirm("<%=name%>님 환영합니다.");
		location.href="index.jsp";
	}
	else{
		alert("아이디와 비밀번호를 확인해주세요.");
		history.back();
	}
</script>