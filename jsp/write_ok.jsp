<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="magic.board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	/*
	SmartUpload upload = new SmartUpload();
	upload.initialize(pageContext);
	upload.upload();
	String fName=null;
	int fileSize=0;
	
	File file = upload.getFiles().getFile(0);
	
	if(!file.isMissing()){
		fName = file.getFileName();
		file.saveAs("/upload/"+file.getFileName());
		fileSize = file.getSize();
	}
	*/
	
	String path = request.getRealPath("upload");
	int size=1024*1024;
	int fileSize=0;
	String file="";
	String oriFile="";
	
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	Enumeration files = multi.getFileNames();
	String str = (String) files.nextElement();
	file = multi.getFilesystemName(str);
	
	if(file != null){
		oriFile = multi.getOriginalFileName(str);
		fileSize = file.getBytes().length;
	}
%>
<%
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();
	
	/*
	board.setB_name(upload.getRequest().getParameter("b_name"));
	board.setB_email(upload.getRequest().getParameter("b_email"));
	board.setB_title(upload.getRequest().getParameter("b_title"));
	board.setB_content(upload.getRequest().getParameter("b_content"));
	board.setB_pwd(upload.getRequest().getParameter("b_pwd"));
	*/
	board.setB_name(multi.getParameter("b_name"));
	board.setB_email(multi.getParameter("b_email"));
	board.setB_title(multi.getParameter("b_title"));
	board.setB_content(multi.getParameter("b_content"));
	board.setB_pwd(multi.getParameter("b_pwd"));
	
	//board.setB_ip(request.getRemoteAddr());
	board.setB_ip(ip);
	board.setB_date(new Timestamp(System.currentTimeMillis()));
	
	//board.setB_fname(fName);
	//board.setB_fsize(fileSize);
	if(file != null){
		board.setB_fname(file);
		board.setB_fsize(fileSize);
		board.setB_rfname(oriFile);
	}

	BoardDBBean db = BoardDBBean.getInstance();
	//db.insertBoard(board);
	
	if(db.insertBoard(board) == 1){
		response.sendRedirect("list.jsp");
	}else{
		response.sendRedirect("write.jsp");
	}
%>