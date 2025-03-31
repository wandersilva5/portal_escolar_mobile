import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthController {
  // Singleton pattern
  static final AuthController _instance = AuthController._internal();
  
  // Construtor factory que retorna a mesma instância
  factory AuthController() => _instance;
  
  // Construtor privado
  AuthController._internal();
  
  // Estado do usuário atual
  User? _currentUser;
  
  // Getter para o usuário atual
  User? get currentUser => _currentUser;
  
  // Método para verificar se o usuário está logado
  bool get isLoggedIn => _currentUser != null;
  
  // Método de login
  Future<bool> login(String username, String password, BuildContext context) async {
    // Simulação de chamada de API para autenticação
    // Em um app real, esta seria uma requisição para seu backend
    
    try {
      // Simula um delay de rede
      await Future.delayed(const Duration(seconds: 2));
      
      // Verifica as credenciais (em um app real, isto seria verificado pelo backend)
      if (username == 'admin' && password == '123456') {
        // Login válido - criar objeto de usuário
        _currentUser = User(
          username: username,
          name: 'Administrador',
          email: 'admin@portalescolar.com',
          userType: 'admin',
        );
        
        return true;
      } else {
        // Limpa o usuário atual se as credenciais forem inválidas
        _currentUser = null;
        return false;
      }
    } catch (e) {
      // Qualquer erro durante o login
      _currentUser = null;
      return false;
    }
  }
  
  // Método de logout
  Future<void> logout() async {
    // Limpa dados do usuário e faz logout
    _currentUser = null;
    // Aqui você adicionaria código para limpar tokens, etc.
  }
  
  // Método para recuperar senha
  Future<bool> resetPassword(String email) async {
    // Simulação de envio de e-mail de recuperação
    await Future.delayed(const Duration(seconds: 1));
    return true; // Sempre retorna sucesso nesta simulação
  }
}