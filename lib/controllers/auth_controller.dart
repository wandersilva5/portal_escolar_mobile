import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';
import '../services/auth_service.dart';

class AuthController {
  // Singleton pattern
  static final AuthController _instance = AuthController._internal();
  
  // Construtor factory que retorna a mesma instância
  factory AuthController() => _instance;
  
  // Construtor privado
  AuthController._internal() {
    // Inicializa o serviço de autenticação
    _authService.init();
  }
  
  // Serviço de autenticação que contém a lógica real
  final AuthService _authService = AuthService();
  
  // Getters que delegam para o serviço
  User? get currentUser => _authService.currentUser;
  Institution? get currentInstitution => _authService.currentInstitution;
  bool get isLoggedIn => _authService.isLoggedIn;
  bool get isLoading => _authService.isLoading;
  
  // Método de login
  Future<Map<String, dynamic>> login(String login, String password, BuildContext context) async {
    try {
      final result = await _authService.login(login, password);
      
      if (result['success']) {
        // Informar o usuário sobre sucesso
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login realizado com sucesso')),
          );
        }
      } else {
        // Informar o usuário sobre falha
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );
        }
      }
      
      return result;
    } catch (e) {
      // Lidar com erros inesperados
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro inesperado: ${e.toString()}')),
        );
      }
      
      return {
        'success': false,
        'message': 'Erro inesperado durante login'
      };
    }
  }
  
  // Método de logout
  Future<void> logout(BuildContext context) async {
    try {
      await _authService.logout();
      
      // Informar o usuário
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout realizado com sucesso')),
        );
      }
      
      // Navegar de volta para a tela de login
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      // Lidar com erros
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer logout: ${e.toString()}')),
        );
      }
    }
  }
  
  // Método para recuperar senha
  Future<bool> resetPassword(String email, BuildContext context) async {
    try {
      final result = await _authService.resetPassword(email);
      
      // Informar o usuário
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
      }
      
      return result['success'];
    } catch (e) {
      // Lidar com erros
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao recuperar senha: ${e.toString()}')),
        );
      }
      
      return false;
    }
  }
  
  // Método para atualizar perfil
  Future<bool> updateProfile(Map<String, dynamic> userData, BuildContext context) async {
    try {
      final result = await _authService.updateProfile(userData);
      
      // Informar o usuário
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
      }
      
      return result['success'];
    } catch (e) {
      // Lidar com erros
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar perfil: ${e.toString()}')),
        );
      }
      
      return false;
    }
  }
}