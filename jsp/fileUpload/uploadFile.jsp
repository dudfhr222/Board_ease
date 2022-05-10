<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	SmartUpload upload = new SmartUpload();
	upload.initialize(pageContext);
	upload.upload();
	int last = upload.getFiles().getCount();
	int cnt = 0;
	
	for(int i=0; i<last; i++){
		File file = upload.getFiles().getFile(i);
		
		if(!file.isMissing()){
			file.saveAs("/upload/"+file.getFileName());
			
			out.println("폼 태그 필드 이름 : "+file.getFieldName()+"<br>");
			out.println("파일 이름 : "+file.getFileName()+"<br>");
			out.println("파일 크기 : "+file.getSize()+"<br>");
			out.println("파일 확장자 : "+file.getFileExt()+"<br>");
			out.println("파일 경로 : "+file.getFilePathName()+"<br>");
			out.println("<br>===============================<br>");
			
			cnt++;
		}
	}
	
	out.println("파일 "+cnt+" 개를 업로드 했습니다.");
%>