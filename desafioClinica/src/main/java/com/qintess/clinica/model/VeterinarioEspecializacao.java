package com.qintess.clinica.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import lombok.Getter;
import lombok.Setter;
@Entity
@Getter @Setter 
public class VeterinarioEspecializacao {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(nullable = false)
	private String especializacao;
	
	@ManyToMany
	private List<Veterinario> veterinarios = new ArrayList<Veterinario>();

	@Override
	public String toString() {
		return especializacao.toString();
	}
	
	
}
