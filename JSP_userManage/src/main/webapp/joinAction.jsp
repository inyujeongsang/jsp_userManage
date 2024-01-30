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
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 액션</title>
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
	
	
	if(user.getUserID() ==null || user.getUserPassword() == null || user.getUserName()==null
	||user.getUserGender()==null||user.getUserEmail()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		if(result == -1){ //DB오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == 0){//회원가입 완료.
			session.setAttribute("userID",user.getUserID());//세션ID부여
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} 
	}
	
	
	
		
	%>
</body>
</html>