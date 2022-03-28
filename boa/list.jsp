<%@page import="magic.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Board.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "data" class = "Board.board.BoardBean"/>
<jsp:setProperty name = "data" property = "*"/>
<%
	BoardDBBean dbm = BoardDBBean.getInstance();
	ArrayList<BoardBean> list = dbm.listBoard();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<form>
			<table width = "600">
				<tr>
					<td colspan = "3" align = "right">
						<a href="write.jsp">글 쓰 기</a>
					</td>
				</tr>
			</table>
			<table border = "1" width = "800">
				<tr height = "25">
					<td width = "40" align = "center">번호</td>
					<td width = "450" align = "center">글제목</td>
					<td width = "120" align = "center">작성자</td>
					<td width = "120" align = "center">작성일</td>
				</tr>
<%
	for(int i =0;i<list.size();i++){
		data = list.get(i);
		
				%><tr onmouseover="this.style.color='red';" onmouseout="this.style.color='blue';"> 
					<td align = "center"><%=data.getB_id() %></td>
					<td align = "left">
						<a href = "show.jsp?b_id=<%=data.getB_id() %>"><%=data.getB_title() %></a>
					</td>
					<td align = "center">
						<%--<a href = "mailto:<%=a@a.com%>"><%=data.getB_name() %></a> --%> 
						<a href = "mailto:<%=data.getB_email() %>"><%=data.getB_name() %></a> 
					</td>
					<td align = "center">
						<%=data.getB_date() %>
					</td>
				</tr>
<% 
}
%>			</table>
		</form>
</body>
</html>