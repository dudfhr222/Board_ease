<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("Member") == null){
		response.sendRedirect("login.jsp");
	}
%>
<%
	String uid = (String)session.getAttribute("uid");
	String name = (String)session.getAttribute("name");
	//out.println("@@@### name02 ===>"+name);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<form method="post" action="logOut.jsp">
			<tr>
				<td>
					안녕하세요. <%= name %>(<%= uid %>)님
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="로그아웃">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="회원정보변경" onclick="javascript:window.location='memberUpdate.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>