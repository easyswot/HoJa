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
<title>fcenter/fupdate.jsp</title>
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
String id=(String)session.getAttribute("id");
//세션값이 없으면 login.jsp
if(id==null){
	response.sendRedirect("../member/login.jsp");
}

int num=Integer.parseInt(request.getParameter("num"));
// BoardDAO 객체생성
BoardDAO boardDAO=new BoardDAO();
// getBoard()
BoardDTO boardDTO=boardDAO.getBoard(num);

%>
<article>
<h1>File Notice Update</h1>
<form action="fupdatePro.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=boardDTO.getNum()%>">
<table id="notice">
<tr><td>글쓴이</td>
	<td><input type="text" name="name" value="<%=id %>" readonly></td></tr>
<tr><td>제목</td>
	<td><input type="text" name="subject" value="<%=boardDTO.getSubject()%>"></td></tr>
<tr><td>파일</td>
	<td><input type="file" name="file">
		<input type="hidden" name="oldfile" value="<%=boardDTO.getFile()%>">
	<%=boardDTO.getFile()%>
	</td></tr>
<tr><td>내용</td>
	<td><textarea name="content" rows="10" cols="20"><%=boardDTO.getContent()%></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글수정" class="btn">
<input type="button" value="글목록" class="btn" onclick="location.href='fnotice.jsp'">
</div>
</form>

<div class="clear"></div>
<div id="page_control">
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