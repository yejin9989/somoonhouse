<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>추천 사례 등록</title>
</head>
<body>
<form name="form" id="form" method="post" enctype="multipart/form-data" action="_recommend_item_upload.jsp">
    <div id="callBackDiv">
        <table>
            <tr><td>대표사진</td><td><input type="file" name="filename1" size=40></td></tr>
            <tr><td>URL</td><td><input type="text"  style="width:500px;" id="url"  name="url" /></td></tr>
            <tr><td>글제목</td><td><input type="text"  style="width:500px;" id="title"  name="title" /></td></tr>
        </table>
<%--        <div>※제목을 입력하지 않으면 등록한 URL의 제목으로 자동등록됩니다.</div>--%>
        <input type="submit" value="등록">
    </div>
</form>
<script type = "text/javascript" src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
</body>
</html>