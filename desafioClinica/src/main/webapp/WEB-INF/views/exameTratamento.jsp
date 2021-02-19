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
<spring:url value="/examesTratamento" var="home"></spring:url>
<spring:url value="/examesTratamento/deleta/" var="deleta"></spring:url>
<spring:url value="/examesTratamento/altera/" var="altera"></spring:url>
<spring:url value="/examesTratamento/salva" var="salva"></spring:url>
<spring:url value="/examesTratamento/carregaConsulta" var="carregaConsulta"></spring:url>


<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
<link href='<spring:url value="/css/bootstrap.css" />'
	rel="stylesheet" />
<script src='<spring:url value="/js/jquery-3.4.1.min.js" />'></script>
<script src='<spring:url value="/js/bootstrap.js" />'></script>
<script src='<spring:url value="/js/jquery.mask.min.js" />'></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Cadastro Exames e Tratamento - Arcá de Nóe</title>
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
					<h1 class="display-4 text-center">Cadastro de Exames e Tratamentos</h1>
				</div>
				
				<div class="container mt-4">
				<form:form action="${carregaConsulta }" cssClass="form" modelAttribute="consulta" class="mb-2">
					<select id="buscaConsulta"  required="required" class="custom-select" id="inputGroupSelect01" name="id">
				  <c:forEach var="consulta" items="${consultas}">
				    <option ${consulta.id == consultaPrincipal.id ? 'selected' : ''} value="${consulta.id}">| ${consulta.id} | ${consulta.animal.nomeAnimal} | ${consulta.animal.dono.nome} | ${consulta.dataHoraAtendimento}</option>
				  </c:forEach>
				  </select>
					<c:if test="${empty consultaPrincipal }">					
					<button class="btn mt-3 float-right btn-outline-success">Buscar</button>
					</c:if>
				</form:form>
				<c:if test="${not empty consultaPrincipal}">
				<script type="text/javascript">
					$('#buscaConsulta').attr("disabled", true);
				</script>
				
				<form:form action="${salva }" cssClass="form" modelAttribute="consultaPrincipal" class="mb-2">
				<form:hidden path="id" />	
				<div class="form-group">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Data e Hora&nbsp;<i class="ri-calendar-event-line"></i></label>
				 </div>
				  <input disabled="disabled" class="form-control" value="${consultaPrincipal.dataHoraAtendimento}" type="datetime-local" name="dataHoraAtendimento"  max="2021-12-31T00:00">
				</div>
				</div>
						
				<div class="form-group">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Dono&nbsp;<i class="ri-user-heart-line"></i></label>
				 </div>
				  <select disabled="disabled" id="animal" name="animal.dono.nome"  class="custom-select">
				    <option selected="selected" value="${consultaPrincipal.animal.dono.id}">${consultaPrincipal.animal.dono.nome}</option>
				  </select>
				</div>
				</div>
						
				<div class="form-group">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Animal&nbsp;<i class="ri-baidu-line"></i></label>
				 </div>
				  <select disabled="disabled" id="animal" name="animal.codigo"  class="custom-select">
				    <option selected="selected" value="${consultaPrincipal.animal.codigo}">${consultaPrincipal.animal.nomeAnimal}</option>
				  </select>
				</div>
				</div>
				
				
			<div class="form-group inputVeterinario1"">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Veterinario&nbsp;<i class="ri-nurse-line"></i></label>
				 </div>
				  <select disabled="disabled" required="required" class="custom-select veterinarios" style="height: 40px" name="veterinarios[0].crv">
				    <option selected  value="${consultaPrincipal.veterinarios[0].crv}">${consultaPrincipal.veterinarios[0].nome}</option>
				  </select>
				   
				</div>
				</div>
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span  class="input-group-text" id="basic-addon1"><i class="ri-file-text-line"></i>
			   	     </span>
			  		</div>
			  			   <textarea required="required" readonly="readonly" disabled="disabled" placeholder="Diagnóstico" minlength="5" maxlength="200" class="form-control" name="diagnostico" style="resize: none;" rows="3">${consultaPrincipal.diagnostico }</textarea>
					</div>
				</div> 
				
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <span class="input-group-text">Valor&nbsp;&nbsp;<i class="ri-money-dollar-circle-line"></i></span>
				  </div>
				  <input disabled="disabled" type="number" class="form-control" value="${ consultaPrincipal.custoAtendimento}" id="preco" name="custoAtendimento" placeholder="Valor Formato (0.00)" aria-label="Amount (to the nearest dollar)">
				</div>		
					<c:if test="${empty consulta.id}">
							<script type="text/javascript">
								$(".veterinarios").prop("selectedIndex", -1);
								$("#animal").prop("selectedIndex", -1);
							</script>
					</c:if>
					</form:form>
					<a class=" btn btn-lg float-right mb-5 ml-3 btn-outline-primary" id="exame" href="#" >Adicionar Exame</a>
					<a class=" btn btn-lg float-right mb-5 btn-outline-secondary" id="tratamento" href="#">Adicionar Tratamento</a>
					<c:if test="${not empty consultaPrincipal.id}"><a class=" btn mb-5 float-left btn-outline-danger " href="${home}" >Cancelar alteração</a> </c:if>
					</c:if>
					
					<c:if test="${not empty  consultaPrincipal}">
					<div id="exameDiv" style="margin-top:120px;display: none">
						<hr>
						<h2 class="text-center display-4">Exame</h2>
						<form:form  modelAttribute="exame" action="salvaExame">
								<form:hidden path="id" />
								<input hidden="" name="consulta.id" value="${consultaPrincipal.id }">
								<div class="input-group mb-3">
				  				<div class="input-group-prepend">
							    <span class="input-group-text">Nome Exame&nbsp;&nbsp;<i class="ri-file-text-line"></i></span>
							  </div>
				  				<input type="text" class="form-control" value="${exame.nome}" name="nome" placeholder="Nome do Exame" aria-label="Nome do Exame">
				  				<input class="btn btn-outline-success"  type="submit" value="Inserir"> 
					</div>		
						</form:form>
					</div>
					
					<div id="tratamentoDiv"  style="margin-top:120px;display: none"> 
						<hr>
						<h2 class="text-center display-4">Tratamento</h2>
						<form:form  modelAttribute="tratamento" action="salvaTratamento">
								<form:hidden path="id" />
								<input hidden="" name="consulta.id" value="${consultaPrincipal.id }">
								<div class="input-group mb-3">
				  				<div class="input-group-prepend">
							    <span class="input-group-text">Observação&nbsp;&nbsp;<i class="ri-file-text-line"></i></span>
							  </div>
				  				<textarea name="observacao" style="resize: none;" class="form-control" rows="3"></textarea>
								</div>		
								
								<div class="form-group "  >		
								<div class="input-group mt-4 mb-3 ">
								  <div class="input-group-prepend" style="height: 40px">
								    <label class="input-group-text" for="inputGroupSelect01">Medicamento&nbsp;<i class="ri-capsule-line"></i></label>
								 </div>
								  <select required="required" class="custom-select mb-3" style="height: 40px" name="medicamentos[0].medicamento.id">  
									<c:forEach var="medicamento" items="${medicamentos }">
								   <option value="${medicamento.codigo}">${medicamento.nome}</option>
								  </c:forEach>
								  </select>
									</div>
									</div>			
				  			
				   				<div class="form-group "  >		
								<div class="input-group mb-3 ">
								  <div class="input-group-prepend" style="height: 40px">
								    <label class="input-group-text" for="inputGroupSelect01">Quantidade</label>
								 </div>
									 <input class="form-control" style="height: 40px" type="number" name="medicamentos[0].quantidadeAplicacao">
									</div>
									</div>			
				  			
				  					<div class="form-group "  >		
								<div class="input-group mb-3 ">
								  <div class="input-group-prepend" style="height: 40px">
								    <label class="input-group-text" for="inputGroupSelect01">Horario de Aplicação</label>
								 </div>
									 <input class="form-control" style="height: 40px" type="time" name="medicamentos[0].horariosDeAplicacao">
									</div>
									</div>	
				  			
								<input class="btn btn-outline-success float-right" type="submit" value="Inserir"> 
						</form:form>
					</div>
				</c:if>
				</div>
</body>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#divMensagemErro').delay(3500).fadeOut('slow');
			$('#divMensagemSucesso').delay(3500).fadeOut('slow');
		});
		
		$('#exame').click(function(){
			$('#tratamentoDiv').css('display','none')
			$('#exameDiv').css('display','block');
		});
		
		$('#tratamento').click(function(){
			$('#tratamentoDiv').css('display','block')
			$('#exameDiv').css('display','none');
		});
	</script>
</html>