<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="mb" class="magic.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<%
	MemberDBBean manager = MemberDBBean.getInstance();
	String uid = (String)session.getAttribute("uid");
	mb.setMem_uid(uid);
	int re = manager.updateMember(mb);
	
	if(re == 1){
%>
		<script>
			alert("�Է��Ͻ� ��� ȸ�� ������ �����Ǿ����ϴ�.");
			document.location.href="main.jsp";
		</script>
<%
	}else{
%>
		<script>
			alert("������ ���еǾ����ϴ�.");
			history.go(-1);
		</script>
<%
	}
%>
