<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
</head>
<body>
	<form method="POST" action="login.jsp">
        <h1>Login Failed</h1><p />
        <h3><%="The provided name " + session.getAttribute("invalidUsername").toString() + " is not known " %></h3>
        <input type=text name=loginUsername>
        <input type="submit" value="Login"/>
    </form>
</body>
</html>