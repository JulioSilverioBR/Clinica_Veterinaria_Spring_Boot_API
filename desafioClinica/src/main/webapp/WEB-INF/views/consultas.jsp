<%@page import="com.qintess.clinica.repos.AnimaisRepository"%>
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
<spring:url value="/consultas" var="home"></spring:url>
<spring:url value="/consultas/deleta/" var="deleta"></spring:url>
<spring:url value="/consultas/altera/" var="altera"></spring:url>
<spring:url value="/consultas/salva" var="salva"></spring:url>


<%@ page import="com.qintess.clinica.model.ConsultaTipo" %>
<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
<link href='<spring:url value="/css/bootstrap.css" />'
	rel="stylesheet" />
<script src='<spring:url value="/js/jquery-3.4.1.min.js" />'></script>
<script src='<spring:url value="/js/bootstrap.js" />'></script>
<script src='<spring:url value="/js/jquery.mask.min.js" />'></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Cadastro de Consulta - Arcá de Nóe</title>
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
					<h1 class="display-4 text-center">Cadastro de Consultas e Gestão</h1>
				</div>
				
				<div class="container mt-4">
				
				 <fieldset class="form-group text-center" >
				<div class="form-check form-check-inline mr-5">
				  <input required="required" class="form-check-input" type="radio" name="pagina" id="agendada">
				  <label class="form-check-label" for="inlineRadio1">Agendada</label>
				</div>
				
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="pagina" id="emergencia">
				  <label class="form-check-label" for="inlineRadio2">Emergência</label>
				</div>
					</fieldset>		
				<div id="formAgendado">
				<form:form action="${salva }" cssClass="form" modelAttribute="consulta" class="mb-2">
				<form:hidden path="id" />
				  <fieldset class="form-group text-center" >
				<div class="form-check form-check-inline mr-5">
				  <input required="required" checked="checked" style="display: none;" class="form-check-input" type="radio" name="consultaTipo" value="<%= ConsultaTipo.PADRAO %>">
				  <label class="form-check-label" for="inlineRadio1">Agendada</label>
				</div>
					</fieldset>		
					
				<div class="form-group">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Data e Hora&nbsp;<i class="ri-calendar-event-line"></i></label>
				 </div>
				  <input class="form-control" type="datetime-local" name="dataHoraAtendimento"  max="2021-12-31T00:00">
				</div>
				</div>
				
						
				<div class="form-group">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Animal&nbsp;<i class="ri-baidu-line"></i></label>
				 </div>
				  <select id="animal" name="animal.codigo"  class="custom-select">
				  <c:forEach var="animal" items="${animais}">
				    <option ${animal.codigo == consulta.animal.codigo ? 'selected' : ''} value="${animal.codigo}">${animal.nomeAnimal}</option>
				  </c:forEach>
				  </select>
				</div>
				</div>
				
				
			<div class="form-group inputVeterinario1"">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Veterinario&nbsp;<i class="ri-nurse-line"></i></label>
				 </div>
				  <select required="required" class="custom-select veterinarios" style="height: 40px" name="veterinarios[0].crv">
				  <c:forEach var="veterinario" items="${veterinarios}">
				    <option ${animal.veterinariosResponsaveis[0].crv == veterinario.crv ? 'selected' : ''} value="${veterinario.crv}">${veterinario.nome}</option>
				  </c:forEach>
				  </select>
				   <div class="input-group-append">
   				 <a href="#" class="btn btn-outline-success addBtnField1"><b>+</b></a>
 				 </div>
				</div>
				</div>
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"><i class="ri-file-text-line"></i>
			   	     </span>
			  		</div>
			  			   <textarea required="required" placeholder="Diagnóstico" minlength="5" maxlength="200" class="form-control" name="diagnostico" style="resize: none;" rows="3">${consulta.diagnostico }</textarea>
					</div>
				</div> 
				
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <span class="input-group-text">Valor&nbsp;&nbsp;<i class="ri-money-dollar-circle-line"></i></span>
				  </div>
				  <input type="number" class="form-control" id="preco" name="custoAtendimento" placeholder="Valor Formato (0.00)" aria-label="Amount (to the nearest dollar)">
				</div>		
					<c:if test="${empty consulta.id}">
							<script type="text/javascript">
								$(".veterinarios").prop("selectedIndex", -1);
								$("#animal").prop("selectedIndex", -1);
							</script>
					</c:if>
					
					<input type="submit" class=" btn btn-lg float-right mb-5 btn-outline-success " value="${empty medicamento.codigo ? 'Cadastrar' : 'Alterar' }" />
					<c:if test="${not empty medicamento.codigo}"><a class=" btn mb-5 float-left btn-outline-danger " href="${home}" >Cancelar alteração</a> </c:if>
				</form:form>
					</div>
					
