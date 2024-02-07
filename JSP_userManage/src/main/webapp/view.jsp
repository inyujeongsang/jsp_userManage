<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %> <!-- 데이터베이스 접근객체 -->
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>JSP 게시판 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  </head>
  <body>
  <%
    String userID = null;
  if(session.getAttribute("userID")!=null){
      userID = (String)session.getAttribute("userID");
  }
  int bbsID = 0;
  if(request.getParameter("bbsID") != null){
      bbsID = Integer.parseInt(request.getParameter("bbsID"));
  }
  if(bbsID == 0){
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('유효하지 않은 글입니다.')");
      script.println("location.href = 'bbs.jsp'");
      script.println("</script>");
  }
  //유효한 글이라면 구체적인 정보를 bbs 인스턴스에 담아줌.
  Bbs bbs = new BbsDAO().getBbs(bbsID);
  
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
        <table class="table">
            <thead>
                <tr>
                    <th colspan="3" scope="col">게시판 글 보기</th>
                </tr>
            </thead>
            <tbody>
                <!-- 글 제목 -->
                <tr>
                    <td style="width: 20%">글 제목</td>
                    <td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></td>
                </tr>
                <tr>
                    <td>작성자</td>
                    <td colspan="2"><%= bbs.getUserID()%></td>
                </tr>
                <tr>
                    <td>작성일자</td>
                    <td colspan="2"><%=bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
                </tr>
                <tr>
                    <td>내용</td>
                   <td colspan="2">
					    <div style="min-height: 200px; text-align: left;">
					        <%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%>
					    </div>
					</td>

                </tr>
            </tbody>
        </table>
        <div class="d-flex justify-content-between my-4">
	        <div>
		        <a href="bbs.jsp" class="btn btn-primary">목록</a>
		        <!-- 사용자가 글작성자와 동일하다면 수정할 수 있는 버튼을 보여줌 -->
		        <%
		        	if(userID != null && userID.equals(bbs.getUserID())){
		        %>		
		        		<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
		        		<a onclick="return confirm('정말 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
		        <%
		        	}
		        %>
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
