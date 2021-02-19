package com.qintess.clinica.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter @Setter
public class Tratamento {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@OneToMany(mappedBy = "tratamento")
	private List<MedicamentoEsp> medicamentos = new ArrayList<MedicamentoEsp>();
	
	private String observacao;
	
	@ManyToOne
	private Consulta consulta;
}
