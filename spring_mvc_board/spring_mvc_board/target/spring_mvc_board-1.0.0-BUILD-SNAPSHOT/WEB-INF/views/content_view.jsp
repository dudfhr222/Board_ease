<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022-05-18
  Time: 오전 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
  <table border="1" width="500">
    <form action = "modify" method="post">
        <!-- content_view : BController, control_view에서 model에 저장한 값의 key  -->
        <input type="hidden" name="bId" value="${content_view.bId}">
        <tr>
            <td>번호</td>
            <td>${content_view.bId}</td>
        </tr>
        <tr>
            <td>히트</td>
            <td>${content_view.bHit}</td>
        </tr>
        <tr>
            <td>이름</td>
            <td>
                <input type="text" name = "bName" value="${content_view.bName}">
            </td>
        </tr>
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="bTitle" value="${content_view.bTitle}">
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <input type="text" name="bContent" value="${content_view.bContent}">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="수정">
                &nbsp;&nbsp;<a href="list">목록 보기</a>
                &nbsp;&nbsp;<a href="delete?bId=${content_view.bId}">삭제</a>
            </td>
        </tr>
    </form>
  </table>
</body>
</html>
