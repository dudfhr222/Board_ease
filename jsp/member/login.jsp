<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<form method="post" action="loginOk.jsp">
			<tr>
				<td align="center">
					사용자ID
				</td>
				<td>
					<input type="text" name="mem_uid">
				</td>
			</tr>
			<tr>
				<td align="center">
					비밀번호
				</td>
				<td>
					<input type="password" name="mem_pwd">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="로그인">
					<input type="button" value="회원가입" onclick="javascript:window.location='register.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>