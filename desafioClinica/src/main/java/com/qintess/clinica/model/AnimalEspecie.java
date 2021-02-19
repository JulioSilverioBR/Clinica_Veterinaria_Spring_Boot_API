package com.qintess.clinica.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter @Setter
public class AnimalEspecie {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(length = 120,nullable = false)
	private String especie;

	@Column(nullable = false)
	@OneToMany(mappedBy = "especie")
	private List<Animal> animais = new ArrayList<Animal>();
	
}
