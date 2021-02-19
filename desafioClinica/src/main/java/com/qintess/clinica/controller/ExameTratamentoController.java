package com.qintess.clinica.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qintess.clinica.model.Consulta;
import com.qintess.clinica.model.Exame;
import com.qintess.clinica.model.Tratamento;
import com.qintess.clinica.repos.ConsultasRepository;
import com.qintess.clinica.repos.ExamesRepository;
import com.qintess.clinica.repos.MedicamentoRepository;
import com.qintess.clinica.repos.TratamentoRepository;

@Controller
@RequestMapping("/examesTratamento")
public class ExameTratamentoController {
	
	@Autowired
	private ExamesRepository examesRepository;
	@Autowired
	private TratamentoRepository tratamentoRepository;
	@Autowired
	private ConsultasRepository consultasRepository;
	
	@Autowired
	private MedicamentoRepository medicamentoRepository;
	
	@RequestMapping("")
	public String carregaExameTratamento(Model model) {
		model.addAttribute("consultas", consultasRepository.findAll());
		return "exameTratamento";
	}
	
	@RequestMapping("carregaConsulta")
	public String carregaConsulta(@ModelAttribute Consulta consulta, Model model) {
		model.addAttribute("consultaPrincipal", consultasRepository.findById(consulta.getId()).get());
		model.addAttribute("consultas", consultasRepository.findAll());
		model.addAttribute("exame", new Exame());
		model.addAttribute("tratamento", new Tratamento());
		model.addAttribute("medicamentos", medicamentoRepository.findAll());
		return "exameTratamento";
	}
	
	@RequestMapping("salvaTratamento")
	public String salvarTratamento(@ModelAttribute Tratamento tratamento, RedirectAttributes redirectAttribute) {
		tratamentoRepository.saveAndFlush(tratamento);
		redirectAttribute.addFlashAttribute("mensagemSucesso", "Tratamento cadastrado com sucesso");
		return "redirect:/examesTratamento";
	}
	
	@RequestMapping("salvaExame")
	public String salvarTratamento(@ModelAttribute Exame exame, RedirectAttributes redirectAttribute) {
		examesRepository.saveAndFlush(exame);
		redirectAttribute.addFlashAttribute("mensagemSucesso", "Exame cadastrado com sucesso");
		return "redirect:/examesTratamento";
	}
}
