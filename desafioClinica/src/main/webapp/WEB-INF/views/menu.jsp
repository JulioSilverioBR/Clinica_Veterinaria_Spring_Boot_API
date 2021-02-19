<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/gestao" var="inicio"></spring:url>
<spring:url value="/logout" var="logout"></spring:url>
    
    
<div class="pos-f-t">
  <div class="collapse" id="navbarToggleExternalContent">
    <div class="bg-dark p-4">
    
  <div class="container w-50">
      <h1 class="text-white display-4 text-center "><u>Menus</u> </h1>
      <div class="list-group text-center">
  <a href="#" class="list-group-item list-group-item-action active">
    Gestão
  </a>
  <a href="#" class="list-group-item list-group-item-action">Veterinários</a>
  <a href="#" class="list-group-item list-group-item-action">Animais</a>
  <a href="#" class="list-group-item list-group-item-action">Donos</a>
  <a href="#" class="list-group-item list-group-item-action">Medicamentos</a>
  <a href="#" class="list-group-item list-group-item-action">Exames</a>
  <a href="#" class="list-group-item list-group-item-action" tabindex="-1" aria-disabled="true">Consultas</a>
</div>
</div>
    </div>
  </div>    
<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 text-white bg-success border-bottom shadow-sm">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
     <i class="ri-menu-line text-white"></i>
    </button>
    <h5 class="my-0 mr-md-auto font-weight-normal"> &nbsp;	Clinica Arca De Nóe</h5>
  <nav class="my-2 my-md-0 mr-md-3">
	<c:if test="${usuarioLogado.authorities[0] eq 'ROLE_ADMIN' }">
    <a class="p-2 text-white" href="${inicio}">Inicio</a>
    </c:if>
	<a class="p-2 text-white" href="#">${usuarioLogado.name == 'anonymousUser' ? '' : usuarioLogado.name}<c:if test="${usuarioLogado.authorities[0] eq 'ROLE_ADMIN' }">(Atendente)</c:if></a>		
	
	<c:if test="${usuarioLogado.name ne 'anonymousUser' }">
	<a class="p-2 text-white" href="${logout}" >Deslogar</a>
	</c:if>
  </nav>
</div>
</div>