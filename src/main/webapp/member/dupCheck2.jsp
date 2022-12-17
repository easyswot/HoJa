<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");

MemberDAO memberDAO = new MemberDAO();

MemberDTO memberDTO = memberDAO.getMember(id);

if(id == "" || id.length() == 0) {
	%>아이디를 입력해주세요<%
	return;
}

if(memberDTO == null) {	// 아이디 없음
	%>아이디 사용 가능
	<script type="text/javascript">
	checkIdResult = true;
	</script>
	<%
} else {
	%>아이디 중복
	<script type="text/javascript">
	checkIdResult = false;
	</script>
	<%
}
%>