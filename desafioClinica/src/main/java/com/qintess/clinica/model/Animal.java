package com.qintess.clinica.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter @Setter
public class Animal  implements Comparable<Animal>{
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer codigo;
	
	@Column(name = "nome",length = 120, nullable = false)
	private String nomeAnimal;

	@ManyToOne(fetch = FetchType.LAZY,optional = false)
	private AnimalEspecie especie;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	private AnimalRaca raca;

	@Column(nullable = false)
	private int idade;

	@JoinColumn
	@ManyToOne(optional = false)
	private DonoAnimal dono;

	@Override
	public int compareTo(Animal o) {
		return this.codigo.compareTo(o.codigo);
	}
}
