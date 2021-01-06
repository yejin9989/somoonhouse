<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.security.SecureRandom" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<script>alert("로그아웃 되었습니다!")</script>
<%
		session.setAttribute("page", "");
		session.setAttribute("s_id", "");
		session.setAttribute("name", "");
		response.sendRedirect("index.jsp");
%>