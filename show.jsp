<%@page import="Board.board.BoardBean"%>
<%@page import="Board.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SimpleDateFormat sfd = new SimpleDateFormat("yyyy-MM-dd HH:mm)");
	BoardDBBean dbm = BoardDBBean.getInstance();
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	
	BoardBean data = dbm.getBoard(b_id, true);
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
				<td width = "150" align = "center">조회수</td>			
				<td align = "center"><%=data.getB_hit() %></td>		
				<td width = "150" align = "center">IP주소</td>			
				<td align = "center"><%=data.getB_ip() %></td>		
			</tr>
			<tr>
				<td width = "150" align = "center">작성자</td>			
				<td align = "center"><%=data.getB_name() %></td>
				<td width = "150" align = "center">작성일</td>			
				<td align = "center"><%=data.getB_date() %></td>						
			</tr>
			<tr align = "center" height = "30">
				<td width = "110" >파일</td>			
					<td colspan = "5">
					<%
						if(data.getB_fname() != null){
					%>
						<img src="C:\Users\Administrator\Desktop\[디지털컨버전스]자바(JAVA)&스프링프레임워크디지털실무자양성과정B-1\JSP/zip.gif">
						<a href = "./upload/<%= data.getB_fname() %>">(원본파일 : <%= data.getB_fname() %>)</a>
					<%
						}
					%>
					</td>			
				</tr>
			<tr>
			<tr>
				<td width = "150" align = "center">글제목</td>			
				<td align = "left"><%=data.getB_title() %></td>			
			</tr>
			<tr>
				<td width = "150" align = "center">글내용</td>			
				<td align = "left"><%=data.getB_content() %></td>			
			</tr>
			<tr>
				<td align ="right" colspan = "4">
					<input type = "button" value = "글수정" onclick ="location.href='edit.jsp?b_id=<%=data.getB_id()%>'">
					<input type = "button" value = "글삭제" onclick ="location.href='delete.jsp?b_id=<%=data.getB_id()%>'">
					<input type = "button" value = "글목록" onclick ="location.href='list.jsp?pageNum=<%=pageNum%>'">
					<input type = "button" value = "답변글" onclick="location.href='write.jsp?b_id=<%=data.getB_id()%>'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>