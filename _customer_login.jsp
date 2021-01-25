<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*,java.security.*,java.math.BigInteger" %>
<%@ page language="java" import="myPackage.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<% session.setAttribute("page", "_customer_login.jsp"); %>
<%

/*로그인된 세션 아이디(추후개발) 가져오기, 현재 페이지 저장
String id = session.getAttribute("s_id")+"";
String now = "_remodeling_form.jsp";*/

//DB에 사용 할 객체들 정의
Connection conn = DBUtil.getMySQLConnection();
PreparedStatement pstmt = null;
Statement stmt = null;
String query = "";
String sql = "";
ResultSet rs = null;

//세션 생성 create session
//session.setAttribute("page", "remodeling_request.jsp"); // 현재 페이지 current page
//세션 가져오기 get session
String now = session.getAttribute("page")+""; // 현재 페이지 current page
String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
String name = session.getAttribute("name")+"";

//로그인 할 회사번호, 비밀번호 받아오기
String customer_num = request.getParameter("customer_num");
String pw = request.getParameter("password");

//해당 아디비번 매치하는지 확인
String customer_name = null;

if(pw != null){
	query = "select * from REMODELING_APPLY where Number = ? and Pw = password(?)";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, customer_num);
	pstmt.setString(2, pw);
	rs = pstmt.executeQuery();
	while(rs.next()){
		customer_name = rs.getString("Name");
	}
	//일치하는 회원정보가 있을 시
	if(customer_name != null){
		//세션설정
		session.setAttribute("s_id", "cu"+customer_num);
		session.setAttribute("name", customer_name);
		
		//개인페이지로
		response.sendRedirect("https://somoonhouse.com/customer_request.jsp");
	}
}
//DB개체 정리
/*
pstmt.close();
rs.close();
query="";
conn.close();
*/
%>
<script>
window.onload = function() {
	if("<%=pw%>" == ""){
		alert("비밀번호를 입력해주세요!");
		history.back();
	}
	else if("<%=customer_name%>"" == null){
		alert("일치하는 회원정보가 없습니다.");
		history.back();
	}
};
</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "3602e31fd32c7e";
wcs_do();
</script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</div>
</body>
</html>