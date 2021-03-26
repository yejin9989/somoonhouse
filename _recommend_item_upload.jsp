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
        String id = session.getAttribute("s_id")+"";
        String file1[] = new String[10];
        String url = "";
        String title = "";
        request.setCharacterEncoding("UTF-8");
        String realFolder = "";
        String filename1 = "";
        int maxSize = 1024*1024*5;
        String encType = "UTF-8";
        String saveFile = "img";
        ServletContext sContext = getServletContext();
        realFolder = sContext.getRealPath(saveFile);

        Connection conn = DBUtil.getMySQLConnection();
        try{
            MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
            url = multi.getParameter("url")+"";
            if(url.equals("")) url = "NULL";
            title = multi.getParameter("title")+"";
            if(title.equals("")) title = "NULL";
            Enumeration<?> files = multi.getFileNames();
            file1[0] = (String)files.nextElement();
            filename1 = multi.getFilesystemName(file1[0]);
        } catch(Exception e) {
            e.printStackTrace();
        }
        int error=0;
        if(title.equals("NULL") || filename1 == null || url.equals("NULL") || url.equals("")){
            %><script>alert("제목,사진과 url중 하나를 입력해주시길 바랍니다"); window,history.back();</script><%
            error++;
        }
        else if(title.equals("NULL") || filename1 == null){
            Link MyLink = new Link(url);
            out.println("url: "+url);
            if(title.equals("NULL")){
                title = MyLink.getTitle();
                out.println("제목이없어요");
            }
            if(filename1 == null){
                file1 = MyLink.getImg();
                out.println("파일이없어요\n");
            }
        }

        if(filename1 != null)
            file1[0] = "img" + "/" + filename1;
    //    out.println("filename : " + file1[0] + "\n");
    if(error == 0) {
        String sql = "INSERT INTO RECOMMEND VALUES(Default, ?, Default, Default, Default, ?, ?)";
        PreparedStatement pstmt = null;
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, url);
        pstmt.setString(3, file1[0]);
        pstmt.executeUpdate();
        pstmt.close();
%>
    <script>
        alert('등록을 완료했습니다.');
        window,close();
    </script>
    <%
        }
        conn.close();
    %>
</head>
<body>
</body>
</html>