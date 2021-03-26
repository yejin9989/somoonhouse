<%@ page import="java.net.URLEncoder" %><!-- Java코드내에서 URL인코드 하는 클래스-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%><!-- jsp인코딩 설정 charset:웹 브라우저가 받을때 인코딩방식, pageEncoding 쓰여지고 저장할 때 인코딩 방식-->
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*,java.security.*,java.math.BigInteger" %>
<!-- 자바 클래스 import. java.util.* 이런 자바 할때 배웠던 기본 클래스들 넣어준다. 나중에 필요한 거 있으면 여기다가 넣으면 됨.-->
<%@ page language="java" import="myPackage.*" %>
<!-- myPackage 폴더 내의 클래스 사용. 직접 만든 클래스들 사용할 때 여기에 넣으면 된다. 현재는 DBUtil 클래스 사용중(데이터베이스 연결 클래스)-->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- form 데이터 받아올 시 인코딩 방식 -->
<% response.setContentType("text/html; charset=utf-8"); %>
<script type="text/javascript">
    var selectArea = document.getElementById("second_area");
</script>

<!-- form 데이터 보낼 시 인코딩 방식 -->
<%
    //DB에 사용 할 객체들 정의
    Connection conn = DBUtil.getMySQLConnection(); //DB와 연결하는 객체를 만들어준다.
    PreparedStatement pstmt = null; //?(물음표)를 채울 수 있는 쿼리, sql을 담는 객체. 아래에 사용례를 보면 이해가능
    Statement stmt = null; //쿼리, sql을 담는 객체.
    String query = ""; //보통 쿼리는 select문 이고
    String sql = ""; //sql은 update, delete 할 때 사용한다.
    ResultSet rs = null; //쿼리를 돌린 결과를 담을 수 있는 객체

//세션 생성 create session 세션 페이지 정보가 필요할 시 이용.
    session.setAttribute("page", "lisence_check.jsp"); // 현재 페이지 current page
//세션 가져오기 get session. 보통 나는 page, s_id, name 이렇게 세가지 섹션을 이용하는데
//page는 현재 or 넘어온 페이지등을 확인하고 s_id는 로그인된 사용자의 id정보,
//name은 로그인된 사용자의 이름정보를 담아둔다.
    String now = session.getAttribute("page")+""; // 현재 페이지 current page
    String s_id = session.getAttribute("s_id")+"";// 현재 사용자 current user
    String name = session.getAttribute("name")+"";


    String selectArea = null;
    String search_value = null;
    selectArea = request.getParameter("second_area");
    search_value = request.getParameter("search");

//쿼리문 작성. Id가 5번 이하인 회사 정보를 알고 싶을 때
    query = "SELECT * FROM REMODELING where Company_num = ? and Apart_name like \"%" +search_value+"%\"" + "and Second_area = ? order by Hit DESC "; //쿼리작성
    //query += "order by Name asc"; //이름 오름차순으로 결과 출력
    pstmt = conn.prepareStatement(query); //pstmt 객체에 쿼리문을 담아준다.
    pstmt.setString(1, "1"); //첫번째 물음표에 "5"라는 글자를 넣는다는 의미이다.
    pstmt.setString(2,selectArea);
    //pstmt에 담긴 문장 - "SELECT * FROM COMPANY WHERE Id <= 5"
    rs = pstmt.executeQuery(); //쿼리를 실행하고, 그 정보가 rs 객체에 담긴다.


//해당 정보들을 담아올 객체를 만든다. 객체를 만들땐 <%!로 시작하는 태그를 사용.%>
<%! public class Company_remodeling{
    String number;
    String title;
    String fee;
    String period;
    String address;
    String content;
    String hit;


    public Company_remodeling(String number, String title, String fee, String period,String address, String content,String hit ){
        this.number = number;
        this.title = title;
        this.fee = fee;
        this.period = period;
        this.address = address;
        this.content = content;
        this.hit = hit;
    }
    //getter, setter 설정
    public String getNum(){
        return number;
    }
    public String getTitle(){ return title;}
    public String getFee(){ return fee; }
    public String getPeriod(){
        return period;
    }
    public String getAddress() {return address;}
    public String getContent() {return content;}
    public String getHit(){
        return hit;
    }
    public void setTitle(String title){
        this.title = title;
    }
    public void setNum(String number){
        this.number = number;
    }
    public void setFee(String fee){
        this.fee = fee;
    }
    public void setPeriod(String period){
        this.period = period;
    }
    public void setAddress(String address) {this.address = address;}
    public void setContent(String content) {this.content = content;}
    public void setHit(String hit){
        this.hit = hit;
    }
}
%>
<%
    //방금 만든 Company객체의 ArrayList를 만든다.
