<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	InputStream is = request.getInputStream();
	BufferedReader br = new BufferedReader(new InputStreamReader(is));
	String str = null;
	
	while((str = br.readLine()) != null){
%>
		<%= str %>
<%
	}
%>