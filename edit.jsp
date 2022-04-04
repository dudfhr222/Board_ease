<%@page import="Board.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "board" class = "Board.board.BoardBean"/>
<jsp:setProperty name = "board" property = "*"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="board.js" charset="UTF-8"></script>
		
<%
	String pageNum = request.getParameter("pageNum");	
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	BoardDBBean dbm = BoardDBBean.getInstance();
	board = dbm.getBoard(b_id, false);
%>

</head>
<body>
	<h1 align = "center">글 수 정 하 기</h1>
		<form name = "edit_frm" method = "post" action = "editOk.jsp?b_id=<%=board.getB_id() %>&pageNum=<%= pageNum %>">
			<table align = "center">
				<tr height = "30">
					<td width = "80">작성자</td>
					<td width = "140">
						<input type = "text" name = "b_name" size = "10" maxlength = "20">
					</td>
					<td width = "80">이메일</td>
					<td width = "240">
						<input type = "text" name = "b_email" size = "24" maxlength = "50">
					</td>
				</tr>
				<tr height = "30">
					<td width = "80">글제목</td>
					<td colspan = "3" width = "460">
						<input type = "text" name = "b_title" size = "55" maxlength = "80">
					</td>
				</tr>
				<tr>
					<td colspan = "4">
						<textarea cols = "65" rows = "10" name = "b_content"></textarea>
					</td>
				</tr>
				<tr>
					<td>암 호</td>
					<td><input type = "password" name = "b_pwd" size = "12" maxlength = "12"></td>
				</tr>
				<tr height = "50" align = "center">
					<td colspan = "4">
						<input type = "button" value = "글수정" onclick = "check_edit()">
						<input type = "reset" value = "다시작성">
						<input type = "button" value = "글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'">
					</td>
				</tr>
			</table>
		</form>
</body>
</html>