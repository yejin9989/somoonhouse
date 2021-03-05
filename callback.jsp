<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="com.google.gson.*"%>

<html>
  <head>
    <title>네이버로그인</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/>
  </head>
  <body style="width:100%;">
  <div style="display:block;text-align:center;width:100%;">
  </div>
  <%
    String clientId = "G8MVoxXfGciyZW5dF4p1";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "bqjKbGP1j4";//애플리케이션 클라이언트 시크릿값";
    String uri = request.getParameter("uri");
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://somoonhouse.com/callback.jsp", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    String auth = "";
    //System.out.println("apiURL="+apiURL);
    try {
      String str = "";
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      //System.out.print("responseCode="+responseCode);
      if(responseCode==200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuffer res = new StringBuffer();
      while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
      }
      br.close();
      if(responseCode==200) {
        //out.println(res.toString());
        str = res.toString();
        /*접근토큰정보 파싱*/
        JsonParser jsonParser = new JsonParser();
        JsonObject object = (JsonObject) jsonParser.parse(str);
        access_token = object.get("access_token").getAsString();
        refresh_token = object.get("refresh_token").getAsString();
        String token_type = object.get("token_type").getAsString();
        //String expire_in = object.get("expire_in").getAsString();
        auth = "Bearer "+access_token;
        
      }
    }catch (Exception e) {
        System.out.println(e);
      }
	
    try{
        response.setHeader("Pragma", "No-cache");
        response.addHeader("Authorization", auth);
        //out.println(auth);
		String str="";
		String profile_url;
		profile_url = "https://openapi.naver.com/v1/nid/me";
				
        URL url = new URL(profile_url);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", auth);
        int responseCode = con.getResponseCode();
        BufferedReader br;
        //System.out.print("responseCode="+responseCode);
        
        if(responseCode==200){
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer res = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
          res.append(inputLine);
        }
        br.close();
        out.println(res.toString());
        if(responseCode==200) {
          str = res.toString();
          /*사용자프로필정보 파싱*/
		  JsonParser jsonParser = new JsonParser();
		  JsonObject respon = (JsonObject) jsonParser.parse(str);
          String message = respon.get("message").getAsString();
          JsonObject prof = (JsonObject)respon.get("response");
          String id = prof.get("id").getAsString() + "";
          String birthday = "";
          String age = "";
          String gender = "N";
          String email = "";
          String name = "";
          String birthyear = "";
          if(prof.get("birthday") != null){
        	  birthday = prof.get("birthday").getAsString() + "";
          }

          if(prof.get("age") != null){
        	  age = prof.get("age").getAsString() + "";
          }
          
          if(prof.get("gender") != null){
        	  gender = prof.get("gender").getAsString() + "";
          }

          if(prof.get("email") != null) {
        	  email = prof.get("email").getAsString() + "";
          }

          if(prof.get("name") != null) {
        	  name = prof.get("name").getAsString() + "";
          }
          
          if(prof.get("birthyear") != null) {
        	  name = prof.get("birthyear").getAsString() + "";
          }
          %>
          <script>
		  var s = encodeURI("_"+"signup.jsp"+"?sns_id=<%=id%>&gender=<%=gender%>&email=<%=email%>&name=<%=name%>&age=<%=age%>&birthday=<%=birthday%>&year=<%=birthyear%>&sns_type=naver");
		  document.location.href = s;
          </script>
          <%
      	}
      } catch(Exception e){
    	  System.out.println(e);
    }
  %>
  </body>
</html>