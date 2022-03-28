<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <script type="text/javascript" src="board.js" charset="UTF-8"></script>
  </head>

  <body>
    <h1>글 올 리 기</h1>
    <form name="wt_frm" method="post" action="writeOk.jsp">
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
            <input type="text" name="b_title" size="55" maxlength="80" />
          </td>
        </tr>
        <tr>
          <td colspan="4">
            <textarea cols="65" rows="10" name="b_content"></textarea>
          </td>
        </tr>
        <tr height="50" align="center">
          <td colspan="4">
            <input type="button" value="글쓰기" onclick="check_ok()" />
            <input type="reset" value="다시작성" />
            <input
              type="button"
              value="글목록"
              onclick="javascript:window.location='list.jsp'"
            />
          </td>
        </tr>
      </table>
    </form>
  </body>
</html>
