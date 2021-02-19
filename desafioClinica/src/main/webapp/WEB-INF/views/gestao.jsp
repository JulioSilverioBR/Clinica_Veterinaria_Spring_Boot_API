<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 
 <html>
 <head>
<spring:url value="/veterinarios" var="veterinarios"></spring:url>
 	
 <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<link href='<spring:url value="/css/gestao.css" />'rel="stylesheet" />
	<script src='<spring:url value="/js/jquery-3.4.1.min.js" />'></script>
	<script src='<spring:url value="/js/bootstrap.js" />'></script>
	<link href='<spring:url value="/css/bootstrap.css" />'rel="stylesheet" />
	<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
 </head>
 <body>
	<jsp:include page="${request.contextPath}/menu"></jsp:include>
	<h1 id="titulo" class="text-center display-4 mt-3 mb-1">Menu de Gestão</h1>
	<hr class="mb-4">
	<div id="panel">
		<ul class="menu">
		
			<a href="${veterinarios }">
			<li>
				<i class="ri-empathize-line"></i>
				<span class="title">Veterinarios</span> 
			</li>
			</a>
			
			<li onclick="location.href = '/donos';">
			<i class="ri-emotion-laugh-line"></i>
				<span class="title">Donos</span> 
			</li>
			
			<li onclick="location.href = '/animais';">
			<i class="ri-baidu-line"></i>
				<span class="title">Animais</span> 
			</li>
			
			<li onclick="location.href = '/consultas';">
			<i class="ri-clipboard-line"></i>
				<span class="title">Consultas</span> 
			</li> 
			
			<li  onclick="location.href = '/medicamentos';">
				<i class="ri-capsule-line"></i>
				<span class="title">Medicamentos</span> 
			</li> 
			
			<li  onclick="location.href = '/examesTratamento';">
				<i class="ri-health-book-line"></i>
				<span class="title">Exames e Tratamentos</span> 
			</li> 
			
		</ul>
	</div>
 </body>
 
 <c:if test="${usuarioLogado.authorities[0] eq 'ROLE_ADMIN' }">
 <script type="text/javascript">
	$(document).ready(function() {
	const Toast = Swal.mixin({
		  toast: true,
		  position: 'top',
		  showConfirmButton: false,
		  timer: 1200,
		  timerProgressBar: true,
		  didOpen: (toast) => {
		    toast.addEventListener('mouseenter', Swal.stopTimer)
		    toast.addEventListener('mouseleave', Swal.resumeTimer)
		  }
		})

		Toast.fire({
		  icon: 'success',
		  title: 'Logado com Sucesso'
		})
	});
 </script>
 </c:if>
 </html>