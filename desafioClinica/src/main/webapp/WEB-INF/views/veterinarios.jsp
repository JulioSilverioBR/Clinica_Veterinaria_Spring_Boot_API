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

<title>Cadastro Veterinário - Arcá de Nóe</title>

<spring:url value="/veterinarios/" var="home"></spring:url>
<spring:url value="/veterinarios/altera/" var="altera"></spring:url>
<spring:url value="/veterinarios/salva" var="salva"></spring:url>

<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
<link href='<spring:url value="/css/bootstrap.css" />'
	rel="stylesheet" />
<script src='<spring:url value="/js/jquery-3.4.1.min.js" />'></script>
<script src='<spring:url value="/js/bootstrap.js" />'></script>
<script src='<spring:url value="/js/jquery.mask.min.js" />'></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<%@ page import="com.qintess.clinica.model.VeterinarioDisponibilidade" %>
<%@ page import="com.qintess.clinica.model.VeterinarioEspecializacao" %>

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
					<h1 class="display-4 text-center">Cadastro de Veterinarios e Gestão</h1>
				</div>
				<div class="container mt-4">

				<form:form action="${salva }" cssClass="form" modelAttribute="veterinario" class="mb-2">
				
				<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-briefcase-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text" ${not empty veterinario.crv ? 'disabled' : ''} min="3"  required="required" class="form-control"  pattern="[0-9]+$" placeholder="CRV Do Veterinario" aria-label="CRV Do Veterinario" 
			  		aria-describedby="basic-addon1"  name="crv" value='${veterinario.crv}'/>  
					</div>
				</div> 
				<form:hidden path="crv" />
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-user-2-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="Nome Do Veterinario" aria-label="Nome Do Veterinario" 
			  		aria-describedby="basic-addon1" name="nome" pattern="^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$" value="${veterinario.nome }" />
					</div>
				</div> 
				
				<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-home-4-line"></i>
			   	     </span>
			  		</div>
			  		
					<input id="cep" placeholder="CEP" class="form-control" type="text"/>
			  		<input type="text"  min="3" required="required" class="form-control w-75" placeholder="Endereço" aria-label="Endereço" 
			  		aria-describedby="basic-addon1" name="endereco" id="endereco" value="${veterinario.endereco }" />
					</div>
					
				</div>


		<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-phone-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text" id="txttelefone" min="3" required="required" class="form-control" placeholder="Telefone" aria-label="Telefone" 
			  		aria-describedby="basic-addon1" name="telefone" value="${veterinario.telefone }" />
					</div>
				</div>
			
			<div class="form-group">		
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Status de Atividade</label>
				 </div>
				  <select  class="custom-select" id="inputGroupSelect01"  name="ativo">
				    <option ${veterinario.ativo == 'true' ? 'selected' : ''} value="true">Ativo</option>
				    <option ${veterinario.ativo == 'false' && not empty veterinario.crv ? 'selected' : ''} value="false">Desativado</option>
				  </select>
				</div>
				</div>
					
			<div class="form-group mt-4">
					<div class="form-group">		
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Disponibilidade</label>
				 </div>
				 
				  <select class="custom-select" id="inputGroupSelect01" name="disponibilidade">
				    <option ${veterinario.disponibilidade == 'EM_PLANTAO' ? 'selected' : ''} value="<%= VeterinarioDisponibilidade.EM_PLANTAO %>">Em Plantão</option>
				    <option ${veterinario.disponibilidade == 'OCUPADO' ? 'selected' : ''} value="<%= VeterinarioDisponibilidade.OCUPADO %>">Ocupado</option>
				    <option ${veterinario.disponibilidade == 'FORA_DE_SERVICO' ? 'selected' : ''} value="<%= VeterinarioDisponibilidade.FORA_DE_SERVICO %>">Fora de Serviço</option>
				  </select>
				</div>
				</div>
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1">Especialização
			   	     </span>
			  		</div>
			  		<input type="text" min="5" required="required" class="form-control" placeholder="Especialização" aria-label="Especialização" 
			  		aria-describedby="basic-addon1" name="especializacoes[0].especializacao" value='<c:choose><c:when test="${veterinario.especializacoes[0] eq ''}"></c:when><c:otherwise>${veterinario.especializacoes[0]}</c:otherwise></c:choose>' >  
					</div>
				</div>
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1">2º Especialização
			   	     </span>
			  		</div>
			  		<input type="text" min="3" class="form-control" placeholder="Especialização(Opcional)" aria-label="Especialização 2" 
			  		aria-describedby="basic-addon1" name="especializacoes[1].especializacao" value='<c:choose><c:when test="${veterinario.especializacoes[1] eq ''}"></c:when><c:otherwise>${veterinario.especializacoes[1]}</c:otherwise></c:choose>' >  
					</div>
				</div>
				
					<input type="submit" class=" btn btn-lg float-right mb-5 btn-outline-success " value="${ empty veterinario.crv ? 'Cadastrar' : 'Alterar' }" />
					<c:if test="${not empty veterinario.crv}"><a class=" btn mb-5 float-left btn-outline-danger " href="${home}" >Cancelar alteração</a> </c:if>
					</div>
				</form:form>
				
				<c:if test="${not empty veterinarios }">
					<hr style="margin-top: 9%">
					<h2 class="display-4  text-center">Veterinarios Cadastrados</h2>
					<table class="text-center table table-hover">
				
						<thead class="thead-dark">
							<tr>
							
								<th>CRV</th>
								<th>Nome</th>
								<th>Endereço</th>
								<th>Telefone</th>
								<th>Especializações</th>
								<th>Status de Atividade</th>
								<th colspan="1">Ações</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="veterinario" items="${veterinarios }">
								<tr>
									<td>${veterinario.crv }</td>
									<td>${veterinario.nome }</td>
									<td>${veterinario.endereco }</td>
									<td>${veterinario.telefone }</td>
									<td><c:choose><c:when test="${veterinario.especializacoes == '[]'}">Nenhuma Especialização</c:when><c:otherwise>${veterinario.especializacoes[0]} <c:if test="${!empty veterinario.especializacoes[1]}"><br> ${veterinario.especializacoes[1]}</c:if> </c:otherwise></c:choose>  </td>
									<td><c:choose> <c:when test="${veterinario.ativo == true}">Ativo</c:when> <c:otherwise>Desativado</c:otherwise> </c:choose>	</td>
									<td><a href="${altera}${veterinario.crv}"
										class="btn btn-outline-warning">Alterar</a></td>
