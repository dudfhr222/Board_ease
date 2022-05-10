<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String uid = (String)session.getAttribute("uid");

	MemberDBBean manager = MemberDBBean.getInstance();
	MemberBean mb = manager.getMember(uid);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" src="script.js" charset="UTF-8"></script>
</head>
<body>
	<table border="1">
		<form name="upd_frm" method="post" action="memberUpdateOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h1>회원 정보 수정</h1>
					'*' 표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr>
				<td width="80">
					User ID
				</td>
				<td>
					<%= uid %>
				</td>
			</tr>
			<tr>
				<td width="80">
					암호
				</td>
				<td>
					<input type="password" size="20" name="mem_pwd">*
				</td>
			</tr>
			<tr>
				<td width="80">
					암호 확인
				</td>
				<td>
					<input type="password" size="20" name="pwd_check">*
				</td>
			</tr>
			<tr>
				<td width="80">
					이    름
				</td>
				<td>
					<%= mb.getMem_name() %>
				</td>
			</tr>
			<tr>
				<td width="80">
					E-mail
				</td>
				<td>
					<input type="text" size="30" name="mem_email" value="<%= mb.getMem_email() %>" >*
				</td>
			</tr>
			<tr>
				<td width="80">
					주    소
				</td>
				<td>
					<input type="text" size="40" name="mem_address" value="<%= mb.getMem_address() %>" >
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="수정" onclick="update_check_ok()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시입력">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="가입안함" onclick="javascript:window.location='login.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>