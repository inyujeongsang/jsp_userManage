<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.*" %>
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
		a, a:hover {
		color: #000000;
		text-decoration: none;
		}
  </style>
  <body>
  <%
  	String userID = null;
  if(session.getAttribute("userID")!=null){
	  userID = (String)session.getAttribute("userID");
  }
  int pageNumber = 1;
  if(request.getParameter("pageNumber")!=null){
	  pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
                    <li class="nav-item">
                        <a class="nav-link" href="main.jsp">메인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#">게시판</a>
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
                    <th scope="col">번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col">작성일</th>
                </tr>
            </thead>
            <tbody>
                <%
                	BbsDAO bbsDAO = new BbsDAO();
                	ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                	for(int i =0; i<list.size(); i++){
                %>
                <tr>
                	<td><%=list.get(i).getBbsID() %></td>
                	<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle() %></a></td>
                	<td><%=list.get(i).getUserID() %></td>
                	<td><%=list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분" %></td>
                </tr>
                <%
                	}
                %>
            </tbody>
	        </table>
	        <div class="d-flex justify-content-between my-4">
		        <%
		        	if(pageNumber!=1){
		        %>
		        	<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
		        <% 		
		        	} if(bbsDAO.nextPage(pageNumber + 1)){
	   	        %>
	        		<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-right">다음</a>
		        <% 		
		        	}
		        %>
		        <!-- 글쓰기 버튼 -->
		        <div>
		            <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
	        	</div>
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
