<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mb" class="magic.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<%
	MemberDBBean manager = MemberDBBean.getInstance();

	if(manager.confirmID(mb.getMem_uid()) == 1){
%>
		<script>
			alert("중복되는 아이디가 존재합니다.");
			history.back();
		</script>
<%
	}else{
		int re = manager.insertMember(mb);
		
		if(re == 1){
%>
			<script type="text/javascript">
				alert("회원가입을 축하드립니다.\n회원으로 로그인 해주세요.");
				document.location.href="login.jsp";
			</script>
<%
		}else{
%>
			<script>
				alert("회원가입에 실패했습니다.");
				document.location.href="login.jsp";
			</script>
<%
		}
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>