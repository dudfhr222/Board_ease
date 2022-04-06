<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
	int b_id = 0, b_ref = 1, b_step = 0, b_level = 0;
	String b_title="";
	
	if(request.getParameter("b_id")!=null){
		b_id = Integer.parseInt(request.getParameter("b_id"));
	}

	BoardDBBean dbm = BoardDBBean.getInstance();
	BoardBean board = dbm.getBoard(b_id, false);
	
	if(board != null){
		b_title = board.getB_title();
		b_ref = board.getB_ref();
		b_step = board.getB_step();
		b_level = board.getB_level();
	}
%>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <script type="text/javascript" src="board.js" charset="UTF-8"></script>
  </head>

  <body>
    <h1>글 올 리 기</h1>
    <form name="wt_frm" method="post" action="writeOk.jsp">
      <!-- value값 넘김 DBBEAN -->
				<input name = "b_id" type = "hidden" value = "<%= b_id %>">
				<input name = "b_ref" type = "hidden" value = "<%= b_ref %>">
				<input name = "b_step" type = "hidden" value = "<%= b_step %>">
				<input  name = "b_level" type = "hidden" value = "<%= b_level %>">
      <table border="1">
        <tr height="30">
          <td width="80">작성자</td>
          <td width="140">
            <input type="text" name="b_name" size="10" maxlength="20" />
          </td>
          <td width="80">이메일</td>
          <td width="240">
            <input type="text" name="b_email" size="24" maxlength="50" />
          </td>
        </tr>
        <tr height="30">
          <td width="80">글제목</td>
          <td colspan="3" width="460">
            <%
							if(b_id == 0){
						%> 
							<input type = "text" name = "b_title" size = "55" maxlength = "80">
						<%
							}else{
						%>
							<input type = "text" name = "b_title" size = "55" maxlength = "80"
									value = "[답변]:<%=b_title%>">
						<%
							}
						%>
          </td>
        </tr>
        <tr height = "30">
					<td width = "80">파일</td>
					<td colspan = "3" width = "140">
						<input type = "file" name="b_fname" size = "40" maxlength = "100">
					</td>
				</tr>
        <tr>
          <td colspan="4">
            <textarea cols="65" rows="10" name="b_content"></textarea>
          </td>
        </tr>
        <tr>
					<td>암 호</td>
					<td><input type = "password" name = "b_pwd" size = "12" maxlength = "12"></td>
				</tr>
        <tr height="50" align="center">
          <td colspan="4">
            <input type="button" value="글쓰기" onclick="check_ok()" />
            <input type="reset" value="다시작성" />
            <input type = "button" value = "글목록" onclick="javascript:window.location='list.jsp?pageNum=<%=pageNum%>'">
          </td>
        </tr>
      </table>
    </form>
  </body>
</html>
