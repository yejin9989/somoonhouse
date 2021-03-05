<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "remodeling_form.jsp"); %>
<%
//DB에 사용 할 객체들 정의
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
Statement stmt = null;
String query = "";
String sql = "";
ResultSet rs = null;

//세션 생성 create session
session.setAttribute("page", "_company_edit.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

String company_id = request.getParameter("company");
company_id = "1";

String as_provide = request.getParameter("as_provide");
String company_area = request.getParameter("company_area");
String company_as_warranty = request.getParameter("company_as_warranty");
String company_as_fee = request.getParameter("company_as_fee");
String company_career = request.getParameter("company_career");
String[] company_abilities = request.getParameterValues("tag");
//ArrayList<String> company_abilities = new ArrayList<String>();
String company_introduction = request.getParameter("company_introduction");

//A/S제공여부 boolean처리
String company_as_provide = "";
if(as_provide == null)
	company_as_provide = "1";
else
	company_as_provide = "0";
//소개글 줄 바꿈 대치 시켜야함
company_introduction = company_introduction.replace("\n", "<br>");

query = "update COMPANY set Address=?, Career=?, Introduction=?, As_warranty=?, As_fee=?, As_provide = ? where Id = ?";
pstmt = conn.prepareStatement(query);
pstmt.setString(1, company_area);
pstmt.setString(2, company_career);
pstmt.setString(3, company_introduction);
pstmt.setString(4, company_as_warranty);
pstmt.setString(5, company_as_fee);
pstmt.setString(6, company_as_provide);
pstmt.setString(7, company_id);
pstmt.executeUpdate();

//태그 처리
//태그가 있는 경우
if(company_abilities != null){
	int i =0;
	for(i=0; i<company_abilities.length; i++){
		//company_abilities 테이블에 있는지 확인 후, 없으면 넣기.
		//specialized에 해당 능력 넣기.
		query = "select Id from COMPANY_ABILITIES where Title = ?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, company_abilities[i]);
		rs = pstmt.executeQuery();
		String ability_id = null;
		while(rs.next()){
			ability_id = rs.getString("Id");
		}
		if(ability_id == null){
			query = "insert into COMPANY_ABILITIES values(?, default)";	
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, company_abilities[i]);
			pstmt.executeUpdate();
			//방금 넣은 거 찾기..
			query = "select Id from COMPANY_ABILITIES where Title = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, company_abilities[i]);
			rs = pstmt.executeQuery();
			ability_id = null;
			while(rs.next()){
				ability_id = rs.getString("Id");
			}
		}
	
		//specialized에 해당 능력 넣기
		query = "insert into SPECIALIZED values(?, ?)";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, company_id);
		pstmt.setString(2, ability_id);
		pstmt.executeUpdate();
	}
}
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