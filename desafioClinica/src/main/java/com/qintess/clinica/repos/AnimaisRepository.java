package com.qintess.clinica.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.qintess.clinica.model.Animal;
import com.qintess.clinica.model.DonoAnimal;

public interface AnimaisRepository extends JpaRepository<Animal, Integer>{
	List<Animal> findByDono(DonoAnimal dono);
}
