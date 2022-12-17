<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fupdatePro.jsp</title>
</head>
<body>
<%
//한글처리
// request.setCharacterEncoding("utf-8");
// 파일업로드 => MultipartRequest 객체 생성//upload폴더 만들기
String uploadPath=request.getRealPath("/upload");
int maxSize=10*1024*1024;
MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

//multi에 num name subject content oldfile file 파라미터 가져오기
int num=Integer.parseInt(multi.getParameter("num"));
String name=multi.getParameter("name");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
//file 파라미터 가져오기
String file=multi.getFilesystemName("file");
//if file 없으면 oldfile 가져오기 
if(file==null){
	file=multi.getParameter("oldfile");
}

// BoardDTO() 객체생성
BoardDTO boardDTO=new BoardDTO();
// set메서드 호출 파라미터값 저장
boardDTO.setNum(num);
boardDTO.setName(name);
boardDTO.setSubject(subject);
boardDTO.setContent(content);

//파일저장
boardDTO.setFile(file);

// BoardDAO 객체생성
BoardDAO boardDAO = new BoardDAO();
// 리턴할 형 없음 updateBoard(BoardDTO boardDTO)
// updateBoard(boardDTO)호출
boardDAO.updateBoard(boardDTO);

// notice.jsp이동
response.sendRedirect("fnotice.jsp");
%>
</body>
</html>