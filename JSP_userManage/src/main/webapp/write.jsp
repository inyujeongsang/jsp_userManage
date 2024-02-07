<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
//   if (useID == null){
	  
//   }
  %>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">JSP 게시판 웹 사이트</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="main.jsp">메인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="write.jsp">게시판</a>
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
    <div class="container mt-5">
        <h2>게시판</h2>
        <form method="post" action="writeAction.jsp">
        <table class="table">
            <thead>
                <tr>
                    <th colspan="2" scope="col">게시판 글쓰기 양식</th>
                </tr>
            </thead>
            <tbody>
                <!-- 글 제목 -->
	            <tr>
	                <td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
	            </tr>
	            <!-- 글 내용 -->
	            <tr>
	                <td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px;"></textarea></td>
	            </tr>
            </tbody>
        </table>
        <!-- 글쓰기 버튼 -->
        <div class="d-flex justify-content-end">
            <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
        </div>
        </form>
    </div>
    
    
    
  
 	<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
  </body>
</html>
