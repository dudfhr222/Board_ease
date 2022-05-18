package com.javalec.spring_mvc_board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.javalec.spring_mvc_board.dto.BDto;

public class BDao {
    DataSource dataSource;

    public BDao() {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/oracle");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close(Connection conn, PreparedStatement pstm, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        close(conn, pstm);
    }

    public void close(Connection conn, PreparedStatement pstm) {
        if (pstm != null) {
            try {
                pstm.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public ArrayList<BDto> list() {
        ArrayList<BDto> dtos = new ArrayList<BDto>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dataSource.getConnection();
            String sql = "select bId ,bName ,bTitle ,bContent ,bDate ,bHit from mvc_board order by bId desc";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int bId = rs.getInt("bId");
                String bName = rs.getString("bName");
                String bTitle = rs.getString("bTitle");
                String bContent = rs.getString("bContent");
                Timestamp bDate = rs.getTimestamp("bDate");
                int bHit = rs.getInt("bHit");

                BDto dto = new BDto(bId, bName, bTitle, bContent, bDate, bHit);
                dtos.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn,pstmt,rs);
        }

        return dtos;
    }

    public void write(String bName, String bTitle, String bContent) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dataSource.getConnection();
			String sql = "insert into mvc_board(bId ,bName ,bTitle ,bContent ,bHit) values(mvc_board_seq.nextval, ?, ?, ?, 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bName);
			pstmt.setString(2, bTitle);
			pstmt.setString(3, bContent);
			int rn = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
	}

    public BDto contentView(String strID) {
        upHit(strID); //bHit 증가
        BDto dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dataSource.getConnection();
            String sql = "select bId, bName, bTitle, bContent, bDate, bHit from mvc_board where bId=? order by bId desc";
			pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,Integer.parseInt(strID));
			rs = pstmt.executeQuery();
			if(rs.next()){
				//case1
				/*dto = new BDto();
				dto.setbId(rs.getInt("bID"));
				dto.setbName(rs.getString("bName"));
				dto.setbTitle(rs.getString("bTitle"));
				dto.setbContent(rs.getString("bContent"));
				dto.setbDate(rs.getTimestamp("bDate"));
				dto.setbHit(rs.getInt("bHit"));
				*/

				//case2
				int bId = rs.getInt("bID");
				String bName = rs.getString("bName");
				String bTitle = rs.getString("bTitle");
				String bContent = rs.getString("bContent");
				Timestamp bDate = rs.getTimestamp("bDate");
				int bHit = rs.getInt("bHit");
				dto = new BDto(bId, bName, bTitle, bContent, bDate, bHit);
			}
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
			close(conn,pstmt,rs);
        }
		return dto;
    }
    private void upHit(String bId){
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = dataSource.getConnection();
            String sql = "update mvc_board set bHit = bHit +1 where bId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,Integer.parseInt(bId));
            int rn = pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn,pstmt);
        }
    }

    public BDto mofidy(String bId, String bName, String bTitle, String bContent){
        BDto dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = dataSource.getConnection();
            String sql = "update mvc_board set bName=?, bTitle=?, bContent=? where bId=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,bName);
            pstmt.setString(2,bTitle);
            pstmt.setString(3,bContent);
            pstmt.setInt(4,Integer.parseInt(bId));
            int re = pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn,pstmt);
        }
        return dto;
    }

    public void delete(String bId){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = dataSource.getConnection();
            String sql = "delete from mvc_board where bId=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,Integer.parseInt(bId));
            pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn,pstmt,rs);
        }
    }
}
