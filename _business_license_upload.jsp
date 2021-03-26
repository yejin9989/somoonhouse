<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Calendar,java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page language="java" import="myPackage.DBUtil" %>
<%@ page language="java" import="myPackage.Link" %> 
<%@ page language="java" import="myPackage.GetImage" %> 
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<%
	String company_id = session.getAttribute("s_id")+"";
	String file1 = "";
	String realFolder = "";
	String filename1 = "";
	int maxSize = 1024*1024*5;
	String encType = "UTF-8";
	String savefile = "otherimg";
	ServletContext scontext = getServletContext();
	realFolder = scontext.getRealPath(savefile);
	 
	Connection conn = DBUtil.getMySQLConnection();
	try{
		MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration<?> files = multi.getFileNames();
			file1 = (String)files.nextElement();
			filename1 = multi.getFilesystemName(file1);
		 } catch(Exception e) {
		 	e.printStackTrace();
		 }

	if(filename1 != null)
			file1 = "otherimg" + "/" + filename1;
	out.println("filename : " + file1 + "\n");
	
	PreparedStatement pstmt = null;
	String sql = "insert into BUSINESS_LICENSE (Company_id, License_img) value(?, ?)";
	// 사업자등록증 컬럼 Business_license_img에 지금 등록된 사진파일을 넣겠다.
	// Id는 현재 로그인된 회사 아이디에
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, company_id);
	pstmt.setString(2, file1);
	pstmt.executeUpdate();
	out.println(pstmt);
	pstmt.close();
	conn.close();
	%>
	<script>
	alert('등록을 완료했습니다.');
	self.close();
	</script>
</head>
<body>
</body>
</html>