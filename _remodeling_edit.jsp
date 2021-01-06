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
	String now = "_remodeling.jsp";
	String url = "";
 	String roadAddrPart1 = "";
	String bdNm = "";
	String building = "";
	String title = "";
	String content = "";
	String company = "";
	String fee = "";
	String etc = "";
	String entX = "";
	String entY = "";
	String price_area = "";
	String period = "";
	String part = "";
	String file1[] = new String[10];
	request.setCharacterEncoding("UTF-8");
	 String realFolder = "";
	 String filename1 = "";
	 int maxSize = 1024*1024*5;
	 String encType = "UTF-8";
	 String savefile = "img";
	 ServletContext scontext = getServletContext();
	 realFolder = scontext.getRealPath(savefile);
	 
	Connection conn = DBUtil.getMySQLConnection();
	try{
		  MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		 	url = multi.getParameter("url")+"";
		 	if(url.equals("")) url = null;
		 	roadAddrPart1 = multi.getParameter("roadAddrPart1")+"";
		 	if(roadAddrPart1.equals("")) roadAddrPart1 = null;
			bdNm = multi.getParameter("bdNm")+"";
			if(bdNm.equals("")) bdNm = null;
			building = multi.getParameter("building")+"";
			if(building.equals("")) building = null;
			title = multi.getParameter("title")+"";
			if(title.equals("")) title = null;
			content = multi.getParameter("content")+"";
			if(content.equals("")) content = null;
			company = multi.getParameter("company")+"";
			if(company.equals("")) company = null;
			fee = multi.getParameter("fee")+"";
			if(fee.equals("")) fee = null;
			etc = multi.getParameter("etc")+"";
			if(etc.equals("")) etc = null;
			entX = multi.getParameter("entX")+"";
			if(entX.equals("")) entX = null;
			entY = multi.getParameter("entY")+"";
			if(entY.equals("")) entY = null;
			price_area = multi.getParameter("price_area")+"";
			if(price_area.equals("")) price_area = null;
			period = multi.getParameter("period")+"";
			if(period.equals("")) period = null;
			part = multi.getParameter("part")+"";
			if(part.equals("")) part = null;
			
		  Enumeration<?> files = multi.getFileNames();
		     file1[0] = (String)files.nextElement();
		     filename1 = multi.getFilesystemName(file1[0]);
		 } catch(Exception e) {
		  e.printStackTrace();
		 }
	int error=0;
	if((title==null || filename1==null) && url.equals("")){
		%><script>alert("제목,사진과 url중 하나를 입력해주시길 바랍니다"); window,history.back();</script><%
		error++;
	}
	else if(title==null || filename1==null){
		//이전 링크와 같은지 확인
		String prevlink="";
		String sql="select * from REMODELING where Number = ?";
		PreparedStatement pstmt = null;
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, num);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			prevlink = rs.getString("URL");
		}
		if(!prevlink.equals(url)){  //같지않다면 이미지 삭제 후 새로운 이미지 다운
			out.println(prevlink);
			out.println(url);
			//이미지 삭제
			//전 이미지 명들 가져오기
			String[] previmgs = {"", "", "", "", "", "", "", "", "", ""};
			sql = "select * from RMDL_IMG where Number = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			int i = 0;
			while(rs.next()){
				previmgs[i] = rs.getString("Path");
				i++;
				if(i==10) break;
			}
			//이미지들 다 삭제
			for(i=0; i<previmgs.length; ){
				if(previmgs[i] == null) break;
				previmgs[i] = previmgs[i].replace("%25", "%");
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
				i++;
				if(i >= 10) break;
				if(previmgs[i] == null) break;
			}
			sql = "delete from RMDL_IMG where Number = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
			out.println(pstmt);
			//새로운링크
			Link MyLink = new Link(url);
			if(title.equals("NULL")){
				title = MyLink.getTitle();
			}
			if(filename1 == null){
				file1 = MyLink.getImg();
			}
			
			//사진 넣기
			sql = "SELECT MAX(Number) FROM REMODELING";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			for(i=0;i<file1.length;){
				sql = "Insert into RMDL_IMG values(?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(num));
				pstmt.setInt(2, i);
				if(file1[i] != null) file1[i] = file1[i].replace("%", "%25");
				pstmt.setString(3, file1[i]);
				if(error == 0){
					pstmt.executeUpdate();
				}
				out.println(pstmt);
				i++;
				if(i >= 10) break;
				if(file1[i] == null) break;
			}
		}
	}

	if(filename1 != null){
			file1[0] = "img" + "/" + filename1;
			String sql = "Delete from RMDL_IMG where Number = ? AND Number2 = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			pstmt.setInt(2, 0);
			if(error == 0){
				pstmt.executeUpdate();
			}
			sql = "Insert into RMDL_IMG values(?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			pstmt.setInt(2, 0);
			pstmt.setString(3, file1[0]);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			pstmt.setInt(2, 0);
			pstmt.setString(3, file1[0]);
			if(error == 0){
				pstmt.executeUpdate();
			}
	}
	
	String sql = "Update REMODELING set Title=?, Company=?, Fee=?, Address=?, Apart_name=?, Building=?, Xpos=?, Ypos=?, Etc=?, Content=?, URL=?, Price_area=?, Period=?, Part=? where Number = ?";	
	PreparedStatement pstmt = null;
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, company);
	pstmt.setString(3, fee);
	pstmt.setString(4, roadAddrPart1);
	pstmt.setString(5, bdNm);
	pstmt.setString(6, building);
	pstmt.setString(7, entX);
	pstmt.setString(8, entY);
	pstmt.setString(9, etc);
	pstmt.setString(10, content);
	pstmt.setString(11, url);
	pstmt.setString(12, price_area);
	pstmt.setString(13, period);
	pstmt.setString(14, part);
	pstmt.setString(15, num);

	if(error == 0){
		pstmt.executeUpdate();
	}
	
	
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