<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

<script type="text/javascript">

// 전역변수 만들기
var checkIdResult = false;			// 아이디 중복확인 여부
var checkPassResult = false;		// 패스워드 검사
var checkRetypePassResult = false;	// 패스워드 확인 검사
var checkEmailResult = false;		// 이메일 입력 여부
var checkRetyleEmailResult = false;	// 이메일 확인 검사

// function idCheck() {
// 	var join = document.fr;
// 	var id = join.id.value;
// 	if(id == "" || id.length == 0) {
// 		alert("아이디를 입력해주세요.");
// 		join.id.focus();
// 		return;
// 	} else {
// 		alert("확인 완료");
// 		join.dup.value="idCheck";
// 		checkIdResult = true;
// 	}
// }

function idUncheck() {
	var join = document.fr;
	checkIdResult = false;
}

// 패스워드 보안강도 검사
function checkPass(pass1) {
	// 패스워드 검사를 위한 정규표현식 패턴 작성 및 검사 결과에 따른 변수값 변경
	var spanElem = document.getElementById("checkPassResult");
	
	// 정규표현식 패턴 정의
	var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;// 길이 및 사용 가능 문자 규칙
	var engUpperRegex = /[A-Z]/;	// 대문자
	var engLowerRegex = /[a-z]/;	// 소문자
	var numRegex = /[0-9]/;		// 숫자규칙
	var specRegex = /[!@#$%]/;	// 특수문자 규칙
	
	var count = 0; // 각 규칙별 검사 결과를 카운팅할 변수
	
	if(lengthRegex.exec(pass1)){ // 패스워드 길이 및 사용 가능 문자 규칙 통과 시
		spanElem.innerHTML = "사용 가능한 비밀번호";
		spanElem.style.color = "GREEN";
		
		// 각 규칙별 검사 후 해당 항목이 포함되어 있을 경우 카운트 증가
		if(engUpperRegex.exec(pass1))	count++;
		if(engLowerRegex.exec(pass1))	count++;
		if(numRegex.exec(pass1))		count++;
		if(specRegex.exec(pass1))		count++;
		
		switch(count){
		case 4: // 특수문자, 대문자, 소문자, 숫자 중 4개를 만족
			spanElem.innerHTML = "사용 가능한 비밀번호(안전)";
			spanElem.style.color = "GREEN";
			checkPassResult = true;
			break;
		case 3: // 특수문자, 대문자, 소문자, 숫자 중 3개를 만족
			spanElem.innerHTML = "사용 가능한 비밀번호(보통)";
			spanElem.style.color = "ORANGE";
			checkPassResult = true;
			break;
		case 2:	// 특수문자, 대문자, 소문자, 숫자 중 2개를 만족
			spanElem.innerHTML = "사용 가능한 비밀번호(위험)";
			spanElem.style.color = "ORANGERED";
			checkPassResult = true;
			break;
		default:
			spanElem.innerHTML = "영문자, 숫자, 특수문자 중 2가지 이상 조합 필수";
			spanElem.style.color = "RED";
			checkPassResult = false;
		}
	} else{
//			spanElem.innerHTML = "사용 불가능한 패스워드";
		spanElem.innerHTML = "영문자, 숫자, 특수문자 조합 8 ~ 16자리 필수";
		spanElem.style.color = "RED";
		checkPassResult = false;
		
	}
}

//패스워드 일치 여부 검사
function checkRetypePass(pass2) {
	var pass1 = document.fr.pass1.value;
	var spanElem = document.getElementById("checkRetypePassResult");
	if(pass1 == pass2){	// 패스워드 일치
		spanElem.innerHTML = "비밀번호 일치";
		spanElem.style.color = "GREEN";
		checkRetypePassResult = true;
	} else{	// 패스워드 불일치
		spanElem.innerHTML = "비밀번호 불일치";
		spanElem.style.color = "RED";
		checkRetypePassResult = false;
	}
}

function checkEmail1(email1) {
	
	var spanElem = document.getElementById("checkEmail1Result");
	var email1 = document.fr.email1.value;
	
	// 이메일 정규표현식
	var emailRegex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(!emailRegex.exec(email1)){
		spanElem.innerHTML = "올바른 이메일주소를 입력해주세요.";
		spanElem.style.color = "red";
	} else {
		checkEmailResult = true;
		spanElem.innerHTML = "";
	}
	
}

// 이메일 일치 여부 검사
function checkEmail2(email2) {
	
	var email1 = document.fr.email1.value;
	var spanElem = document.getElementById("checkEmail2Result");
	
	if(email1 == email2){	// 이메일 일치
		spanElem.innerHTML = "이메일이 일치합니다.";
		spanElem.style.color = "green";
		checkRetypeEmailResult = true;
	} else {	// 이메일 불일치
		spanElem.innerHTML = "이메일이 일치하지 않습니다.";
		spanElem.style.color = "red";
		checkRetypeEmailResult = false;
	}
}

function checkSubmit() {
	
	if(!checkIdResult) {
		alert("아이디 중복 확인 해주세요.");
		document.fr.id.focus();
		return false;
	} else if(!checkPassResult) {
		alert("비밀번호를 입력해주세요.");
		document.fr.pass1.focus();
		return false;
	} else if(!checkRetypePassResult) {
		alert("비밀번호 확인 해주세요.");
		document.fr.pass2.focus();
		return false;
	}else if(document.fr.name.value == "" || document.fr.name.value.length == 0){
		alert("이름을 입력해주세요.");
		document.fr.name.focus();
		return false;
	}else if(!checkEmailResult) {
		alert("이메일 주소를 입력해주세요.");
		document.fr.email1.focus();
		return false;
	} else if(document.fr.email2.value == "" || document.fr.email2.value.length == 0) {
		document.getElementById("checkEmail2Result").innerHTML = "이메일을 확인 해주세요.";
		document.getElementById("checkEmail2Result").style.color = "red";
		document.fr.email2.focus();
		return false;
	} else if(!checkRetypeEmailResult) {
		alert("이메일 확인 해주세요.");
		document.fr.email2.focus();
		return false;
	}
	return true;
	
// 	var join = document.fr;
// 	var id = join.id.value;
// 	var pass1 = join.pass1.value;
// 	var pass2 = join.pass2.value;
// 	var name = join.name.value;
// 	var email1 = join.email1.value;
// 	var email2 = join.email2.value;
	
// // 	var i1 = document.getElementById('id').value;
// 	if(id == "" || id.length == 0) {
// 		alert("아이디를 입력해주세요.");
// 		join.id.focus();
// 		return;
// 	}
	
// 	if(join.dup.value == "idUncheck") {
// 		alert("아이디 중복확인을 해주세요.");
// 		return;
// 	}
	
// // 	var n1 = document.getElementById('name').value;
// 	if(name == "" || name.length == 0) {
// 		alert("이름을 입력해주세요.");
// 		join.name.focus();
// 		return;
// 	}

}
</script>

<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// class="dup" 클릭했을 때
		$('.dup').click(function(){
// 			alert("클릭");
//			dupCheck.jsp 갈 때	class="id" val()을 들고 가서 아이디 중복체크 하고
//			그 결과를 가져와서 id="dupdiv"
			$.ajax({
				url:'dupCheck2.jsp',			// url:주소
				data:{'id':$('.id').val()},				// data:파라미터값
				success:function(rdata){
					$('#dupdiv').html(rdata).css('color', 'blue');
				}
			});
		});
	});
