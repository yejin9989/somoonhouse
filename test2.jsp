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

//쿼리문 작성. Id가 5번 이하인 회사 정보를 알고 싶을 때
    query = "SELECT * FROM REMODELING_APPLY where Number <= ?"; //쿼리작성
    //query += "order by Name asc"; //이름 오름차순으로 결과 출력
    pstmt = conn.prepareStatement(query); //pstmt 객체에 쿼리문을 담아준다.
    pstmt.setString(1, "10"); //첫번째 물음표에 "5"라는 글자를 넣는다는 의미이다.
    //pstmt에 담긴 문장 - "SELECT * FROM COMPANY WHERE Id <= 5"
    rs = pstmt.executeQuery(); //쿼리를 실행하고, 그 정보가 rs 객체에 담긴다.

//해당 정보들을 담아올 객체를 만든다. 객체를 만들땐 <%!로 시작하는 태그를 사용.%>
<%! public class Customer{
    String number;
    String name;
    String address;
    String state;
    String phone;

    public Customer(String number, String name, String address,String phone, String state){
        this.number = number;
        this.name = name;
        this.address = address;
        this.state = state;
        this.phone = phone;
    }
    //getter, setter 설정
    public String getNum(){
        return number;
    }
    public String getName(){ return name;}
    public String getAddress(){ return address; }
    public String getState(){
        return state;
    }
    public String getPhone(){
        return phone;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setNum(String number){
        this.number = number;
    }
    public void setAddress(String address){
        this.address = address;
    }
    public void setState(String state){
        this.state = state;
    }
    public void setPhone(String phone){
        this.phone = phone;
    }
}
%>
<%
    //방금 만든 Company객체의 ArrayList를 만든다.
//배열으로 만들어도 괜찮지만 ArrayList를 사용하면 동적으로 계속 추가 가능.
//순서가 보장되는 LinkedList를 사용해보겠음
    LinkedList<Customer> customer_list = new LinkedList<Customer>();
    while(rs.next()){
        String c_num = rs.getString("Number");
        String c_name = rs.getString("Name"); //rs로부터 정보를 받아오려면 rs.getString("받아올 컬럼"); 이렇게 사용한다.
        String address = rs.getString("Address");
        String state = rs.getString("State"); //입점 동의 여부  0:비동의 1:동의
        String phone = rs.getString("Phone"); //마지막으로 로그인 한 날짜

        if(state != null && state.equals("1"))
            state = "업체에_신청완료";
        else
            state = "미처리_상태";

        //if(modify_date == null)
         //   modify_date = "로그인 기록 없음";

        Customer customer = new Customer(c_num, c_name, address,  phone, state); //결과들을 객체에 담고

        customer_list.add(customer);//객체를 리스트에 담는다.
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
    <link rel="stylesheet" type="text/css" href="css/test2.css"><!-- 외부 스타일시트 -->
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
    <h2>🏢<br>고객 정보</h2>
    <%for(Customer customer : customer_list){ //company_list안의 Company객체들을 for문을 통해 순서대로 돈다.
    %>
    <div class="customer-info" id="num<%=customer.getNum()%>">
        <div class="customer-name"><%=customer.getName()%></div>
        <div class="customer-address"><%=customer.getAddress()%></div>
        <div class="customer-phone"><%=customer.getPhone()%></div>
        <div class="customer-state" id="<%=customer.getState()%>"><%=customer.getState()%></div>
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
    $(".customer-info").click(function(){ //company-info 클래스가 클릭 되었을 때,
        var div_num = $(this).attr('id'); //현재 클릭된 객체의 아이디를 받아온다.
        var customer_id = div_num.replace("num", ""); //아이디 형식이 com1, com2 .. 이렇게 되어있으므로
                                                    //com을 없앤 숫자만 추출한다.
        location.href = "https://somoonhouse.com/customer_login.jsp?customer_num="+customer_id;
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