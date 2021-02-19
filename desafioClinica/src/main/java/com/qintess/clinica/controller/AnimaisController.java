package com.qintess.clinica.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.annotation.Persistent;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qintess.clinica.model.Animal;
import com.qintess.clinica.model.DonoAnimal;
import com.qintess.clinica.repos.AnimaisRepository;
import com.qintess.clinica.repos.DonosRepository;
import com.qintess.clinica.repos.EspecieRepository;
import com.qintess.clinica.repos.RacaRepository;

@Controller
@RequestMapping("/animais")
public class AnimaisController {
	@Autowired
	private AnimaisRepository animalRepository;
	
	@Autowired
	private DonosRepository donoRepository;
	

	@Autowired
	private EspecieRepository especieRepository;
	

	@Autowired
	private RacaRepository racaRepository;
	
	@RequestMapping("")
	public String carregaAnimal(Model model) {
		model.addAttribute("animal", new Animal());
		List<Animal> animais = animalRepository.findAll();
		Collections.sort(animais);
		model.addAttribute("animais", animais);
		
		List<DonoAnimal> donos = donoRepository.findAll();
		Collections.sort(donos);
		
		model.addAttribute("donos", donos);
		return "animais";
	}

	@RequestMapping("/salva")
	public String salva(@ModelAttribute @Persistent Animal animal,
						RedirectAttributes redirectAttribute) {
		try {
			
			if(animal.getCodigo() == null)
				redirectAttribute.addFlashAttribute("mensagemSucesso", "Animal cadastrado com sucesso");
				else
				redirectAttribute.addFlashAttribute("mensagemSucesso", "Animal alterado com sucesso");

			System.out.println(animal.getDono().getId());
			DonoAnimal temp = donoRepository.findById(animal.getDono().getId()).get();
			temp.addAnimal(animal);
			especieRepository.save(animal.getEspecie());
			racaRepository.save(animal.getRaca());
			animalRepository.save(animal);
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttribute.addFlashAttribute("mensagemErro", "Erro Grave: "+ e.getMessage());
		}
		return "redirect:/animais";
	}
	
	@RequestMapping("altera/{codigo}")
	public String carregaAlterar(@PathVariable(name = "codigo")int codigo, Model model,RedirectAttributes redirectAtt) {

		try {
			Animal animal = animalRepository.findById(codigo).get();
			
			List<DonoAnimal> donos = donoRepository.findAll();
			Collections.sort(donos);
			
			List<Animal> animais = animalRepository.findAll();
			Collections.sort(animais);
			
			model.addAttribute("donos", donos);
			model.addAttribute("animal", animal);
			model.addAttribute("animais", animais);
			
		} catch (Exception e) {
			redirectAtt.addFlashAttribute("mensagemErro","ERRO GRAVE: "+e.getMessage());
		}
		
		return "animais";
	}
	
	
	
}
