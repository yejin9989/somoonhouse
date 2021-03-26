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
        // 세션의 company_id 가져오기
        String company_id = session.getAttribute("s_id")+"";

        // 파라미터
        String type = "";
        String type_etc = "";
        String date = "";
        String file1 = "";
        String filename1 = "";

        // multipartRequest 설정
        int maxSize = 1024*1024*5;
        String encType = "UTF-8";

        // 파일이 저장될 서버의 실제 폴더 경로. ServletContext 이용
        String realFolder = "";

        // webApp 상의 폴더명. 이 폴더에 해당하는 실제 경로 찾아 realFolder 로 매핑시킴
        String saveFile = "img";

        ServletContext sContext = getServletContext();
        realFolder = sContext.getRealPath(saveFile);

        // DB connection
        Connection conn = DBUtil.getMySQLConnection();

        try{
            // upload
            MultipartRequest multi = null;
            multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

            // get inputs
            type = multi.getParameter("type")+"";
            if(type.equals("")) type = "NULL";
            if(type.equals("0")) {
                type_etc = multi.getParameter("type-etc") + "";
                if (type_etc.equals("")) type_etc = "NULL";
            }
            date = multi.getParameter("date")+"";
            if(date.equals("")) date = "NULL";

            // get file
            Enumeration<?> files = multi.getFileNames();
            file1 = (String)files.nextElement();
            filename1 = multi.getFilesystemName(file1);
        } catch(Exception e) {
            e.printStackTrace();
        }

        // check input validity
        int error = 0;
        if(type.equals("NULL")) {
            %><script>alert("자격증 종류를 선택해주시길 바랍니다"); window,history.back();</script><%
            error++;
        }
        else if(type.equals("0") && type_etc.equals("NULL")) {
            %><script>alert("기타 자격증 종류를 입력해주시길 바랍니다"); window,history.back();</script><%
            error++;
        }
        else if(date.equals("NULL")) {
            %><script>alert("자격증 취득 날짜를 입력해주시길 바랍니다"); window,history.back();</script><%
            error++;
        }
        else if(filename1 == null) {
            %><script>alert("파일을 선택해주세요."); window,history.back();</script><%
            error++;
        }

        if(filename1 != null) file1 = "img" + "/" + filename1;
        out.print("filename : " + file1);

        if(error == 0) {
            String sql = "";
            PreparedStatement pstmt = null;

            if (type.equals("0")) { // 자격증 종류가 기타일 경우
                sql = "SELECT Id FROM CERTIFICATE WHERE Name = \"" + type_etc + "\"";
                pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery(sql);
                String Id = null;
                while (rs.next()) {
                    Id = rs.getString("Id");
                }
                if (Id == null) { // CERTIFICATE table 에 입력값이 없으면
                    // Insert
                    sql = "INSERT INTO CERTIFICATE VALUES(Default, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, type_etc);
                    pstmt.executeUpdate();

                    // Id 가져오기
                    sql = "SELECT Id FROM CERTIFICATE WHERE Name = \"" + type_etc + "\"";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery(sql);
                    while (rs.next()) {
                        Id = rs.getString("Id");
                    }
                }
                type = Id;
                rs.close();
            }

            // Status 0: 대기, 1: 승인, 2: 반려
            sql = "INSERT INTO COMPANY_CERTIFICATE VALUES(?, ?, ?, ?, 0, Default, Default)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, company_id); // companyId
            pstmt.setString(2, type); // 자격증 종류
            pstmt.setString(3, date); // 자격증 취득 날짜
            pstmt.setString(4, file1); // file
            pstmt.executeUpdate();

            pstmt.close();
        %>
            <script>
                alert('등록을 완료했습니다.');
                self.close();
            </script>
        <%
        }
        conn.close();
    %>

</head>
<body>
</body>
</html>