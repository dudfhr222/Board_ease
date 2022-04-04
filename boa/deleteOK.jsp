<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int id = Integer.parseInt(request.getParameter("b_id"));
	String pwd = request.getParameter("b_pwd");
	String pageNum = request.getParameter("pageNum");
	
	BoardDBBean dbm = BoardDBBean.getInstance();
	int check = dbm.deleteBoard(id, pwd);
	if(check == 1){
%>
<script>
		alert("삭제 성공");
</script>
<%		
	response.sendRedirect("list.jsp?pageNum=" + pageNum);
	}else{
%>
<script>
		alert("삭제 실패");
		history.go(-1);
</script>
<%
	}
%>
