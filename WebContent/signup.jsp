<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sign Up</title>
</head>
<body>
	<form method="POST" action="MakeAccount.jsp">
	<h1>Sign Up Page</h1>
		Username: 
		<input type="text" name="username"/> <p />
		
		Role:
		<select name="role">
			<option value="owner">Owner</option>
			<option value="customer">Customer</option>			
		</select> <p />
		
		Age: 
		<input type="text" name="age"/> <p />
		
		Select your state: 
		<select name="state">
			<option value="al">AL</option>
			<option value="ak">AK</option>
			<option value="az">AZ</option>
			<option value="ar">AR</option>
			<option value="ca">CA</option>
			<option value="co">CO</option>
			<option value="ct">CT</option>
			<option value="de">DE</option>
			<option value="dc">DC</option>
			<option value="fl">FL</option>
			<option value="ga">GA</option>
			<option value="hi">HI</option>
			<option value="id">ID</option>
			<option value="il">IL</option>
			<option value="ia">IA</option>
			<option value="in">IN</option>
			<option value="ks">KS</option>
			<option value="ky">KY</option>
			<option value="la">LA</option>
			<option value="me">ME</option>
			<option value="md">MD</option>
			<option value="ma">MA</option>
			<option value="mi">MI</option>
			<option value="mn">MN</option>
			<option value="ms">MS</option>
			<option value="mo">MO</option>
			<option value="mt">MT</option>
			<option value="ne">NE</option>
			<option value="nv">NV</option>
			<option value="nh">NH</option>
			<option value="nm">NM</option>
			<option value="my">MY</option>
			<option value="nc">NC</option>
			<option value="nd">ND</option>
			<option value="oh">OH</option>
			<option value="ok">OK</option>
			<option value="or">OR</option>
			<option value="pa">PA</option>
			<option value="ri">RI</option>
			<option value="sc">SC</option>
			<option value="sd">SD</option>
			<option value="tn">TN</option>
			<option value="tx">TX</option>
			<option value="ut">UT</option>
			<option value="vt">VT</option>
			<option value="va">VA</option>
			<option value="wa">WA</option>
			<option value="wv">WV</option>
			<option value="wi">WI</option>
			<option value="wy">WY</option>			
		</select> <p />
		
		<input type="submit" value="Click to signup"/>
	</form>
	
	<form method="GET" action="login.html">
	    <p /><p />Already have an account?
	    <input type="submit" value="Log in"/>
	</form>
</body>
</html>