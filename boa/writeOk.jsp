<%@page import="Board.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id = "board" class = "Board.board.BoardBean"/>
<jsp:setProperty name = "board" property = "*"/>
<%
	response.setCharacterEncoding("UTF-8");
%>
<%
	BoardDBBean db = BoardDBBean.getInstance();
	int re = db.InsertBoard(board);
	
	if(re == 1){
%>
<script>
		alert("추가 완료");
		
</script>
<%		
	response.sendRedirect("list.jsp");	
	}else{
%>
<script>
		alert("추가 실패");
</script>
<%
	response.sendRedirect("write.jsp");
}
%>