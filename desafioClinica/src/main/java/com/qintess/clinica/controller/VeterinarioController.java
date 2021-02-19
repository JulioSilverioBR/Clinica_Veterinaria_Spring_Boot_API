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

import com.qintess.clinica.model.Veterinario;
import com.qintess.clinica.repos.VeterinarioRepository;

@Controller
@RequestMapping("/veterinarios")
public class VeterinarioController {
	
	@Autowired
	private VeterinarioRepository veterinarioRepository;
	
	@RequestMapping("")
	public String carregaVeterinarios(Model model) {

		model.addAttribute("veterinario", new Veterinario());
		List<Veterinario> veterinarios = veterinarioRepository.findAll();
		Collections.sort(veterinarios);
		
		model.addAttribute("veterinarios", veterinarios);
		
		Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();
		
		model.addAttribute("usuarioLogado", auth);
		
		return "veterinarios";
	}
	@RequestMapping("/salva")
	public String salva(@ModelAttribute @Persistent Veterinario veterinario,
						RedirectAttributes redirectAttribute) {
		try {
			
			//Verifica se o CRV ja existe no banco para alterar ou salvar
			boolean busca = veterinarioRepository.existsById(veterinario.getCrv());
			
			if(busca == false) {					
					if(!veterinario.getEspecializacoes().get(0).getEspecializacao().isBlank() 
							&& !veterinario.getEspecializacoes().get(0).getEspecializacao().isEmpty()) {
						veterinario.addEspecializacao(veterinario.getEspecializacoes().get(0));
					}
					if(!veterinario.getEspecializacoes().get(1).getEspecializacao().isBlank() 
							&& !veterinario.getEspecializacoes().get(1).getEspecializacao().isEmpty()) {
						veterinario.addEspecializacao(veterinario.getEspecializacoes().get(1));
					}
						veterinarioRepository.saveAndFlush(veterinario);
						redirectAttribute.addFlashAttribute("mensagemSucesso", "Veterinario cadastrado com sucesso");
			}else {
					Veterinario temp = veterinarioRepository.findById(veterinario.getCrv()).get();
					
					
						if(veterinario.getEspecializacoes().get(0).getEspecializacao().length() > 0) {
							temp.rmvEspecializacao(temp.getEspecializacoes().get(0));
							veterinario.addEspecializacao(veterinario.getEspecializacoes().get(0));
						}
						
						if(veterinario.getEspecializacoes().get(1).getEspecializacao().length() > 0) {
						if(temp.getEspecializacoes().size() > 0 ) {
						temp.rmvEspecializacao(temp.getEspecializacoes().get(0));
						}
						veterinario.addEspecializacao(veterinario.getEspecializacoes().get(1));
						}
						veterinarioRepository.saveAndFlush(veterinario);
						redirectAttribute.addFlashAttribute("mensagemSucesso", "Veterinario alterado com sucesso");
			}
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttribute.addFlashAttribute("mensagemErro", "Erro Grave: "+ e.getMessage());
		}
		return "redirect:/veterinarios";
	}
	
	@RequestMapping("altera/{crv}")
	public String carregaAlterar(@PathVariable(name = "crv")int crv, Model model,RedirectAttributes redirectAtt) {

		try {
			Veterinario veterinario = veterinarioRepository.findById(crv).get();
			
			List<Veterinario> veterinarios = veterinarioRepository.findAll();
			Collections.sort(veterinarios);
			
			model.addAttribute("veterinarios", veterinarios);
			model.addAttribute("veterinario", veterinario);
		} catch (Exception e) {
			redirectAtt.addFlashAttribute("mensagemErro","ERRO GRAVE: "+e.getMessage());
		}
		
		return "veterinarios";
	}
}
