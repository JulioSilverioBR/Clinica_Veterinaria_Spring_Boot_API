package com.qintess.clinica.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter @Setter
public class Veterinario implements Comparable<Veterinario>{
	@Id
	@Column(nullable = false)
	private Integer crv;
	
	@Column(nullable = false)
	private String nome;

	@Column(nullable = false)
	private String endereco;

	@Column(nullable = false,length = 15)
	private String telefone;
	
	@Column(nullable = false)
	private VeterinarioDisponibilidade disponibilidade;

	@ManyToMany(mappedBy = "veterinarios",cascade = CascadeType.ALL)
	private List<VeterinarioEspecializacao> especializacoes = new ArrayList<VeterinarioEspecializacao>();
	
	
	@Column(columnDefinition = "boolean default true")
	private boolean ativo;
	
	@ManyToMany
	private List<Consulta> consultas = new ArrayList<Consulta>();
	
	public void addConsulta(Consulta consulta) {
		consultas.add(consulta);
	}
	
	public void addEspecializacao(VeterinarioEspecializacao especializacao) {
		especializacoes.add(especializacao);
		especializacao.getVeterinarios().add(this);
	}
	
	public void rmvEspecializacao(VeterinarioEspecializacao especializacao) {
		especializacoes.remove(especializacao);
		especializacao.getVeterinarios().remove(this);
	}

	@Override
	public int compareTo(Veterinario o) {
		return this.getCrv().compareTo(o.getCrv());
	}
	
}
