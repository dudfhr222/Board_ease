<%@page import="java.io.File"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");

	int b_id = Integer.parseInt(request.getParameter("b_id"));
	String b_pwd = request.getParameter("b_pwd");
	
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getBoard(b_id, false);
	String fName = board.getB_fname();
	String up="D:\\space_java\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\magicWebApp\\upload\\";
	
	int re = db.deleteBoard(b_id, b_pwd);
	
	if(re == 1){
		response.sendRedirect("list.jsp?pageNum="+pageNum);
		
		if(fName != null){
			File file = new File(up+fName);
			file.delete();
		}
	}else if(re == 0){
		//��й�ȣ Ʋ��
%>
		<script>
			alert("��й�ȣ�� ���� �ʽ��ϴ�.");
			history.go(-1);
		</script>
<%
	}else if(re == -1){
		//���� ����
%>
		<script>
			alert("������ �����Ͽ����ϴ�..");
			history.go(-1);
		</script>
<%
	}
%>