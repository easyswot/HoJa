<%@page import="javax.print.DocFlavor.INPUT_STREAM"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fcontent.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center" style="margin: 18px 0 0 0; border-radius: 9px;"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Notice</a></li>
<li><a href="../fcenter/fnotice.jsp">File Download</a></li>
<li><a href="../gcenter/gnotice.jsp">Gallery</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
//int num파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
// BoardDAO 객체생성
BoardDAO boardDAO=new BoardDAO();
//조회수 1증가
boardDAO.updateReadCount(num);
// BoardDTO boardDTO = getBoard()메서드 호출
BoardDTO boardDTO=boardDAO.getBoard(num);
%>
<article>
<h1>File Notice Content</h1>
<table id="notice">
<tr><td>글번호</td><td><%=boardDTO.getNum()%></td>
	<td>글쓴날짜</td><td><%=boardDTO.getDate()%></td></tr>
<tr><td>글쓴이</td><td><%=boardDTO.getName()%></td>
	<td>조회수</td><td><%=boardDTO.getReadcount()%></td></tr>
<tr><td>제목</td><td colspan="3"><%=boardDTO.getSubject()%></td></tr>
<tr><td>파일</td><td colspan="3"><a href="../upload/<%=boardDTO.getFile()%>" download><%=boardDTO.getFile()%></a>
</td></tr>
<tr><td>내용</td><td colspan="3"><%=boardDTO.getContent()%></td></tr>
</table>
<div id="table_search">
<%
// 글수정 글삭제 => 로그인(세션값), 글쓴이 일치하면 글수정, 글삭제 버튼이 보이기
String id=(String)session.getAttribute("id");
if(id!=null) {
	if(id.equals(boardDTO.getName())) {
		%>
		<input type="button" value="글수정" class="btn" onclick="location.href='fupdate.jsp?num=<%=boardDTO.getNum()%>'">
		<input type="button" value="글삭제" class="btn" onclick="location.href='fdelete.jsp?num=<%=boardDTO.getNum()%>'">
		<%
	}
}
%>
<input type="button" value="글목록" class="btn"
	onclick="location.href='fnotice.jsp'">
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>