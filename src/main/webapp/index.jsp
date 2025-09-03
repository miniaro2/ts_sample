<%-- src/main/webapp/index.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JSP (No Servlet) + TypeScript 예제</title>
    <style>
        /* ... 스타일은 이전과 동일 ... */
    </style>
</head>
<body>
    <h1>사용자 목록 (Servlet 없음)</h1>
    <p>아래 버튼을 클릭하여 사용자 목록을 불러오세요.</p>
    <button id="loadUsersBtn">사용자 불러오기</button>
    <table id="userTable">
        <thead>
            <tr>
                <th>이름</th>
                <th>이메일</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <%-- 컴파일된 JavaScript 파일을 불러옵니다. --%>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>