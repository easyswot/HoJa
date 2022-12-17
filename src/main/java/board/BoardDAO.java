package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	public Connection getConnection() throws Exception{
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public List getBoardList(int startRow, int pageSize) {
		List boardList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			
//			String sql="select * from board_01";
			
			// 최근글이 위로 올라오게 정렬 num 기준값을 내림차순으로 정렬
			// String sql="select * from board order by num desc";
			// 시작하는 행부터 10개(Mysql limit 시작행-1, 몇개)
			String sql="select * from board_01 order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// 첨부파일
				boardDTO.setFile(rs.getString("file"));
				
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return boardList;
	}
	
	public BoardDTO getBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDTO boardDTO=null;
		try {
			con=getConnection();
			
			String sql="select * from board_01 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				//첨부파일
				boardDTO.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return boardDTO;
	}
	
	public void insertBoard(BoardDTO boardDTO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			
			String sql="select max(num) from board_01";
			
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			int num=0;
			if(rs.next()) {
				num=rs.getInt("max(num)")+1;
			}
			
			sql="insert into board_01(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,now(),?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardDTO.getName());
			pstmt.setString(3, boardDTO.getPass());
			pstmt.setString(4, boardDTO.getSubject());
			pstmt.setString(5, boardDTO.getContent());
			pstmt.setInt(6, boardDTO.getReadcount());
			// board에 첨부파일 추가
			// alter table board_01
			// add file varchar(100);
			pstmt.setString(7, boardDTO.getFile());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
	
	public void updateBoard(BoardDTO boardDTO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			
			String sql="update board_01 set subject=?,content=?,file=? where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getSubject());
			pstmt.setString(2, boardDTO.getContent());
			//파일
			pstmt.setString(3, boardDTO.getFile());
			pstmt.setInt(4, boardDTO.getNum());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try{ rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try{ pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try{ con.close(); }catch(SQLException ex){}
		}
	}
	
	public void deleteBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			
			String sql="delete from board_01 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try{ rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try{ pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try{ con.close(); }catch(SQLException ex){}
		}
	}
	// 전체 글 개수 구하는 메서드
	public int getBoardCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from board_01";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try{ rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try{ pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try{ con.close(); }catch(SQLException ex){}
		}
		return count;
	}
	
	public void updateReadCount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			con=getConnection();
			
			String sql="update board_01 set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try{ rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try{ pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try{ con.close(); }catch(SQLException ex){}
		}
		
	}
	
	public List getFileList(int startRow, int pageSize) {
		List fileList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			
//			String sql="select * from board_01";
			
			// 최근글이 위로 올라오게 정렬 num 기준값을 내림차순으로 정렬
			// String sql="select * from board order by num desc";
			// 시작하는 행부터 10개(Mysql limit 시작행-1, 몇개)
			String sql="select * from board_01 where file is not null order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// 첨부파일
				boardDTO.setFile(rs.getString("file"));
				
				fileList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return fileList;
	}
	
	// 전체 파일 개수 구하는 메서드
	public int getFileCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(file) from board_01 where file is not null";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(file)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try{ rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try{ pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try{ con.close(); }catch(SQLException ex){}
		}
		return count;
	}
	
	public List getBoardList1(String keyWord, String search, int startRow,int pageSize) {
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List boardList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		System.out.println(keyWord+"/"+search); //값 제대로 넘어오는지 확인용
		try {
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			String sql="select * from board_01 ";
			if(keyWord.equals("Title")) {
				sql += "where subject like ? order by num desc limit ?,?";
			}else if(keyWord.equals("Content")) {
				sql += "where content like ? order by num desc limit ?,?";
			}else {
				sql += "where name like ? order by num desc limit ?,?";
			}
			
//			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
////			String sql="select * from board";
////			String sql="select * from board order by num desc"; limit는 시작하는 곳을 포함안함 그래서 -1 해줌
//			sql="select * from board order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
				// 데이터 있으면 true => 열접근
			while(rs.next()) {
				BoardDTO boardDTO=new BoardDTO();
				
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				
				
				// 파일 넣는거 없앴음 필요하면 추가

			
				//배열한칸에 글 정보 저장
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		System.out.println(boardList.size());// 검색해온 글전체 갯수 찍어봄
		return boardList;
		
	}
	
	public int getBoardCount1(String keyWord, String search) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		System.out.println(keyWord+"/"+search); //값 제대로 넘어오는지 확인용
		int count=0;
		try {
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			String sql="select count(*) from board_01 ";
			if(keyWord.equals("Title")) {
				sql += "where subject like ?";
			}else if(keyWord.equals("Content")) {
				sql += "where content like ?";
			}else {
				sql += "where name like ?";
			}
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
			System.out.println("개수 : " + count);	// 검색한 글의 개수가 몇개인지 출력
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return count;
		
	}
	
	public List getBoardList2(String keyWord, String search, int startRow,int pageSize) {
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List boardList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		System.out.println(keyWord+"/"+search); //값 제대로 넘어오는지 확인용
		try {
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			String sql="select * from board_01 ";
			if(keyWord.equals("Title")) {
				sql += "where subject like ? and file is not null order by num desc limit ?,?";
			}else if(keyWord.equals("Content")) {
				sql += "where content like ? and file is not null  order by num desc limit ?,?";
			}else {
				sql += "where name like ? and file is not null  order by num desc limit ?,?";
			}
			
//			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
////			String sql="select * from board";
////			String sql="select * from board order by num desc"; limit는 시작하는 곳을 포함안함 그래서 -1 해줌
//			sql="select * from board order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
				// 데이터 있으면 true => 열접근
			while(rs.next()) {
				BoardDTO boardDTO=new BoardDTO();
				
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				//파일 추가
				boardDTO.setFile(rs.getString("file"));

			
				//배열한칸에 글 정보 저장
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		System.out.println(boardList.size());// 검색해온 글전체 갯수 찍어봄
		return boardList;
		
	}
	
	public int getBoardCount2(String keyWord, String search) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		System.out.println(keyWord+"/"+search); //값 제대로 넘어오는지 확인용
		int count=0;
		try {
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			String sql="select count(*) from board_01 ";
			if(keyWord.equals("Title")) {
				sql += "where subject like ? and file is not null";
			}else if(keyWord.equals("Content")) {
				sql += "where content like ? and file is not null";
			}else {
				sql += "where name like ? and file is not null";
			}
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
			System.out.println("개수 : " + count);	// 검색한 글의 개수가 몇개인지 출력
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return count;
		
	}
	
	public List getPopularBoardList(int startRow, int pageSize) {
		List boardList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			
//			String sql="select * from board_01";
			
			// 최근글이 위로 올라오게 정렬 num 기준값을 내림차순으로 정렬
			// String sql="select * from board order by num desc";
			// 시작하는 행부터 10개(Mysql limit 시작행-1, 몇개)
			String sql="select * from board_01 order by readcount desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// 첨부파일
				boardDTO.setFile(rs.getString("file"));
				
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return boardList;
	}
	
	public List getBestFileList(int startRow, int pageSize) {
		List fileList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			
//			String sql="select * from board_01";
			
			// 최근글이 위로 올라오게 정렬 num 기준값을 내림차순으로 정렬
			// String sql="select * from board order by num desc";
			// 시작하는 행부터 10개(Mysql limit 시작행-1, 몇개)
			String sql="select * from board_01 where file is not null order by readcount desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// 첨부파일
				boardDTO.setFile(rs.getString("file"));
				
				fileList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return fileList;
	}
	
	
	
}// 클래스