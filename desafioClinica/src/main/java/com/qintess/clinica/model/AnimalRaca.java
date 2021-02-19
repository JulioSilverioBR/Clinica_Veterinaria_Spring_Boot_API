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
public class AnimalRaca {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(length = 120, nullable = false)
	private String raca;
	

	@Column(nullable = false)
	@OneToMany(mappedBy = "raca")
	private List<Animal> animal = new ArrayList<Animal>();
	
}
