package com.qintess.clinica.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.annotation.Persistent;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qintess.clinica.model.DonoAnimal;
import com.qintess.clinica.repos.DonosRepository;

@Controller
@RequestMapping("/donos")
public class DonosController {
	
	@Autowired
	private DonosRepository donosRepository;
	
	@RequestMapping("")
	public String retornaDono(Model model) {
		model.addAttribute("dono", new DonoAnimal());
		List<DonoAnimal> donos = donosRepository.findAll();
		Collections.sort(donos);
		model.addAttribute("donos", donos);
		
		Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();
		
		model.addAttribute("usuarioLogado", auth);
		return "donos";
	}
	@RequestMapping("/salva")
	public String salva(@ModelAttribute @Persistent DonoAnimal donoAnimal,
						RedirectAttributes redirectAttribute) {
		try {
			
			if(donoAnimal.getId() == null)
				redirectAttribute.addFlashAttribute("mensagemSucesso", "Dono cadastrado com sucesso");
				else
				redirectAttribute.addFlashAttribute("mensagemSucesso", "Dono alterado com sucesso");
			donosRepository.save(donoAnimal);
						
						
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttribute.addFlashAttribute("mensagemErro", "Erro Grave: "+ e.getMessage());
		}
		return "redirect:/donos";
	}
	
	@RequestMapping("altera/{id}")
	public String carregaAlterar(@PathVariable(name = "id")int id, Model model,RedirectAttributes redirectAtt) {

		try {
			DonoAnimal donoAnimal = donosRepository.findById(id).get();
			
			List<DonoAnimal> donos = donosRepository.findAll();
			Collections.sort(donos);
			
			model.addAttribute("donos", donos);
			model.addAttribute("dono", donoAnimal);
			
		} catch (Exception e) {
			redirectAtt.addFlashAttribute("mensagemErro","ERRO GRAVE: "+e.getMessage());
		}
		
		return "donos";
	}
}
