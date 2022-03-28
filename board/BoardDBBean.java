package Board.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();
	
	public static BoardDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int InsertBoard(BoardBean board) throws Exception{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "insert into boardt values(?,?,?,?,?,?)";
		int re = -1;
		int count = 0;

		try {
			conn = getConnection();
			//글 번호 부여
			pstm = conn.prepareStatement("select max(b_id) from boardt");
			rs = pstm.executeQuery();//SELECT
			
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}else {
				count = 1;
			}
			//입력값 삽입
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1,count);
			pstm.setString(2,board.getB_name());
			pstm.setString(3,board.getB_email());
			pstm.setString(4,board.getB_title());
			pstm.setString(5,board.getB_content());
			pstm.setTimestamp(6,board.getB_date());
			
			pstm.executeUpdate();//UPDATE, DELETE
			
			re = 1;
			pstm.close();
			conn.close();
			System.out.println("추가 성공");
		} catch (Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		}finally {
			try {
				if(pstm != null) pstm.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
	public ArrayList<BoardBean> listBoard(){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "select * from boardt order by b_id";
		ArrayList<BoardBean> list = new ArrayList<BoardBean>();
		
		try {
			conn = getConnection();
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				BoardBean board = new BoardBean();
				board.setB_id(rs.getInt(1));
				board.setB_name(rs.getString(2));
				board.setB_email(rs.getString(3));
				board.setB_title(rs.getString(4));
				board.setB_content(rs.getString(5));
				board.setB_date(rs.getTimestamp(6));
				list.add(board);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public BoardBean getBoard(int num) {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		BoardBean board = new BoardBean();
		
		try {
			conn = getConnection();
			sql = "select * from boardt where b_id=?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, num);
			rs = pstm.executeQuery();
			
			board.setB_id(rs.getInt("b_id"));
			board.setB_name(rs.getString("b_name"));
			board.setB_title(rs.getString("b_title"));
			board.setB_content(rs.getString("b_content"));
			board.setB_date(rs.getTimestamp("b_date"));
			
			rs.close();
			pstm.close();
			conn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}
	
	
}
