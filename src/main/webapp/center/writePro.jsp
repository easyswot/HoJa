<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/writePro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String pass=request.getParameter("pass");
String name=request.getParameter("name");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
int readcount=0;

BoardDTO boardDTO=new BoardDTO();

boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setReadcount(readcount);

BoardDAO boardDAO=new BoardDAO();

boardDAO.insertBoard(boardDTO);

response.sendRedirect("notice.jsp");
%>
</body>
</html>