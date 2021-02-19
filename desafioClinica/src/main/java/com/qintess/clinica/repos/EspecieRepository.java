package com.qintess.clinica.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.qintess.clinica.model.AnimalEspecie;

public interface EspecieRepository extends JpaRepository<AnimalEspecie, Integer>{

}
