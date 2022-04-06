package Board.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
		String sql = "";
//		String sql = "insert into boardt(b_id, b_name, b_email, b_title, b_content, b_date, b_hit, b_pwd)" 
//					  + "values(?,?,?,?,?,?,?,?)";
		int re = -1;
		int count = 0;
		int id = board.getB_id();
		int ref = board.getB_ref();
		int step = board.getB_step();
		int level = board.getB_level();
	    
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
			//답글인지 아닌지 기준??b_id
			//B_ID == 0 : 글 작성
			//B_ID != 0 : 답글 작성
			//답글
			if(board.getB_id() != 0) {
				sql = "update boardt set b_step=b_step + 1 where b_ref=? and b_step > ?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, ref);
				pstm.setInt(2, step);
				pstm.executeUpdate();
				
				ref = board.getB_ref();
				step += 1;
				level +=1;
				
				sql = "insert into boardt values(?,?,?,?,?,?,?,?,?,?,?,?)";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1,count);
				pstm.setString(2,board.getB_name());
				pstm.setString(3,board.getB_email());
				pstm.setString(4,board.getB_title());
				pstm.setString(5,board.getB_content());
				pstm.setTimestamp(6,board.getB_date());
				pstm.setInt(7,board.getB_hit());
				pstm.setString(8,board.getB_pwd());
				pstm.setString(9,board.getB_ip());
				pstm.setInt(10,ref);
				pstm.setInt(11,step);
				pstm.setInt(12,level);
				
				pstm.executeUpdate();//UPDATE, DELETE
				re = 1;
			}else{
				//답글 아님
				ref= count;
				step = 0;
				level = 0;
				
				sql = "insert into boardt values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1,count);
				pstm.setString(2,board.getB_name());
				pstm.setString(3,board.getB_email());
				pstm.setString(4,board.getB_title());
				pstm.setString(5,board.getB_content());
				pstm.setTimestamp(6,board.getB_date());
				pstm.setInt(7,board.getB_hit());
				pstm.setString(8,board.getB_pwd());
				pstm.setString(9,board.getB_ip());
				pstm.setInt(10,count);
				pstm.setInt(11,step);
				pstm.setInt(12,level);
				pstm.setString(13,board.getB_fname());
				pstm.setInt(14,board.getB_fsize());
				
				pstm.executeUpdate();//UPDATE, DELETE
				re = 1;
			}
			
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
	
	public ArrayList<BoardBean> listBoard(String pageNumber){
		Connection conn = null;
		PreparedStatement pstm = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet pageSet = null; 
		
		int dbCount = 0; //글이 총 몇개인지?
		int absolutePage = 1; //첫 번째 게시글의 절대위치
		
		String sql = "select * from boardt order by b_ref desc, b_step asc";
		String sql2 = "select count(*) from boardt";

		ArrayList<BoardBean> list = new ArrayList<BoardBean>();
		try {
			conn = getConnection();
			
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(sql2);
			
			if(pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			//페이지 개수 설정 
			if(dbCount % BoardBean.pageSize == 0) {
				BoardBean.pageCount = dbCount / BoardBean.pageSize;
			}else {
				BoardBean.pageCount = dbCount / BoardBean.pageSize + 1;
			}
			
			//페이지 번호 설정
			if(pageNumber != null) {
				BoardBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1 =1, 2: 1*10+1 =11
				//페이지 단위로 끊기
				absolutePage = (BoardBean.pageNum -1) * BoardBean.pageSize +1;
			}
//전방향 에러 발생	
//			pstm = conn.prepareStatement(sql);
//			rs = pstm.executeQuery();
			
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
				while(count < BoardBean.pageSize) {
					BoardBean board = new BoardBean();
					board.setB_id(rs.getInt(1));
					board.setB_name(rs.getString(2));
					board.setB_email(rs.getString(3));
					board.setB_title(rs.getString(4));
					board.setB_content(rs.getString(5));
					board.setB_date(rs.getTimestamp(6));
					board.setB_hit(rs.getInt(7));
					board.setB_pwd(rs.getString(8));
					board.setB_ip(rs.getString(9));
					board.setB_ref(rs.getInt(10));
					board.setB_step(rs.getInt(11));
					board.setB_level(rs.getInt(12));
					board.setB_fname(rs.getString(13));
					board.setB_fsize(rs.getInt(14));
					
					
					list.add(board);
					
					if(rs.isLast()) {
						break;
					}else {
						rs.next();
					}
					count++;
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public BoardBean getBoard(int num, boolean check) {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		BoardBean board = new BoardBean();
		try {
			conn = getConnection();

			if(check == true) {
				sql = "update boardt set b_hit = b_hit + 1 where b_id=?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, num);
				rs = pstm.executeQuery();
				sql = "select * from boardt where b_id=?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, num);
				rs = pstm.executeQuery();
			}else{
				sql = "select * from boardt where b_id=?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, num);
				rs = pstm.executeQuery();
			}
				
			if(rs.next()) {
				board.setB_id(rs.getInt("b_id"));
				board.setB_name(rs.getString("b_name"));
				board.setB_title(rs.getString("b_title"));
				board.setB_content(rs.getString("b_content"));
				board.setB_date(rs.getTimestamp("b_date"));
				board.setB_hit(rs.getInt("b_hit"));
				board.setB_pwd(rs.getString("b_pwd"));
				board.setB_ip(rs.getString("b_ip"));
				board.setB_ref(rs.getInt("b_ref"));
				board.setB_step(rs.getInt("b_step"));
				board.setB_level(rs.getInt("b_level"));
				board.setB_fname(rs.getString("b_fname"));
				board.setB_fsize(rs.getInt("b_fsize"));
			}
			
			rs.close();
			pstm.close();
			conn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstm!=null) pstm.close();
				if(conn!=null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return board;
	}
	public int deleteBoard(int id, String pwd) throws Exception{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		
		int re = -1;

		try {
			conn = getConnection();
			pstm = conn.prepareStatement("select * from boardt where b_id=?");
			pstm.setInt(1, id);
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				if(pwd.equals(rs.getString("b_pwd"))) {
					pstm = conn.prepareStatement("delete from boardt where b_id=?");
					pstm.setInt(1, id);
					rs = pstm.executeQuery();
					re = 1;
				}else {
					re = 0;
				}
			}
			pstm.close();
			conn.close();
			System.out.println("삭제 성공");
		} catch (Exception e) {
			System.out.println("삭제 실패");
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
	public int editBoard(BoardBean board) throws Exception{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		int re = -1;

		try {
			conn = getConnection();
			pstm = conn.prepareStatement("select b_pwd from boardt where b_id=?");
			pstm.setInt(1, board.getB_id());
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(board.getB_pwd())) {
					pstm = conn.prepareStatement("update boardt set b_name=?, b_email=?, b_title=?, b_content=? where b_id=?");
					pstm.setString(1, board.getB_name());
					pstm.setString(2, board.getB_email());
					pstm.setString(3, board.getB_title());
					pstm.setString(4, board.getB_content());
					pstm.setInt(5, board.getB_id());
					pstm.executeUpdate();
					re = 1;
				}else {
					re = 0;
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("변경 실패");
		}
		pstm.close();
		conn.close();
		return re;
	}
}