<%-- 									<td><a href="${deleta}${veterinario.crv}" --%>
<!-- 										class="btn btn-outline-danger">Deletar</a></td> -->
								</tr>
							</c:forEach>
						</tbody>
					</table>

				</c:if>
			</div>
	<script type="text/javascript">
		
		$(document).ready(function() {
			$('#divMensagemErro').delay(3500).fadeOut('slow');
			$('#divMensagemSucesso').delay(3500).fadeOut('slow');
			
			var txtTelefoneVal = $("#txttelefone").val();
			$("#txttelefone").mask("(00) 00000-0000");
			$("#txttelefone").val(txtTelefoneVal);
			$("#cep").mask("00000-000");
		});
		
		//Via Cep
		$("#cep").focusout(function(){
			$.ajax({
				url: 'https://viacep.com.br/ws/'+$(this).val()+'/json/unicode/',
				dataType: 'json',
				success: function(resposta){
					$("#endereco").val(resposta.logradouro + ' - ' + resposta.bairro + ' - ' + resposta.uf);
					const Toast = Swal.mixin({
			  toast: true,
			  position: 'top',
			  timer: 3500,
			  showConfirmButton: false,
			  timerProgressBar: true,
			  didOpen: (toast) => {
			    toast.addEventListener('mouseenter', Swal.stopTimer)
			    toast.addEventListener('mouseleave', Swal.resumeTimer)
			  }
			})

			Toast.fire({
			  icon: 'warning',
			  title: 'Por favor escreva as informações que faltam!'
			})
					$("#endereco").focus();
				}
			});
		});
	</script>
</body>
</html>