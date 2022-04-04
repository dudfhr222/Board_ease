<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "data" class = "magic.board.BoardBean"/>
<jsp:setProperty name = "data" property = "*"/>
<!DOCTYPE html>
<%
	String pageNum = request.getParameter("pageNum");
	int b_id = Integer.parseInt(request.getParameter("b_id"));
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="board.js" charset="UTF-8"></script>
</head>
<body>
	<form name = "dt_frm" method = "post" action = "deleteOk.jsp?b_id=<%=data.getB_id() %>&pageNum=<%=pageNum%>">
		<h1 align = "center">글 삭 제 하 기</h1>
		<h3 align = "center"> >> 암호를 입력하세요 << </h3>
		<div align = "center">
			암호 <input type = "password" name = "b_pwd">
		</div><br>
		<div align = "center">
			<input type = "button" value = "글삭제" onclick ="delete_ok()">
			<input type = "reset" value = "다시작성">
			<input type = "button" value = "글목록" onclick ="location.href='list.jsp?pageNum=<%=pageNum%>'">
		</div>
	</form> 
</body>
</html>