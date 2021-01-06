<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" import="myPackage.DBUtil" %> 
<%@ page language="java" import="myPackage.Link" %> 
<%@ page language="java" import="myPackage.GetImage" %>
<%@ page language="java" import="java.io.File"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<%
	String num = request.getParameter("num")+"";
	String id = session.getAttribute("s_id")+"";
	String now = "_dropremodeling.jsp";
	 
	Connection conn = DBUtil.getMySQLConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 서버 이미지 삭제
	String[] previmgs = {"", "", "", "", "", "", "", "", "", ""};
	String sql = "select * from RMDL_IMG where Number = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, num);
	rs = pstmt.executeQuery();
	int i = 0;
	while(rs.next()){
		previmgs[i] = rs.getString("Path");
		i++;
		if(i==10) break;
	}
	out.println("number : "+ num);
	//이미지들 다 삭제
	for(i=0; i<previmgs.length; i++){
		File file = new File("/somunhouse/tomcat/webapps/ROOT/"+previmgs[i]); 
		if(file.exists()) {
			if(file.delete()){ 
				out.println("파일삭제 성공"+i+"번째 : " + previmgs[i]); 
				}
			else {
				out.println("파일삭제 실패"+i+"번째: " + previmgs[i]); 
				}
			}
		else {
			out.println("파일이 존재하지 않습니다."+i+"번째: " + previmgs[i]);
			}
	}
	//디비 삭제
	for(i=0; i<previmgs.length; i++){
		sql = "delete from RMDL_IMG where Path = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, previmgs[i]);
		pstmt.executeUpdate();
	}
	
	sql = "Delete from REMODELING where Number = ?";
	pstmt = null;
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, num);
	pstmt.executeUpdate();
	pstmt.close();
	conn.close();
	%>
	<script>
	alert('삭제를 완료했습니다.');
	//self.close();
	</script>
</head>
<body>
</body>
</html>