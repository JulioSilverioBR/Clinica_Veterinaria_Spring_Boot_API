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
<spring:url value="/donos" var="home"></spring:url>
<spring:url value="/donos/deleta/" var="deleta"></spring:url>
<spring:url value="/donos/altera/" var="altera"></spring:url>
<spring:url value="/donos/salva" var="salva"></spring:url>


<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
<link href='<spring:url value="/css/bootstrap.css" />'
	rel="stylesheet" />
<script src='<spring:url value="/js/jquery-3.4.1.min.js" />'></script>
<script src='<spring:url value="/js/bootstrap.js" />'></script>
<script src='<spring:url value="/js/jquery.mask.min.js" />'></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Cadastro Dono - Arcá de Nóe</title>
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
					<h1 class="display-4 text-center">Cadastro de Donos e Gestão</h1>
				</div>
				
				<div class="container mt-4">
				<form:form action="${salva }" cssClass="form" modelAttribute="dono" class="mb-2">
				
				<form:hidden path="id" />
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-user-2-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="Nome Do Dono" aria-label="Nome Do Dono" 
			  		aria-describedby="basic-addon1" name="nome" pattern="^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$" value="${dono.nome }" />
					</div>
				</div> 
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-user-2-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="CPF" aria-label="Cpf Do Dono" 
			  		aria-describedby="basic-addon1" oninput="mascara(this)" name="cpf" value="${dono.cpf }" />
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
			  		aria-describedby="basic-addon1" name="endereco" id="endereco" value="${dono.endereco }" />
					</div>
					
				</div>


		<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-phone-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text" id="txttelefone" min="3" required="required" class="form-control" placeholder="Telefone" aria-label="Telefone" 
			  		aria-describedby="basic-addon1" name="telefone" value="${dono.telefone }" />
					</div>
				</div>
					<input type="submit" class=" btn btn-lg float-right mb-5 btn-outline-success " value="${empty dono.id ? 'Cadastrar' : 'Alterar' }" />
					<c:if test="${not empty dono.id}"><a class=" btn mb-5 float-left btn-outline-danger " href="${home}" >Cancelar alteração</a> </c:if>
				</form:form>
					
					
				
				<c:if test="${not empty donos }">
					<hr style="margin-top: 9%">
					<h2 class="display-4  text-center">Donos Cadastrados</h2>
					<table class="text-center table table-hover">
				
						<thead class="thead-dark">
							<tr>
							
								<th>ID</th>
								<th>Nome</th>
								<th>CPF</th>
								<th>Endereço</th>
								<th>Telefone</th>
								<th>Ações</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dono" items="${donos }">
								<tr>
									<td>${dono.id }</td>
									<td>${dono.nome }</td>
									<td>${dono.cpf }</td>
									<td>${dono.endereco }</td>
									<td>${dono.telefone }</td>
									<td><a href="${altera}${dono.id}"
										class="btn btn-outline-warning">Alterar</a></td>
<%-- 									<td><a href="${deleta}${dono.id}" --%>
<!-- 										class="btn btn-outline-danger">Deletar</a></td> -->
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
		
		function mascara(i){
			   
			   var v = i.value;
			   
			   if(isNaN(v[v.length-1])){ // impede entrar outro caractere que não seja número
			      i.value = v.substring(0, v.length-1);
			      return;
			   }
			   
			   i.setAttribute("maxlength", "14");
			   if (v.length == 3 || v.length == 7) i.value += ".";
			   if (v.length == 11) i.value += "-";

			}
	</script>
</html>