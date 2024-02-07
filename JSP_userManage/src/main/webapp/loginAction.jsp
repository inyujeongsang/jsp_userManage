<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<!-- 자바빈은 데이터를 저장하고 데이터에 접근하는 메서드(getter, setter)를 제공한다. -->
<jsp:useBean id="user" class="user.User" scope = "page"/>
<!-- 프로퍼티에 해당하는 setter가 호출되어 요청(request)에 있는 같은 이름의 파라미터 값으로 설정됨 -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 액션</title>
</head>
<body>
	<%
	/* 로그인 세션확인 */
	String userID = null;
	if(session.getAttribute("userID") !=null){ //세션ID 존재하면 userID에 값넣어줌.
		userID = (String)session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
	//0: 비밀번호 불일치
	//1 : 로그인 성공
	//-1: id없음 
	//-2:데이터베이스 오류
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(),user.getUserPassword());
		if(result == 1){
			session.setAttribute("userID",user.getUserID());//세션ID부여
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 성공.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>