<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HoJa | 오하</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

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
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img" style="background-image: none; height: 360px;"><img src="../images/dfaf.jpg"
 width="971" height="360" style="border-radius: 9px;"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">Best</span> picture</h3>
<%
//BoardDAO 객체생성
BoardDAO boardDAO=new BoardDAO();
//한 페이지에 보여줄(가져올) 글 개수 설정
int pageSize=3;

//시작하는 행
int startRow=1;

List bestFileList=boardDAO.getBestFileList(startRow, pageSize);
%>
<table>
<%
for(int i=0; i<bestFileList.size();i++){
	BoardDTO boardDTO=(BoardDTO)bestFileList.get(i);
	%>
	<td onclick="location.href='../gcenter/gcontent.jsp?num=<%=boardDTO.getNum() %>'" style="padding: 0 5px 0 5px;">
		<a href="../gcenter/gcontent.jsp?num=<%=boardDTO.getNum() %>">
			<img src="../upload/<%=boardDTO.getFile() %>" width="125" height="125">
		</a><br>
		<%=boardDTO.getSubject() %>
	</td>
    <%
}

%>
</table>
</div>
<div id="news_notice">
<h3 class="brown">Popular Post</h3><!-- News &amp; Notice -->
<table>
<%

//BoardDAO 객체생성
boardDAO=new BoardDAO();
//한 페이지에 보여줄(가져올) 글 개수 설정
pageSize=5;

//시작하는 행
startRow=1;

List popularList=boardDAO.getPopularBoardList(startRow, pageSize);
%>
<table>
<%
for(int i=0; i<popularList.size();i++){
	BoardDTO boardDTO=(BoardDTO)popularList.get(i);
	if(boardDTO.getFile()!=null){
		%>
		<tr onclick="location.href='../gcenter/gcontent.jsp?num=<%=boardDTO.getNum()%>'">
		<%
	} else {
		%>
		<tr onclick="location.href='../center/content.jsp?num=<%=boardDTO.getNum()%>'">
		<%
	}
	%>
	<td class="contxt"><a><%=boardDTO.getSubject()%></a></td>
  	<td><%=boardDTO.getContent() %></td></tr>
  <%
}

// List boardList=boardDAO.getBoardList(startRow, pageSize);
// SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy.MM.dd");
// for(int i=0; i<boardList.size();i++){
// 	BoardDTO boardDTO=(BoardDTO)boardList.get(i);
// 	if(boardDTO.getFile()!=null){
		%>
<%-- 		<tr onclick="location.href='../gcenter/gcontent.jsp?num=<%=boardDTO.getNum()%>'"> --%>
		<%
// 	} else {
		%>
<%-- 		<tr onclick="location.href='../center/content.jsp?num=<%=boardDTO.getNum()%>'"> --%>
		<%
// 	}
	%>
<%-- 	<td class="contxt"><a><%=boardDTO.getSubject()%></a></td> --%>
<%--     	<td><%=dateFormat.format(boardDTO.getDate()) %></td></tr> --%>
    <%
// }
%>
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>