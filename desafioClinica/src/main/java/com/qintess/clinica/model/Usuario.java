package com.qintess.clinica.model;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter @Setter
public class Usuario {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(length = 15,unique = true)
	private String usuarioNome;
	
	private String senha;
	
	private String nomeAtendente;
	@Column(length = 15, unique = true)
	private String cpf;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate dtNascimento;
	
	@OneToMany(cascade = CascadeType.ALL,mappedBy = "usuario")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<Papel> papeis;
}
