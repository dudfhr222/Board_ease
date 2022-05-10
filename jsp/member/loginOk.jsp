<%@page import="org.apache.el.lang.ELSupport"%>
<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String id = request.getParameter("mem_uid");
	String pwd = request.getParameter("mem_pwd");
	
	MemberDBBean manager = MemberDBBean.getInstance();
	int check = manager.userCheck(id, pwd);
	MemberBean mb = manager.getMember(id);
	
	//System.out.println("@@@### 00");
	
	if(mb == null){
		//System.out.println("@@@### 11");
%>
		<script>
			alert("존재하지 않는 회원");
			history.go(-1);
		</script>
<%
	}else{
		//System.out.println("@@@### 12");
		
		String name = mb.getMem_name();
		
		if(check == 1){
			//System.out.println("@@@### name01 ===>"+name);
			session.setAttribute("uid", id);
			session.setAttribute("name", name);
			session.setAttribute("Member", "yes");
			response.sendRedirect("main.jsp");
		}else if(check == 0){
%>
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>
<%
		}else{
%>
			<script>
				alert("아이디가 맞지 않습니다.");
				history.go(-1);
			</script>
<%
			
		}
	}
%>
