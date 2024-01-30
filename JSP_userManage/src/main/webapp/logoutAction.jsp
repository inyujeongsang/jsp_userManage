<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 액션</title>
</head>
<body>
	<%
	session.invalidate(); //세션 뺏는다.
	%>
<script>
	location.href = 'main.jsp';
</script>
</body>
</html>