</script>

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member" style="margin: 9px 0 0 0;"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="joinPro.jsp" id="join" name="fr" method="post" onsubmit="return checkSubmit()"><!--  -->
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" id="id" onkeydown="idUncheck()">
<input type="button" value="ID중복확인" class="dup" ><br><!-- onclick="idCheck()" -->
<!-- <input type="hidden" name="dup" id="dup" value="idUncheck"> -->

<label></label><div id="dupdiv"></div><br>

<label>Password</label>
<input type="password" name="pass1" onkeyup="checkPass(this.value)">
<span id="checkPassResult"><!-- 패스워드 규칙 판별 결과 표시 영역 --></span><br>
<label>Retype Password</label>
<input type="password" name="pass2" onblur="checkRetypePass(this.value)">
<span id="checkRetypePassResult"><!-- 패스워드 일치 여부 표시 영역 --></span><br>



<label>Name</label>
<input type="text" name="name">
<span id="checkNameResult"><!-- 이름 입력 여부 표시 영역 --></span><br>
<label>E-Mail</label>
<input type="email" name="email1" onkeyup="checkEmail1(this.value)">
<span id="checkEmail1Result"></span><br>
<label>Retype E-Mail</label>
<input type="email" name="email2" onkeyup="checkEmail2(this.value)">
<span id="checkEmail2Result"><!-- 이메일 일치 여부 표시 영역 --></span><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>PostCode</label>
<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" readonly>
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
<label>Address</label>
<input type="text" name="address1" id="sample6_address" placeholder="주소" readonly><br><!--  -->
<input type="text" name="address2" id="sample6_detailAddress" placeholder="상세주소" size="17.5">
<input type="text" name="address3" id="sample6_extraAddress" placeholder="참고항목" size="17" readonly><br>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<!-- <label>Address</label> -->
<!-- <input type="text" name="address"><br> -->
<label>Phone Number</label>
<input type="text" name="phone"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>