package com.qintess.clinica.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.qintess.clinica.model.Veterinario;
import com.qintess.clinica.model.VeterinarioDisponibilidade;

public interface VeterinarioRepository extends JpaRepository<Veterinario, Integer>{
	List<Veterinario> findByDisponibilidade(VeterinarioDisponibilidade disponibilidade);
}