//배열으로 만들어도 괜찮지만 ArrayList를 사용하면 동적으로 계속 추가 가능.
//순서가 보장되는 LinkedList를 사용해보겠음
    LinkedList<Company_remodeling> CR_list = new LinkedList<Company_remodeling>();
    while(rs.next()){
        String cr_num = rs.getString("Number");
        String cr_title = rs.getString("Title"); //rs로부터 정보를 받아오려면 rs.getString("받아올 컬럼"); 이렇게 사용한다.
        String fee = rs.getString("Fee"); //입점 동의 여부  0:비동의 1:동의
        String period = rs.getString("Period");
        String address = rs.getString("Address");
        String content = rs.getString("Content");
        String hit = rs.getString("Hit"); //마지막으로 로그인 한 날짜

        //if(state != null && state.equals("1"))
        //    state = "업체에_신청완료";
        //else
        //    state = "미처리_상태";

        //if(modify_date == null)
        //   modify_date = "로그인 기록 없음";

        Company_remodeling company_remodeling = new Company_remodeling(cr_num, cr_title, fee,  period,address,content, hit); //결과들을 객체에 담고

        CR_list.add(company_remodeling);//객체를 리스트에 담는다.
    }
//이제 리스트에 내가 받아오고 싶은 회사 정보를 담았고, 웹 페이지에 뿌려주면 된다.
%>

<!DOCTYPE html>
<html>
<head>
    <!-- Global site tag (gtag.js) - Google Analytics 페이지 사용자 정보를 수집하는 script-->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-PC15JG6KGN"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-PC15JG6KGN');
    </script>

    <link rel="SHORTCUT ICON" href="img/favicon.ico" /><!-- 브라우저 탭에 나타나는 아이콘. 우리 아이콘은 파란색 네모안에 소문이라고 적혀있다. -->
    <link rel="stylesheet" type="text/css" href="https://pm.pstatic.net/css/webfont_v170623.css"/><!-- 나눔고딕 폰트 -->
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script><!-- jQuery 가져오는 스크립트. javascript를 편하게 쓰기위한 라이브러리 -->
    <link rel="stylesheet" type="text/css" href="css/test3.css"><!-- 외부 스타일시트 -->
    <style type="text/css">
        /*내부 스타일 작성하면 됨*/
    </style>
    <meta charset="UTF-8"><!-- html 인코딩 방식 -->
    <!-- 밑에 meta는 휴대폰에서 화면 비율 맞춰주기 위한 태그 -->
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>소문난집</title><!-- 브라우저 탭에서 보이는 제목 -->
</head>
<body>
<div id="container">
    <h2>🏢<br>회사 사례</h2
    <div id="formarea">
        <form id="form" name="form" method="POST" action="test3.jsp">
            <div id="searcharea">
                <select id="second_area" name="second_area">
                    <option value="all" selected="selected">전체</option>
                    <option value="141">중구</option>
                    <option value="142">동구</option>
                    <option value="143">서구</option>
                    <option value="144">남구</option>
                    <option value="145">북구</option>
                    <option value="146">수성구</option>
                    <option value="147">달서구</option>
                    <option value="148">달성군</option>
                </select>
                <input type="text" id="search"  name="search" maxlength="200px" placeholder="동이름, 아파트명으로 찾아보세요."/>
                <!-- <input id="search" type="submit" value=""> -->
                <button id="but1" type="submit">click</button>
            </div>
        </form>
    </div>

    <%for(Company_remodeling company_remodeling : CR_list){ //company_list안의 Company객체들을 for문을 통해 순서대로 돈다.
    %>
    <div class="cr-info" id="num<%=company_remodeling.getNum()%>">
        <div class="cr-title"><%=company_remodeling.getTitle()%></div>
        <div class="cr-fee"><%=company_remodeling.getFee()%></div>
        <div class="cr-period"><%=company_remodeling.getPeriod()%></div>
        <div class="cr-address"><%=company_remodeling.getAddress()%></div>
        <div class="cr-content"><%=company_remodeling.getContent()%></div>
        <div class="cr-hit"><%=company_remodeling.getHit()%></div>

    </div>
    <%
        }
    %>
</div>
<%
    //DB개체 정리
    pstmt.close();
    rs.close();
    query="";
    conn.close();
%>
<script>
    //누르면 해당 회사 페이지로 가도록 만들어 보자.
    //회사 페이지 링크는 https://somoonhouse.com/company_home.jsp?company_id=회사번호
    $(".cr-info").click(function(){ //company-info 클래스가 클릭 되었을 때,
        var div_num = $(this).attr('id'); //현재 클릭된 객체의 아이디를 받아온다.
        var cr_id = div_num.replace("num", ""); //아이디 형식이 com1, com2 .. 이렇게 되어있으므로
        //com을 없앤 숫자만 추출한다.
        location.href = "https://somoonhouse.com/_hit1.jsp?num="+cr_id;
    })
</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
    if(!wcs_add) var wcs_add = {};
    wcs_add["wa"] = "3602e31fd32c7e";
    wcs_do();
</script>
<script type="text/javascript" src="slick-1.8.1/slick/slick.min.js"></script>
</body>
</html>