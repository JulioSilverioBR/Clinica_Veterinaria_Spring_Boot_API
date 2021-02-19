package com.qintess.clinica.model;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import lombok.Getter;
import lombok.Setter;

@Entity
@Setter @Getter
public class MedicamentoEsp {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY) 
	private int id;
	
	@OneToOne(optional = false)
	private Medicamento medicamento;
	
	@DateTimeFormat(iso = ISO.TIME)
	private LocalTime horariosDeAplicacao;
	
	@Column(nullable = false)
	private int quantidadeAplicacao;
	
	@ManyToOne(optional = false)
	private Tratamento tratamento;
}

