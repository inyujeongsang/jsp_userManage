<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>JSP 게시판 페이지</title>
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
  <%
  	String userID = null;
  if(session.getAttribute("userID")!=null){
	  userID = (String)session.getAttribute("userID");
  }
  %>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">JSP 게시판 웹 사이트</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item active">
                        <a class="nav-link" href="main.jsp">메인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">게시판</a>
                    </li>
                </ul>
                <%
                	if(userID == null){
                %>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            계정
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
                            <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
                            <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
                        </ul>
                    </li>
                </ul>
                <%
                	} else {
               	%>
               	<ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            회원관리
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
                            <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
                        </ul>
                    </li>
                </ul>
               	<% 		
                	}
                %>
            </div>
        </div>
    </nav>
  	<div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3 p-3 bg-secondary-subtle my-5 rounded">
                <form class="p-3" action="loginAction.jsp">
	                <h2 class="text-center"><b>로그인</b></h2>
                    <div class="form-group py-2">
                        <label for="userID">아이디</label>
                        <input type="text" class="form-control" id="userID" name="userID" placeholder="아이디 입력">
                    </div>
                    <div class="form-group py-2">
                        <label for="userPassword">비밀번호</label>
                        <input type="password" class="form-control" id="userPassword" name="userPassword"placeholder="비밀번호 입력">
                    </div>
                    <button type="submit" class="btn btn-primary" style="float:right; margin-top:10px;">로그인</button>
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
