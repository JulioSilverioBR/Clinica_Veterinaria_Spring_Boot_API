package com.qintess.clinica.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.qintess.clinica.service.UsuarioLoginService;


@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
	private UsuarioLoginService userDetailsService;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(encoder());
	}
	
	@Bean
	public PasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public AuthenticationManager customAuthenticationManager() throws Exception {
	  return authenticationManager();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.authorizeRequests()
				.antMatchers("/js/**", "/css/**", "/img/**").permitAll()
				.antMatchers("/gestao/**").hasRole("ADMIN")
				.antMatchers("/veterinario/**").hasRole("ADMIN")
				.antMatchers("/donos/**").hasRole("ADMIN")
				.antMatchers("/animais/**").hasRole("ADMIN")
				.antMatchers("/medicamentos/**").hasRole("ADMIN")
				.antMatchers("/consultas/**").hasRole("ADMIN")
				.antMatchers("/examesTratamento/**").hasRole("ADMIN")
				.antMatchers("/", "/registra").permitAll()
				.anyRequest().authenticated()
			.and()
			.formLogin()
				.loginPage("/")
				.loginProcessingUrl("/loga")
				.permitAll()
				.successForwardUrl("/gestao")
			.and()
			.logout()
				.logoutUrl("/logout")
				.invalidateHttpSession(true)
				.logoutSuccessUrl("/")
			.and()
			.exceptionHandling()
				.accessDeniedPage("/acessoNegado")
			.and()
			.csrf().disable();	
	}
}
