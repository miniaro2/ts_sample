<%-- src/main/webapp/users_data.jsp --%>
<%@ page contentType="application/json; charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%
    // 데이터를 담을 리스트 생성
    List<Map<String, String>> userList = new ArrayList<>();

    // 사용자 데이터 추가 (Map을 사용해 간단히 구현)
    Map<String, String> user1 = new HashMap<>();
    user1.put("name", "홍길동 (JSP)");
    user1.put("email", "gildong@example.com");
    userList.add(user1);

    Map<String, String> user2 = new HashMap<>();
    user2.put("name", "이순신 (JSP)");
    user2.put("email", "sunshin@example.com");
    userList.add(user2);

    Map<String, String> user3 = new HashMap<>();
    user3.put("name", "유관순 (JSP)");
    user3.put("email", "gwansun@example.com");
    userList.add(user3);

    // Gson 라이브러리를 사용해 리스트를 JSON 문자열로 변환
    String json = new Gson().toJson(userList);

    // JSON 문자열을 페이지에 출력
    out.print(json);
%>