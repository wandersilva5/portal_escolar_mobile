import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Portal Escolar';
  static const String appSubtitle = 'Conecte-se ao seu ambiente escolar';
  
  // Mensagens
  static const String forgotPassword = 'Esqueceu a senha?';
  static const String login = 'ENTRAR';
  static const String noAccount = 'Não tem conta? ';
  static const String register = 'Cadastre-se';
  static const String processingLogin = 'Processando login...';
  static const String userHint = 'Usuário';
  static const String passwordHint = 'Senha';
  static const String userValidationMessage = 'Por favor, insira seu usuário';
  static const String passwordValidationMessage = 'Por favor, insira sua senha';
  
  // Tempos
  static const int splashDuration = 3; // segundos
  
  // Cores
  static const Color primaryDark = Color(0xFF1A237E);  // Deep Indigo
  static const Color primaryMid = Color(0xFF3949AB);   // Mid Indigo
  static const Color primaryLight = Color(0xFF1E88E5); // Blue
  
  // Gradientes
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDark, primaryMid],
  );
  
  static const LinearGradient loginGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primaryMid, primaryLight],
  );
}