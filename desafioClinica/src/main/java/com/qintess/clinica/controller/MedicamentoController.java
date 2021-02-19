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

import com.qintess.clinica.model.Medicamento;
import com.qintess.clinica.repos.MedicamentoRepository;

@Controller
@RequestMapping("/medicamentos")
public class MedicamentoController {
	@Autowired
	private MedicamentoRepository medicamentoRepository;
	
	@RequestMapping("")
	public String carregaMedicament0(Model model) {
		model.addAttribute("medicamento", new Medicamento());
		List<Medicamento> medicamentos  = medicamentoRepository.findAll();
		Collections.sort(medicamentos);
		model.addAttribute("medicamentos", medicamentos);

		return "medicamento";
	}
	
	@RequestMapping("/salva")
	public String salva(@ModelAttribute @Persistent Medicamento medicamento,
						RedirectAttributes redirectAttribute) {
		try {
			
			if(medicamento.getCodigo() == null)
				redirectAttribute.addFlashAttribute("mensagemSucesso", "Medicamento cadastrado com sucesso");
				else
				redirectAttribute.addFlashAttribute("mensagemSucesso", "Medicamento alterado com sucesso");
				medicamentoRepository.save(medicamento);
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttribute.addFlashAttribute("mensagemErro", "Erro Grave: "+ e.getMessage());
		}
		return "redirect:/medicamentos";
	}
	
	@RequestMapping("/deleta/{codigo}")
	public String deleta(@PathVariable(name = "codigo") int codigo,RedirectAttributes redirectAttribute) {
		Medicamento medicamento = medicamentoRepository.findById(codigo).get();
		
		medicamentoRepository.delete(medicamento);
		redirectAttribute.addFlashAttribute("mensagemSucesso", "Medicamento deletado com sucesso");
		
		return "redirect:/produto";
	}
	
	@RequestMapping("altera/{codigo}")
	public String carregaAlterar(@PathVariable(name = "codigo")int codigo, Model model,RedirectAttributes redirectAtt) {

		try {
			Medicamento medicamento = medicamentoRepository.findById(codigo).get();
			
			
			List<Medicamento> medicamentos = medicamentoRepository.findAll();
			Collections.sort(medicamentos);
			
			model.addAttribute("medicamento", medicamento);
			model.addAttribute("medicamentos", medicamentos);
			
		} catch (Exception e) {
			redirectAtt.addFlashAttribute("mensagemErro","ERRO GRAVE: "+e.getMessage());
		}
		
		return "medicamento";
	}
}
