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
@Setter @Getter
public class DonoAnimal implements Comparable<DonoAnimal>{
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(length = 120,nullable = false)
	private String nome;

	@Column(length = 15, unique = true)
	private String cpf;
	
	private String endereco;
	
	@Column(length = 15,unique = true)
	private String telefone;

	@OneToMany(mappedBy = "dono")
	private List<Animal> animais = new ArrayList<Animal>();
	
	@Override
	public int compareTo(DonoAnimal o) {
		return this.getId().compareTo(o.getId());
	}
	
	public void addAnimal(Animal animal) {
		animais.add(animal);
		animal.setDono(this);
	}
	
	public void rmvEspecializacao(Animal animal) {
		animais.remove(animal);
		animal.setDono(null);
	}
}
