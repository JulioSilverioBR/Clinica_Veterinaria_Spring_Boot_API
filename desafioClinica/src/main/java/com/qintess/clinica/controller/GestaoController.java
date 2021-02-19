package com.qintess.clinica.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GestaoController {
	@RequestMapping("/gestao")
	public String carregaGestao(Model model) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			model.addAttribute("usuarioLogado", auth);
			return "gestao";
	}
	@RequestMapping("/menu")
	public String menu(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		model.addAttribute("usuarioLogado", auth);
		return "menu";
	}
}
