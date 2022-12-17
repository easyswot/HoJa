<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/loginPro.jsp</title>
</head>
<body>
<%
//id pass 파라미터 가져오기
String id=request.getParameter("id");
String pass=request.getParameter("pass");
// MemberDAO 객체생성
MemberDAO memberDAO=new MemberDAO();
// MemberDTO memberDTO  = userCheck(id,pass) 메서드 호출
MemberDTO memberDTO=memberDAO.userCheck(id, pass);
// memberDTO !=null  아이디 비밀번호 일치 세션값생성 "id",id  ../main/main.jsp
// memberDTO ==!=null 아이디 비밀번호 틀림  메시지 , 뒤로이동
if(memberDTO!=null){
	//데이터 있으면 true => 아이디 비밀번호 일치
	// 페이지 상관없이 id값을 유지=> 세션값 저장 "id",id
	session.setAttribute("id", id);
	// 메인페이지 이동
	response.sendRedirect("../main/main.jsp");
}else{
	//데이터 없으면 false => 아이디 비밀번호 틀림
	// 아이디 비밀번호 틀림메시지 출력 , 뒤로이동
	%>
	<script type="text/javascript">
		alert("아이디 비밀번호 틀림");
		history.back();
	</script>
	<%
}
%>
</body>
</html>