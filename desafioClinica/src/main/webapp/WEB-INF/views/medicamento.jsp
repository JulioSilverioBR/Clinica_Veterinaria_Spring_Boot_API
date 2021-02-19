<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<spring:url value="/medicamentos" var="home"></spring:url>
<spring:url value="/medicamentos/deleta/" var="deleta"></spring:url>
<spring:url value="/medicamentos/altera/" var="altera"></spring:url>
<spring:url value="/medicamentos/salva" var="salva"></spring:url>


<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
<link href='<spring:url value="/css/bootstrap.css" />'
	rel="stylesheet" />
<script src='<spring:url value="/js/jquery-3.4.1.min.js" />'></script>
<script src='<spring:url value="/js/bootstrap.js" />'></script>
<script src='<spring:url value="/js/jquery.mask.min.js" />'></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Cadastro Medicamento - Arcá de Nóe</title>
</head>
<body>

	<jsp:include page="${request.contextPath}/menu"></jsp:include>

			<div class="shadow-sm rounded text-center">
				<c:if test="${not empty mensagemErro }">
					<div id="divMensagemErro" class="alert alert-danger" role="alert">
						${mensagemErro }</div>
				</c:if>
				<c:if test="${not empty mensagemSucesso }">
					<div id="divMensagemSucesso" class="alert alert-success"
						role="alert">${mensagemSucesso }</div>
				</c:if>
			</div>
				<div class="pb-2 mt-4 mb-2 border-bottom">
					<!-- page header -->
					<h1 class="display-4 text-center">Cadastro de Medicamentos e Gestão</h1>
				</div>
				
				<div class="container mt-4">
				<form:form action="${salva }" cssClass="form" modelAttribute="medicamento" class="mb-2">
				
				<form:hidden path="codigo" />
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-capsule-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="Nome Do Medicamento" aria-label="Nome Do Medicamento" 
			  		aria-describedby="basic-addon1" name="nome" pattern="^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$" value="${medicamento.nome }" />
					</div>
				</div> 
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"><i class="ri-file-text-line"></i>
			   	     </span>
			  		</div>
			  			   <textarea required="required" placeholder="Descrição" minlength="20" maxlength="200" class="form-control" name="descricao" style="resize: none;" rows="3">${medicamento.descricao }</textarea>
					</div>
				</div> 
					
					<input type="submit" class=" btn btn-lg float-right mb-5 btn-outline-success " value="${empty medicamento.codigo ? 'Cadastrar' : 'Alterar' }" />
					<c:if test="${not empty medicamento.codigo}"><a class=" btn mb-5 float-left btn-outline-danger " href="${home}" >Cancelar alteração</a> </c:if>
				</form:form>
					
					
				
				<c:if test="${not empty medicamentos }">
					<hr style="margin-top: 9%">
					<h2 class="display-4  text-center">Medicamentos Cadastrados</h2>
					<table class="text-center table table-hover">
				
						<thead class="thead-dark">
							<tr>
								<th>Codigo</th>
								<th>Nome</th>
								<th>Descricao</th>
								<th colspan="2">Ações</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="medicamento" items="${medicamentos }">
								<tr>
									<td>${medicamento.codigo }</td>
									<td>${medicamento.nome }</td>
									<td>${medicamento.descricao }</td>
									<td><a href="${altera}${medicamento.codigo}"
										class="btn btn-outline-warning">Alterar</a></td>
										<td><a href="${deleta}${medicamento.codigo}"
										class="btn btn-outline-danger">Deletar</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				</div>
</body>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#divMensagemErro').delay(3500).fadeOut('slow');
			$('#divMensagemSucesso').delay(3500).fadeOut('slow');
		});
	</script>
</html>