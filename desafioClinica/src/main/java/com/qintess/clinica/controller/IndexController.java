package com.qintess.clinica.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qintess.clinica.model.Papel;
import com.qintess.clinica.model.Usuario;
import com.qintess.clinica.repos.PapelRepository;
import com.qintess.clinica.repos.UsuarioRepository;


@Controller
public class IndexController {
	
	@Autowired
	private UsuarioRepository usuarioRepository;
	

	@Autowired
	private PapelRepository papelRepository;

	@Autowired
	private AuthenticationManager authenticationManager;
	@RequestMapping("")
	public String carregaIndex(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		model.addAttribute("usuarioLogado", auth);
		return "index";
	}
	
	@RequestMapping("/registra")
	public String registra(@ModelAttribute Usuario usuario,
							RedirectAttributes redirectAtt,
							HttpServletRequest req) {
	String senhaOriginal = usuario.getSenha();
	try {
		usuarioRepository.findAll()
			.stream()
			.filter(a -> a.getUsuarioNome().equals(usuario.getUsuarioNome()))
			.findFirst()
			.get();
		
		redirectAtt.addFlashAttribute("mensagemErro", "Usuário já cadastrado no sistema");
		return "redirect:/";
	}catch (Exception e) {
		// TODO: handle exception
	}
	PasswordEncoder passEncoder = new BCryptPasswordEncoder();
	String hashedPass = passEncoder.encode(usuario.getSenha());
	usuario.setSenha(hashedPass);
	
	usuarioRepository.save(usuario);
	
	List<Papel> papeis = new ArrayList<Papel>();
	Papel papel = new Papel();
	
	papel.setNome("ADMIN");
	
	papel.setUsuario(usuario);
	papeis.add(papel);
	
	papelRepository.save(papel);
	
	UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(usuario.getUsuarioNome(),senhaOriginal);
	authToken.setDetails(new WebAuthenticationDetails(req));
	
	Authentication authentication = authenticationManager.authenticate(authToken);
	
	SecurityContextHolder.getContext().setAuthentication(authentication);
	
	return "redirect:/gestao";
}

}
