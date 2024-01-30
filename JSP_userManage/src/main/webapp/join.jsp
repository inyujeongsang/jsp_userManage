<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>JSP login페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  </head>
  <style>
  	/* 네비게이션 바의 드롭다운 메뉴 위치 조정 */
		.navbar-nav .dropdown-menu {
		    position: absolute;
		    right: 0;
		    overflow-x: hidden;
		}
  </style>
  <body>
  	<div class="container">
	    <div class="row">
	        <div class="col-md-6 offset-md-3 p-3 bg-secondary-subtle my-5 rounded">
	            <form class="p-3" action="joinAction.jsp">
	                <h2 class="text-center"><b>회원가입</b></h2>
	                <div class="form-group py-2">
	                    <label for="userID">아이디</label>
	                    <input type="text" class="form-control" id="userID" name="userID" placeholder="아이디 입력" required>
	                </div>
	                <div class="form-group py-2">
	                    <label for="userPassword">비밀번호</label>
	                    <input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="비밀번호 입력" required>
	                </div>
	                <div class="form-group py-2">
	                    <label for="userName">이름</label>
	                    <input type="text" class="form-control" id="userName" name="userName" placeholder="이름 입력" required>
	                </div>
	                <div class="form-group py-2">
	                    <label>성별</label>
	                    <div>
	                        <input type="radio" id="male" name="userGender" value="male" required>
	                        <label for="male">남자</label>
	                        <input type="radio" id="female" name="userGender" value="female" required>
	                        <label for="female">여자</label>
	                    </div>
	                </div>
	                <div class="form-group py-2">
	                    <label for="userEmail">이메일</label>
	                    <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="이메일 입력" required>
	                </div>
	                <button type="submit" class="btn btn-primary" style="float:right; margin-top:10px;">회원가입</button>
	            </form>
	        </div>
	    </div>
	</div>
 	<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
  </body>
</html>
