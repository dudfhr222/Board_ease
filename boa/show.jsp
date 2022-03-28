<%@page import="Board.board.BoardBean"%>
<%@page import="Board.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardDBBean dbm = BoardDBBean.getInstance();
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	BoardBean data = dbm.getBoard(b_id);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form align = "center">
		<h1 align = "center">글 내 용 보 기</h1>
		<table width = "800" border = "1">
			<tr>
				<td width = "150" align = "center">글번호</td>			
				<td align = "center"><%=data.getB_id() %></td>			
			</tr>
			<tr>
				<td width = "150" align = "center">작성자</td>			
				<td align = "center"><%=data.getB_name() %></td>			
			</tr>
			<tr>
				<td width = "150" align = "center">글제목</td>			
				<td align = "left"><%=data.getB_title() %></td>			
			</tr>
			<tr>
				<td width = "150" align = "center">글내용</td>			
				<td align = "left"><%=data.getB_content() %></td>			
			</tr>
			
		</table>
	</form>
</body>
</html>