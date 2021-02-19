<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Qintess - Veterinária</title>
	<spring:url value="/loga" var="loga"></spring:url>
	<spring:url value="/registra" var="registra"></spring:url>
	<spring:url value="/login" var="logar"></spring:url>
	
	<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
	<link href='<spring:url value="/css/bootstrap.css" />'rel="stylesheet" />
 	<c:if test="${usuarioLogado.authorities[0] eq 'ROLE_ADMIN' }">
 		<c:redirect url="/gestao"></c:redirect>
	</c:if>
	
	<link href='<spring:url value="/css/index.css" />'
	rel="stylesheet" />
	<script src='<spring:url value="/js/jquery-3.4.1.min.js" />'></script>
	<script src='<spring:url value="/js/bootstrap.js" />'></script>
</head>
<body style="overflow: hidden;">

	<div class="bg-image fadeIn first"></div>
	
	<div id="loginForm" class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<c:if test="${not empty mensagemErro }">
				<div id="divMensagemErro" class="alert alert-danger" role="alert">
					${mensagemErro }
				</div>
			</c:if>
			<!-- Icon -->
			<a href="#"><button id="login" class="float-left  mt-3 btn btn-success btn-block" disabled="disabled">Login</button></a> 
			<a href="#"><button id="cadastro" class="float-right mt-3 btn btn-outline-success btn-block" >Cadastrar</button></a>
			<div class="fadeIn first">
				<h2>Veterinária Qintess</h2>
				<br>
				<h2>(Acesso Administrativo)</h2>
			</div>

			<!-- Login Form -->
			<form:form action="${loga}">
				<input min="12" required="required" type="text" name="username" id="login" class="fadeIn second" placeholder="Nome de Usuário"> 
				<input  min="12" required="required" type="password" name="password" id="password" class="fadeIn third" placeholder="Senha"> 
				<input type="submit" class="fadeIn third" value="Logar">
			</form:form>

			<!-- Remind Passowrd -->
			<div id="formFooter">
				<blockquote class="blockquote text-center">
 		 		<p class="mb-0">Jamais passe sua conta, em nenhum caso.</p>
				  <footer class="blockquote-footer">Administração<cite title="Source Title"> RH</cite></footer>
				</blockquote>
			</div>
		</div>
	</div>
	
	<div id="cadastroForm" class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<c:if test="${not empty mensagemErro }">
				<div id="divMensagemErro" class="alert alert-danger" role="alert">
					${mensagemErro }
				</div>
			</c:if>
			<!-- Icon -->
			<a href="#"><button id="loginBtn" class="float-left  mt-3 btn btn-outline-success btn-block">Login</button></a> 
			<a href="#"><button id="cadastro" class="float-right mt-3 btn btn-success btn-block"  disabled="disabled">Cadastrar</button></a>
			<div class="fadeIn first">
				<h2>Veterinária Qintess</h2>
				<br>
				<h2>(Acesso Administrativo)</h2>
			</div>
			<!-- Registra Form -->
			
			<div class="container mt-3">
			<form:form action="${registra}" modelAttribute="usuario">
				<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-user-2-line"></i>
			   	     </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="Nome Do(a) Atendente" aria-label="Nome Do(a) Atendente" 
			  		aria-describedby="basic-addon1" name="nomeAtendente" value="${usuario.nomeAtendente }" />
					</div>
				</div>
				
				<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"> <i class="ri-shield-user-line"></i> </span>
			  		</div>
			  		<input type="text"  min="3" required="required" class="form-control" placeholder="Nome de Usuário" aria-label="Nome de Usuário" 
			  		aria-describedby="basic-addon1" name="usuarioNome" value="${usuario.usuarioNome }" />
					</div>
				</div>
				
				<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"><i class="ri-key-2-line"></i></span>
			  		</div>
			  		<input type="password"  min="8" required="required"class="form-control" placeholder="Senha de Usuário" aria-label="Senha de Usuário" 
			  		aria-describedby="basic-addon1" maxlength="20" name="senha" value="${usuario.senha }" />
					</div>
				</div>
				
				<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"><i class="ri-draft-line"></i></span>
			  		</div>
			  		<input oninput="mascara(this)"  min="14" required="required" type="text" class="form-control" placeholder="CPF" aria-label="CPF" 
			  		aria-describedby="basic-addon1" name="cpf" value="${usuario.cpf }" />
					</div>
				</div>
				
				<div class="form-group mt-4">
					<div class="input-group mb-3">
			  		<div class="input-group-prepend">
			   	    <span class="input-group-text" id="basic-addon1"><i class="ri-calendar-2-line"></i></span>
			  		</div>
			  		<input oninput="mascara(this)" required="required" type="date" class="form-control" placeholder="Data de Nascimento" aria-label="Data de Nascimento" 
			  		aria-describedby="basic-addon1" name="dtNascimento" value="${usuario.dtNascimento }" />
					</div>
				</div>
				<input type="submit" class="fadeIn third" value="Cadastrar-se">
			</form:form>
			</div>
		</div>
	</div>

	<a href="#">
	<div class="bg-text fadeIn fourth">
		<h1>Qintess - Clinica Médica</h1>
	  	<p>Clique Para Entrar</p>
	  	
	</div>
	</a>

</body>
<script type="text/javascript">
	$(".bg-text").click(function(){
		$("#loginForm").css('display','block');
		$(this).css('display','none');
	});

	$(document).ready(function() {
		$(".wrapper").css('display','none')
    setTimeout(function() {
    	$('.bg-image')
    	.css({
    	   'filter'         : 'blur(8px)',
    	   '-webkit-filter' : 'blur(8px)',
    	   '-moz-filter'    : 'blur(8px)',
    	   '-o-filter'      : 'blur(8px)',
    	   '-ms-filter'     : 'blur(8px)'
    	});
    }, 2000);
});

	$("#cadastro").click(function(){
		$("#loginForm").css('display','none');
		$("#cadastroForm").css('display','block');
	});
	 
	$("#loginBtn").click(function(){
		$("#cadastroForm").css('display','none');
		$("#loginForm").css('display','block');
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