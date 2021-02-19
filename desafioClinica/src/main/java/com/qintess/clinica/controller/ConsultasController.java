package com.qintess.clinica.controller;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.annotation.Persistent;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qintess.clinica.model.Animal;
import com.qintess.clinica.model.Consulta;
import com.qintess.clinica.model.ConsultaTipo;
import com.qintess.clinica.model.Veterinario;
import com.qintess.clinica.model.VeterinarioDisponibilidade;
import com.qintess.clinica.repos.AnimaisRepository;
import com.qintess.clinica.repos.ConsultasRepository;
import com.qintess.clinica.repos.VeterinarioRepository;

@Controller
@RequestMapping("/consultas")
public class ConsultasController {
	@Autowired
	private ConsultasRepository consultaRepository;
	
	@Autowired
	private VeterinarioRepository veterinarioRepository;
	
	@Autowired
	private AnimaisRepository animaisRepository;
	
	@RequestMapping("")
	public String carregaConsultas(Model model) {
		model.addAttribute("consulta", new Consulta());
		List<Consulta> consultas = consultaRepository.findAll();
		Collections.sort(consultas);
		model.addAttribute("consultas", consultas);
		
		List<Animal> animais = animaisRepository.findAll();
		Collections.sort(animais);
		model.addAttribute("animais", animais);
		
		List<Veterinario> veterinarios = veterinarioRepository.findAll();
		Collections.sort(veterinarios);
		model.addAttribute("veterinarios", veterinarios);
		
		List<Veterinario> veterinariosPlantao = veterinarioRepository.findByDisponibilidade(VeterinarioDisponibilidade.EM_PLANTAO);
		Collections.sort(veterinariosPlantao);
		model.addAttribute("veterinariosPlantao", veterinariosPlantao);
		
		return "consultas";
	}


@RequestMapping("/salva")
public String salva(@ModelAttribute @Persistent Consulta consulta, HttpServletRequest req, 
					RedirectAttributes redirectAttribute) {
	try {
		
		//Verifica se o CRV ja existe no banco para alterar ou salvar
		
		if(consulta.getId() == null) {		
					var tempAnimal = animaisRepository.findById(consulta.getAnimal().getCodigo()).get();
					consulta.setAnimal(tempAnimal);
					consulta.setTipoConsulta(ConsultaTipo.valueOf(req.getParameter("consultaTipo")));
					consulta.getVeterinarios().set(0, veterinarioRepository.findById(consulta.getVeterinarios().get(0).getCrv()).get()); 
					consulta.addVeterinario(consulta.getVeterinarios().get(0));
				
					consultaRepository.saveAndFlush(consulta);
					redirectAttribute.addFlashAttribute("mensagemSucesso", "Consulta cadastrado com sucesso");
		}else {
			consultaRepository.saveAndFlush(consulta);
					redirectAttribute.addFlashAttribute("mensagemSucesso", "Consulta alterado com sucesso");
		}
	} catch (Exception e) {
		e.printStackTrace();
		redirectAttribute.addFlashAttribute("mensagemErro", "Erro Grave: "+ e.getMessage());
	}
	return "redirect:/consultas";
}

@RequestMapping("altera/{id}")
public String carregaAlterar(@PathVariable(name = "id")int id, Model model,RedirectAttributes redirectAtt) {

	try {
		Consulta consulta = consultaRepository.findById(id).get();
		
		List<Consulta> consultas = consultaRepository.findAll();
		Collections.sort(consultas);
		
		model.addAttribute("consultas", consultas);
		model.addAttribute("consulta", consulta);
	} catch (Exception e) {
		redirectAtt.addFlashAttribute("mensagemErro","ERRO GRAVE: "+e.getMessage());
	}
	
	return "consultas";
}
}