<!-- 					/////////////////////////////////////////////////////////////////////////// -->
					<div id="formEmergencia">
				<form:form action="${salva }" cssClass="form" modelAttribute="consulta" class="mb-2">
				<form:hidden path="id" />
				  <fieldset class="form-group text-center" >
				<div class="form-check form-check-inline mr-5">
				  <input required="required" checked="checked" style="display: none;" class="form-check-input" type="radio" name="consultaTipo" value="<%= ConsultaTipo.EMERGENCIA %>">
				  <label class="form-check-label" for="inlineRadio1">Emergencia</label>
				</div>
					</fieldset>		
					
				<div class="form-group">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Data e Hora&nbsp;<i class="ri-calendar-event-line"></i></label>
				 </div>
				  <input class="form-control" type="datetime-local" name="dataHoraAtendimento"  max="2021-12-31T00:00">
				</div>
				</div>
				
						
				<div class="form-group">		
				<div class="input-group mt-4 mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Animal&nbsp;<i class="ri-baidu-line"></i></label>
				 </div>
				  <select id="animal" name="animal.codigo"  class="custom-select">
				  <c:forEach var="animal" items="${animais}">
				    <option ${animal.codigo == consulta.animal.codigo ? 'selected' : ''} value="${animal.codigo}">${animal.nomeAnimal}</option>
				  </c:forEach>
				  </select>
				</div>
				</div>
				
				
		<div class="form-group inputVeterinario2" >		
				<div class="input-group mt-4 mb-3 ">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">Veterinario&nbsp;<i class="ri-nurse-line"></i></label>
				 </div>
				  <select required="required" class="custom-select veterinarios" style="height: 40px" name="veterinarios[0].crv">
				  <c:forEach var="veterinario" items="${veterinariosPlantao}">
				    <option ${consulta.veterinarios[0].crv == veterinario.crv ? 'selected' : ''} value="${veterinario.crv}">${veterinario.nome}</option>
				  </c:forEach>
				  </select>
				   <div class="input-group-append">
   				 <a href="#" class="btn btn-outline-success addBtnField2"><b>+</b></a>
 				 </div>
				</div>
				</div>
				
					<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"><i class="ri-file-text-line"></i>
			   	     </span>
			  		</div>
			  			   <textarea required="required" placeholder="Diagnóstico" minlength="5" maxlength="200" class="form-control" name="diagnostico" style="resize: none;" rows="3">${consulta.diagnostico }</textarea>
					</div>
				</div> 
				
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <span class="input-group-text">Valor&nbsp;&nbsp;<i class="ri-money-dollar-circle-line"></i></span>
				  </div>
				  <input type="number" class="form-control" id="preco2" name="custoAtendimento" placeholder="Valor Formato (0.00)" aria-label="Amount (to the nearest dollar)">
				</div>
					
					<c:if test="${empty consulta.id}">
							<script type="text/javascript">
								$(".veterinarios").prop("selectedIndex", -1);
								$("#animal").prop("selectedIndex", -1);
							</script>
					</c:if>
					
					<input type="submit" class=" btn btn-lg float-right mb-5 btn-outline-success " value="${empty consulta.id ? 'Cadastrar' : 'Alterar' }" />
					<c:if test="${not empty consulta.id}"><a class=" btn mb-5 float-left btn-outline-danger " href="${home}" >Cancelar alteração</a> </c:if>
				</form:form>
					</div>
				
				<c:if test="${not empty consultas }">
					<hr style="margin-top: 9%">
					<h2 class="display-4  text-center">Consultas Cadastradas</h2>
					<table class="text-center table table-hover">
				
						<thead class="thead-dark">
							<tr>
								<th>ID</th>
								<th>Tipo</th>
								<th>Dia</th>
								<th>Custo</th>
								<th>Animal/Dono</th>
								<th>Diagnóstico(Previo)</th>
								<th colspan="1">Ações</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="consulta" items="${consultas }">
								<tr>
									<td>${consulta.id }</td>
									<td>${consulta.tipoConsulta }</td>
									
									<fmt:parseDate value="${consulta.dataHoraAtendimento }" type="both" dateStyle = "short" timeStyle = "short"
										pattern="yyyy-MM-dd" var="dtParsed" />
									<fmt:formatDate value="${dtParsed }" type="both" dateStyle = "short" timeStyle = "short"
										pattern="dd/MM/yyyy" var="dtTratada" />
									<td>${dtTratada }</td>
									
									<td>R$ ${consulta.custoAtendimento }</td>
									<td>${consulta.animal.nomeAnimal} / ${consulta.animal.dono.nome }</td>
									<td>${consulta.diagnostico } </td>
									<td><a href="${altera}${consulta.id}"
										class="btn btn-outline-warning">Alterar</a></td>
