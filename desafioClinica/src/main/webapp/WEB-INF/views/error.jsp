<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Falha de acesso</title>
	
	<link href='<spring:url value="/css/bootstrap.css" />' rel="stylesheet" />
    <script src='<spring:url value="/js/jquery-3.4.1.min.js" />' ></script> 
    <script src='<spring:url value="/js/bootstrap.js" />' ></script>
</head>
<body>
	<div class="container py-5">
		<div class="row">
			<div class="col-md-12 text-center">
				<h3 class="display-4 ">Problema Imprevisto</h3>
				<p>
					Desculpe, seu acesso foi negado pelas nossas políticas de segurança ou você se perdeu no caminho<br />
					Por favor volte a tela anterior e continue navegando.
				</p>
				<img class="img-fluid h-50" src="/img/error.jpg"><br>
				<a class="btn btn-outline-danger btn-lg mt-3" href="/">Voltar</a>
			</div>
		</div>
	</div>
</body>
</html>