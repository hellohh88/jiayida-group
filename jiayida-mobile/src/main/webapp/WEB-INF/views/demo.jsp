<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Demo Page</title>
</head>
<body>
<h1>Hello ${name}</h1>
<table>
	<tr>
		<th>手机名称</th>
		<th>手机价钱</th>
	</tr>
<c:forEach items="${items}" var="item">
	<tr>
		<td>${item.name}</td>
		<td>${item.price}</td>
	</tr>	
</c:forEach>
</table>
</body>
</html>