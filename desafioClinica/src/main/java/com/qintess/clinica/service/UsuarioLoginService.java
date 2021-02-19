package com.qintess.clinica.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.User.UserBuilder;
import org.springframework.stereotype.Service;

import com.qintess.clinica.model.Usuario;
import com.qintess.clinica.repos.UsuarioRepository;

@Service
public class UsuarioLoginService implements UserDetailsService{
	
	@Autowired
	private UsuarioRepository usuarioRepo;
	
	@Override
	public UserDetails loadUserByUsername(String username) {
		
		Usuario usuario = null;
		UserBuilder builder = null;
		
		try {
			usuario = usuarioRepo.findAll().stream()
							.filter(x -> x.getUsuarioNome().equals(username))
							.findFirst()
							.get();
			
			if(usuario != null) {
				builder = User.withUsername(usuario.getNomeAtendente());
				builder.password(usuario.getSenha());
				String[] papeis = usuario.getPapeis().stream().map(a -> a.getNome()).toArray(String[]::new);
				builder.roles(papeis);
			}
		} catch (Exception e) {
			throw new UsernameNotFoundException("Usuário não encontrado!");
		}
		
		return builder.build();
	}
}
