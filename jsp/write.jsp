<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");

	int b_id = 0, b_ref=1, b_step=0, b_level=0;
	String b_title="";
	
	if(request.getParameter("b_id") != null){
		b_id = Integer.parseInt(request.getParameter("b_id"));
	}
	
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getBoard(b_id, false);
	
	if(board != null){
		b_title = board.getB_title();
		b_ref = board.getB_ref();
		b_step = board.getB_step();
		b_level = board.getB_level();
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="board.js" type="text/javascript"></script>
</head>
<body>
	<center>
		<h1>글 올 리 기</h1>
		<form name="reg_frm" method="post" action="write_ok.jsp" enctype="multipart/form-data">
			<input type="hidden" name="b_id" value="<%= b_id %>">
			<input type="hidden" name="b_ref" value="<%= b_ref %>">
			<input type="hidden" name="b_step" value="<%= b_step %>">
			<input type="hidden" name="b_level" value="<%= b_level %>">
			<table>
				<tr height="30">
					<td width="80">작성자</td>
					<td width="140">
						<input type="text" name="b_name" size="10" maxlength="20">
					</td>
					<td width="80">이메일</td>
					<td width="240">
						<input type="text" name="b_email" size="24" maxlength="50">
					</td>
				</tr>
				<tr height="30">
					<td width="80">글제목</td>
					<td colspan="3" width="460">
						<%
							if(b_id == 0){
						%>
								<input type="text" name="b_title" size="55" maxlength="80">
						<%
							}else{
						%>
								<input type="text" name="b_title" size="55" maxlength="80" 
									   value="[답변]:<%= b_title %>">
						<%
							}
						%>
					</td>
				</tr>
				<tr height="30">
					<td width="80">파   일</td>
					<td colspan="3" width="140">
						<input type="file" name="b_fname" size="40" maxlength="100">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea rows="10" cols="65" name="b_content"></textarea>
					</td>
				</tr>
				<tr height="30">
					<td width="80">암&nbsp;&nbsp;호</td>
					<td colspan="3" width="460">
						<input type="password" name="b_pwd" size="12" maxlength="12">
					</td>
				</tr>
				<tr height="50" align="center">
					<td colspan="4">
						<input type="button" value="글쓰기" onclick="check_ok()">&nbsp;
						<input type="reset" value="다시작성">
						<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'">&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>