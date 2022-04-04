<%@page import="magic.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "data" class = "magic.board.BoardBean"/>
<jsp:setProperty name = "data" property = "*"/>
<%
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}

	BoardDBBean dbm = BoardDBBean.getInstance();
//	ArrayList<BoardBean> list = dbm.listBoard();
	ArrayList<BoardBean> list = dbm.listBoard(pageNum);
	int b_level = 0, b_id = 0, b_hit = 0; 
	String b_name, b_title, b_content;
	Timestamp b_date;
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<form>
			<h1 align = "center">게시판에 등록된 글 목록 보기</h1>
			<table width = "1000">
				<tr>
					<td colspan = "3" align = "right">
						<a href="write.jsp">글 쓰 기</a>
					</td>
				</tr>
			</table>
			<table border = "1" width = "1200" align = "center">
				<tr height = "25">
					<td width = "40" align = "center">번호</td>
					<td width = "700" align = "center">글제목</td>
					<td width = "100" align = "center">작성자</td>
					<td width = "200" align = "center">작성일</td>
					<td width = "80" align = "center">조회수</td>
				</tr>
<%
						for(int i =0;i<list.size();i++){
							data = list.get(i);
							b_level = data.getB_level();
%>					
					<tr onmouseover="this.style.color='red';" onmouseout="this.style.color='blue';"> 
					<td align = "center"><%=data.getB_id() %></td>
					<td align = "left">
<%
						if(b_level > 0){
							for(int j=0;j<b_level;j++){
%>
						<img src="C:\Users\Administrator\Desktop\[디지털컨버전스]자바(JAVA)&스프링프레임워크디지털실무자양성과정B-1\JSP/AnswerLine.gif">

<%
						}
%>
<%
						}
					%>
						<a href = "show.jsp?b_id=<%=data.getB_id()%>">
							<%=data.getB_title() %>
						</a>
					</td>
					<td align = "center">
						<a href = "mailto:<%=data.getB_email() %>"><%=data.getB_name() %></a> 
					</td>
					<td align = "center">
						<%=data.getB_date() %>
					</td>
					<td align = "center">
						<%=data.getB_hit() %>
					</td>
				</tr>
						<% 
						}
						%>			
			</table>
			<div align = "center">
				&nbsp;&nbsp;&nbsp;<%=	data.pageNumber(4)%>
			</div>
		</form>
</body>
</html>