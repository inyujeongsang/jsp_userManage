<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<!-- 자바빈은 데이터를 저장하고 데이터에 접근하는 메서드(getter, setter)를 제공한다. -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope = "page"/>
<!-- 프로퍼티에 해당하는 setter가 호출되어 요청(request)에 있는 같은 이름의 파라미터 값으로 설정됨 -->
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 액션</title>
</head>
<body>
	<%
	/* 로그인 세션확인 */
	String userID = null;
	if(session.getAttribute("userID") !=null){ //세션ID 존재하면 userID에 값넣어줌.
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	} else{
		if(bbs.getBbsTitle() ==null || bbs.getBbsContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(),userID,bbs.getBbsContent());
			if(result == -1){ //DB오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else if(result == 1){//게시글 작성완료.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			} 
		}
	}
	
	
	
	
		
	%>
</body>
</html>