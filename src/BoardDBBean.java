package magic.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {
	private static BoardDBBean instance=new BoardDBBean();
	public static BoardDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public int insertBoard(BoardBean board) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
//		String sql="insert into boardt(b_id, b_name, b_email, b_title, b_content) values(?,?,?,?,?)";
		int re=-1;
		int number;
		int id = board.getB_id();
		int ref = board.getB_ref();
		int step = board.getB_step();
		int level = board.getB_level();
		
		try {
			conn = getConnection();
			
			sql="select max(b_id) from boardt";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number=rs.getInt(1)+1;
			} else {
				number=1;
			}
			
			//if (board.getB_id() != 0) {
			if (id != 0) {
				sql="update boardt set b_step=b_step+1"
						+ " where b_ref=? and b_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();
				step=step+1;
				level=level+1;
			} else {
				ref=number;
				step=0;
				level=0;
			}
			
			sql="insert into boardt(b_id, b_name, b_email, b_title, b_content"
					+ ", b_date, b_pwd, b_ip, b_ref, b_step, b_level, b_fname, b_fsize, b_rfname) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			
			System.out.println("@@@### getB_name ===>"+board.getB_name());
			System.out.println("@@@### getB_title ===>"+board.getB_title());
			System.out.println("@@@### getB_content ===>"+board.getB_content());
			
			pstmt.setString(2, board.getB_name());
			pstmt.setString(3, board.getB_email());
			pstmt.setString(4, board.getB_title());
			pstmt.setString(5, board.getB_content());
			pstmt.setTimestamp(6, board.getB_date());
			pstmt.setString(7, board.getB_pwd());
			pstmt.setString(8, board.getB_ip());
			
			pstmt.setInt(9, ref);
			pstmt.setInt(10, step);
			pstmt.setInt(11, level);
			
			pstmt.setString(12, board.getB_fname());
			pstmt.setInt(13, board.getB_fsize());
			pstmt.setString(14, board.getB_rfname());
			pstmt.executeUpdate();
			
			re=1;
 			pstmt.close();
 			conn.close();
 			
			System.out.println("�߰� ����");
		} catch (Exception e) {
			System.out.println("�߰� ����");
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public ArrayList<BoardBean> listBoard(String pageNumber){
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		ResultSet pageSet=null;
		
		int dbCount=0;
		int absolutePage=1;
		
		String sql="select * from boardt order by b_ref desc, b_step asc";
		String sql2="select count(b_id) from boardt";
		
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(sql2);
			
			if (pageSet.next()) {
				dbCount = pageSet.getInt(1);
				pageSet.close();
			}
			
			if (dbCount % BoardBean.pageSize == 0) {	//80
				BoardBean.pageCount = dbCount / BoardBean.pageSize;
			} else {	//84
				BoardBean.pageCount = dbCount / BoardBean.pageSize + 1;
			}
			
			if (pageNumber != null) {
				BoardBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2: 1*10+1=11
				absolutePage = (BoardBean.pageNum - 1) * BoardBean.pageSize + 1;
			}
			
			//stmt = conn.createStatement();
 			rs = stmt.executeQuery(sql);
 			
 			if (rs.next()) {
				rs.absolute(absolutePage);
				int count = 0;
				
	 			while (count < BoardBean.pageSize) {
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
	 				
	 				boardList.add(board);
	 				
	 				if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
	 				
	 				count++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return boardList;
	}
	
	public BoardBean getBoard(int bid, boolean hitadd) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
//		String sql="select * from boardt where b_id=?";
		String sql="";
		BoardBean board=null;
		
		try {
			conn = getConnection();
			
			if (hitadd == true) {
				sql="update boardt set b_hit=b_hit+1 where b_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bid);
				pstmt.executeUpdate();
			}
			
			sql="select * from boardt where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board=new BoardBean();
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
				board.setB_rfname(rs.getString(15));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return board;
	}
	
	public int deleteBoard(int b_id, String b_pwd) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd="";
		int re=-1;
		
		try {
			conn = getConnection();
			sql="select b_pwd from boardt where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pwd = rs.getString(1);
				if (pwd.equals(b_pwd)) {
					sql="delete from boardt where b_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, b_id);
					pstmt.executeUpdate();
					re=1;
				}else {
					re=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public int editBoard(BoardBean board) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		String pwd="";
		int re=-1;
		
		try {
			conn = getConnection();
			sql="select b_pwd from boardt where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getB_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pwd = rs.getString(1);
				if (pwd.equals(board.getB_pwd())) {
					sql="update boardt set b_name=?, b_email=?, b_title=?, b_content=? where b_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, board.getB_name());
					pstmt.setString(2, board.getB_email());
					pstmt.setString(3, board.getB_title());
					pstmt.setString(4, board.getB_content());
					pstmt.setInt(5, board.getB_id());
					pstmt.executeUpdate();
					re=1;
				}else {
					re=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}
	
	public BoardBean getFileName(int bid) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select b_fname, b_rfname from boardt where b_id=?";
		BoardBean board=null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				board = new BoardBean();
				board.setB_fname(rs.getString(1));
				board.setB_rfname(rs.getString(2));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return board;
	}
}
