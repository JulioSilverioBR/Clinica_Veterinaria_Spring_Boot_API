package com.qintess.clinica.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.qintess.clinica.model.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

}
