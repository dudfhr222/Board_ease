<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id = "board" class = "Board.board.BoardBean"/>
<jsp:setProperty name = "board" property = "*"/>
<%
	SmartUpload upload = new SmartUpload();
	upload.initialize(pageContext);
	upload.upload();
	
	String fName = null;
	int fileSize = 0;
	
	File file = upload.getFiles().getFile(0);
	if(!(file.isMissing())){
		fName = file.getFileName();
		file.saveAs("/upload/"+file.getFileExt());
		fileSize = file.getSize();
	}
%>
<%
	response.setCharacterEncoding("UTF-8");
%>
<%
	BoardDBBean db = BoardDBBean.getInstance();
%>
<%	
	//일자
	board.setB_date(new Timestamp(System.currentTimeMillis()));	
	//IP
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();
	//board.setB_ip(request.getRemoteAddr());
	board.setB_ip(ip);
	//파일
	board.setB_name(upload.getRequest().getParameter("b_id"));
	board.setB_email(upload.getRequest().getParameter("b_email"));
	board.setB_title(upload.getRequest().getParameter("b_title"));
	board.setB_content(upload.getRequest().getParameter("b_content"));
	board.setB_pwd(upload.getRequest().getParameter("b_pwd"));
	board.setB_fname(fName);
	board.setB_fsize(fileSize);
%>
<% 
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