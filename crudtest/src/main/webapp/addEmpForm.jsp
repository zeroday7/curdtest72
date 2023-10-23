<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>직원추가</h1>
	<form action="<%=request.getContextPath()%>/addEmpAction.jsp">
		<table border="1">
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="empName">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">추가</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>