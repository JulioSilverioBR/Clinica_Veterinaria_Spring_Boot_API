package com.qintess.clinica.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter @Setter
public class Medicamento implements Comparable<Medicamento>{
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer codigo;

	@Column(nullable = false)
	private String nome;

	@Column(nullable = false)
	private String descricao;

	@Override
	public int compareTo(Medicamento o) {
		return this.codigo.compareTo(o.codigo);
	}
	
}
