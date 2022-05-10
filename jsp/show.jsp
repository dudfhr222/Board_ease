<%@page import="java.text.SimpleDateFormat"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int bid = Integer.parseInt(request.getParameter("b_id"));
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getBoard(bid, true);
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>글 내 용 보 기</h1>
		<table border="1" width="600" cellspacing="0">
			<tr height="30" align="center">
				<td width="100">글번호</td>
				<td width="200">
					<%= board.getB_id() %>
				</td>
				<td width="100">조회수</td>
				<td width="200">
					<%= board.getB_hit() %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">작성자</td>
				<td width="200">
					<%= board.getB_name() %>
				</td>
				<td width="100">작성일</td>
				<td width="200">
					<%= sdf.format(board.getB_date()) %>
					<%-- <%= board.getB_date() %> --%>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="110">파&nbsp;&nbsp;일</td>
				<td colspan="3">
					&nbsp;
					<%--
					<%
						if(board.getB_fname() != null){
					%>
							<img src="./images/zip.gif">
							<a href="./upload/<%= board.getB_fname() %>">
								원본파일 : <%= board.getB_fname() %>
							</a>
					<%
						}
					%>
					 --%>
				 <%
				 	out.println("<p>첨부파일"+"<a href='FileDownload.jsp?fileN="+board.getB_id()+"'>"+board.getB_rfname()+"</a>"+"</p>");
				 %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">글제목</td>
				<td colspan="3" align="left">
					<%= board.getB_title() %>
				</td>
			</tr>
			<tr height="30" align="center">
				<td width="100">글내용</td>
				<td colspan="3" align="left">
					<%= board.getB_content() %>
				</td>
			</tr>
			<tr height="30">
				<td colspan="4" align="right">
					<input type="button" value="글수정" onclick="location.href='edit.jsp?b_id=<%= board.getB_id() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="글삭제" onclick="location.href='delete.jsp?b_id=<%= board.getB_id() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="답변글" onclick="location.href='write.jsp?b_id=<%= board.getB_id() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'">
				</td>
			</tr>
		</table>
	</center>
</body>
</html>