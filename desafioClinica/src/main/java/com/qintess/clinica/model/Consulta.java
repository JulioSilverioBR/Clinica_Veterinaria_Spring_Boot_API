package com.qintess.clinica.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import lombok.Getter;
import lombok.Setter;

//É importante registrar os atendimentos realizados, a data e hora de atendimento, os exames solicitados,
//os diagnósticos formulados e os tratamentos prescritos, assim como os veterinários responsáveis; 

@Entity
@Getter @Setter
public class Consulta implements Comparable<Consulta>{
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime dataHoraAtendimento;
	
	@OneToOne
	private Animal animal;
	
	private ConsultaTipo tipoConsulta;
	
	@ManyToMany(mappedBy = "consultas", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private List<Veterinario> veterinarios = new ArrayList<Veterinario>();
	
	private String diagnostico;
	
	@OneToMany(mappedBy = "consulta")
	private List<Tratamento> tratamentos = new ArrayList<Tratamento>();
	
	@OneToMany(mappedBy = "consulta")
	private List<Exame> exames = new ArrayList<Exame>();
	
	@Column(nullable = false, name = "custo")
	private Double custoAtendimento;

	@Override
	public int compareTo(Consulta o) {
		return this.id.compareTo(o.id);
	}
	
	public void addVeterinario(Veterinario veterinario) {
		veterinarios.add(veterinario);
		veterinario.addConsulta(this);
	}
	public void rmvVeterinario(Veterinario veterinario) {
		veterinarios.add(veterinario);
	}
	
	public void addExame(Exame exame) {
		exames.add(exame);
	}
	
	public void addTratamento(Tratamento tratamento) {
		tratamentos.add(tratamento);
	}
}
