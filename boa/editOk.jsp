<%@page import="Board.board.BoardBean"%>
<%@page import="Board.board.BoardDBBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id = "board" class = "Board.board.BoardBean"/>
<jsp:setProperty name = "board" property = "*"/>
<%
	response.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	BoardDBBean dbm = BoardDBBean.getInstance();
	
	int check = dbm.editBoard(board);
	if(check == 1){
%>
<script>
		alert("수정 성공");
</script>
<%		
	response.sendRedirect("list.jsp?pageNum=" + pageNum);
	}else{
%>
<script>
		alert("수정 실패");
		history.go(-1);
</script>
<%
	}
%>