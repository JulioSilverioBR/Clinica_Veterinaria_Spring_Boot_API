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
<spring:url value="/animais" var="home"></spring:url>
<spring:url value="/animais/deleta/" var="deleta"></spring:url>
<spring:url value="/animais/altera/" var="altera"></spring:url>
<spring:url value="/animais/salva" var="salva"></spring:url>


<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
<link href='<spring:url value="/css/bootstrap.css" />'
	rel="stylesheet" />
<script src='<spring:url value="/js/jquery-3.4.1.min.js" />'></script>
<script src='<spring:url value="/js/bootstrap.js" />'></script>
<script src='<spring:url value="/js/jquery.mask.min.js" />'></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Cadastro Animal - Arcá de Nóe</title>
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
					<h1 class="display-4 text-center">Cadastro de Animais e Gestão</h1>
				</div>
				
				<div class="container mt-4">
				<form:form action="${salva }" cssClass="form" modelAttribute="animal" class="mb-2">
				
				<form:hidden path="codigo" />
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-baidu-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="Nome Do Animal" aria-label="Nome Do Animal" 
			  		aria-describedby="basic-addon1" name="nomeAnimal" pattern="^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$" value="${animal.nomeAnimal }" />
					</div>
				</div> 
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"><i class="ri-github-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="Especie" aria-label="Especie" 
			  		aria-describedby="basic-addon1" pattern="^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$" name="especie.especie" value="${animal.especie.especie}" />
					</div>
				</div> 
				
				<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1">  <i class="ri-dossier-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="Raça" aria-label="Raça" 
			  		aria-describedby="basic-addon1" pattern="^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$" name="raca.raca" value="${animal.raca.raca}" />
			  		</div>
			  		</div>

		<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-calendar-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text" min="3"  pattern="[0-9]+$" required="required" class="form-control" placeholder="Idade" aria-label="Idade" 
			  		aria-describedby="basic-addon1" name="idade" value='<c:choose><c:when test="${animal.idade == 0}"></c:when><c:otherwise>${animal.idade}</c:otherwise></c:choose>' />
					</div>
				</div>
				
					<div class="form-group">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Dono&nbsp;<i class="ri-open-arm-line"></i></label>
				 </div>
				  	
				  <select id="donos" required="required" class="custom-select" id="inputGroupSelect01" name="dono.id">
				  <c:forEach var="dono" items="${donos}">
				    <option ${animal.dono.id == dono.id ? 'selected' : ''} value="${dono.id}">${dono.nome}</option>
				  </c:forEach>
				  </select>
				  
				</div>
				</div>
					
					<c:if test="${empty animal.codigo}">
							<script type="text/javascript">
								$("#donos").prop("selectedIndex", -1);
							</script>
					</c:if>
					
					<input type="submit" class=" btn btn-lg float-right mb-5 btn-outline-success " value="${empty animal.codigo ? 'Cadastrar' : 'Alterar' }" />
					<c:if test="${not empty animal.codigo}"><a class=" btn mb-5 float-left btn-outline-danger " href="${home}" >Cancelar alteração</a> </c:if>
				</form:form>
					
					
				
				<c:if test="${not empty animais }">
					<hr style="margin-top: 9%">
					<h2 class="display-4  text-center">Donos Cadastrados</h2>
					<table class="text-center table table-hover">
				
						<thead class="thead-dark">
							<tr>
								<th>Codigo</th>
								<th>Nome</th>
								<th>Especie</th>
								<th>Raça</th>
								<th>Idade</th>
								<th>Dono</th>
								<th>Ações</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="animal" items="${animais }">
								<tr>
									<td>${animal.codigo }</td>
									<td>${animal.nomeAnimal }</td>
									<td>${animal.especie.especie }</td>
									<td>${animal.raca.raca }</td>
									<td>${animal.idade }</td>
									<td>${animal.dono.nome }</td>
									<td><a href="${altera}${animal.codigo}"
										class="btn btn-outline-warning">Alterar</a></td>
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