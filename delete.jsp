<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "data" class = "magic.board.BoardBean"/>
<jsp:setProperty name = "data" property = "*"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="board_t.js" charset="UTF-8"></script>
</head>
<body>
	<form name = "dt_frm" method = "post" action = "deleteOk.jsp?b_id=<%=data.getB_id() %>">
		<h1 align = "center">글 삭 제 하 기</h1>
		<h3 align = "center"> >> 암호를 입력하세요 << </h3>
		<div align = "center">
			암호 <input type = "password" name = "b_pwd">
		</div><br>
		<div align = "center">
			<input type = "button" value = "글삭제" onclick ="delete_ok()">
			<input type = "reset" value = "다시작성">
			<input type = "button" value = "글목록" onclick ="javascript:window.location='list_t.jsp'">
		</div>
	</form> 
</body>
</html>