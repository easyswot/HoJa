<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
// 세션값 가져오기
String id=(String)session.getAttribute("id");

if(id!=null){
	// 세션값이 있다 => 로그인 성공 => ..님 logout update
	%>
	<div id="login"><%=id %> 님 | <a href="../member/logout.jsp">logout</a> |
					<a href="../member/update.jsp">update</a></div>
	<%
}else{
	// 세션값이 없다 => 로그인 안함 => login join
	%>
	<div id="login"><a href="../member/login.jsp">login</a> |
					<a href="../member/join.jsp">join</a></div>
	<%
}
%>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/hoja_logo.png" width="265" height="62" alt="hoja"></a></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/welcome.jsp">ABOUT US</a></li><!-- COMPANY -->
	<li><a href="../center/notice.jsp">BOARD</a></li><!-- SOLUTIONS -->
	<li><a href="../fcenter/fnotice.jsp">FILE DOWNLOAD</a></li><!-- CONTACT US -->
	<li><a href="../gcenter/gnotice.jsp">GALLERY</a></li><!-- CUSTOMER CENTER -->
</ul>
</nav>
</header>