<%-- 										<td><a href="${deleta}${consulta.id}" --%>
<!-- 										class="btn btn-outline-danger">Deletar</a></td> -->
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				</div>
</body>

	<script type="text/javascript">
	
	$("#agendada").click(function(){
		$('#formEmergencia').css('display','none');
		$('#formAgendado').css('display','block');
		$('#preco').val(60.00);
	});
	
	$("#emergencia").click(function(){
		$('#formEmergencia').css('display','block');
		$('#formAgendado').css('display','none');
		$('#preco2').val(100.00);
	});
	
	$(document).ready(function() {
		$('#formEmergencia').css('display','none');
		$('#formAgendado').css('display','none');
		  var max_fields = 5; //maximum input boxes allowed
		  var wrapper = $(".inputVeterinario1"); //Fields wrapper
		  var add_button = $(".addBtnField1"); //Add button ID

		  var x = 1; //initlal text box count
		  $(add_button).click(function(e) { //on add input button click
		    e.preventDefault();
		    var length = wrapper.find(".form-group").length;

		    if (x < max_fields) { //max input box allowed
		      x++; //text box increment
		      $(wrapper).append('<div class="form-group "><div class="input-group mt-4 mb-3"> <div class="input-group-prepend"> <label class="input-group-text" for="inputGroupSelect01">Veterinario '+(x)+'<i class="ri-nurse-line"></i></label></div><select required="required" class="custom-select" style="height: 40px" id="veterinarios" name="veterinariosResponsaveis['+(x-1)+'].crv"><c:forEach var="veterinario" items="${veterinarios}"><option ${animal.veterinariosResponsaveis[0].crv == veterinario.crv ? 'selected' : ''} value="${veterinario.crv}">${veterinario.nome}</option></c:forEach></select><div class="input-group-append"><a href="#" class="btn btn-outline-danger remove_field"><b>-</b></a></div></div></div>');
		    }
		  });

		  $(wrapper).on("click", ".remove_field", function(e) { //user click on remove text
		    e.preventDefault();
		    $(this).parent('div').parent('div').remove();
		    x--;
		  })
		});	
	
	$(document).ready(function() {
		  var max_fields = 5; //maximum input boxes allowed
		  var wrapper = $(".inputVeterinario2"); //Fields wrapper
		  var add_button = $(".addBtnField2"); //Add button ID

		  var x = 1; //initlal text box count
		  $(add_button).click(function(e) { //on add input button click
		    e.preventDefault();
		    var length = wrapper.find(".form-group").length;

		    if (x < max_fields) { //max input box allowed
		      x++; //text box increment
		      $(wrapper).append('<div class="form-group "><div class="input-group mt-4 mb-3"> <div class="input-group-prepend"> <label class="input-group-text" for="inputGroupSelect01">Veterinario '+(x)+'<i class="ri-nurse-line"></i></label></div><select required="required" class="custom-select" style="height: 40px" id="veterinarios" name="veterinariosResponsaveis['+(x-1)+'].crv"><c:forEach var="veterinario" items="${veterinariosPlantao}"><option ${consulta.veterinarios[0].crv == veterinario.crv ? 'selected' : ''} value="${veterinario.crv}">${veterinario.nome}</option></c:forEach></select><div class="input-group-append"><a href="#" class="btn btn-outline-danger remove_field"><b>-</b></a></div></div></div>');
		    }
		  });

		  $(wrapper).on("click", ".remove_field", function(e) { //user click on remove text
		    e.preventDefault();
		    $(this).parent('div').parent('div').remove();
		    x--;
		  })
		});	
	
		$(document).ready(function() {
			$('#divMensagemErro').delay(3500).fadeOut('slow');
			$('#divMensagemSucesso').delay(3500).fadeOut('slow');
		});
	</script>
</html>