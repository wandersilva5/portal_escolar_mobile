import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';
import '../utils/mock_data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Esta classe gerencia autenticação
// No futuro, será fácil substituir o mock por uma API real
class AuthService extends ChangeNotifier {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Mock service para dados de teste
  final _mockDataService = MockDataService();

  // Estado de autenticação
  bool _isLoading = false;
  User? _currentUser;
  Institution? _currentInstitution;
  String? _token;

  // Getters
  bool get isLoading => _isLoading;
  User? get currentUser => _currentUser;
  Institution? get currentInstitution => _currentInstitution;
  bool get isLoggedIn => _currentUser != null && _token != null;

  // Inicializa o serviço e verifica se há uma sessão salva
  Future<void> init() async {
    try {
      await _loadUserSession();
    } catch (e) {
      print('Erro ao carregar sessão: $e');
    }
  }

  // Carrega dados da sessão salva localmente
  Future<void> _loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    final institutionJson = prefs.getString('institution');
    final token = prefs.getString('token');

    if (userJson != null && institutionJson != null && token != null) {
      _currentUser = User.fromJson(jsonDecode(userJson));
      _currentInstitution = Institution.fromJson(jsonDecode(institutionJson));
      _token = token;
    }
  }

  // Salva dados da sessão localmente
  Future<void> _saveUserSession() async {
    if (_currentUser != null && _currentInstitution != null && _token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(_currentUser!.toJson()));
      await prefs.setString(
        'institution',
        jsonEncode(_currentInstitution!.toJson()),
      );
      await prefs.setString('token', _token!);
    }
  }

 
  // Verifica se já existe um usuário logado e redireciona para a tela apropriada
  Future<bool> checkLoggedInUser(BuildContext context) async {
    await init(); // Verifica se há sessão salva
    
    // Se houver um usuário logado, redireciona para o dashboard
    if (isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
      return true;
    }
    
    return false;
  }

  // Método para fazer login
  // Recebe login (username ou email) e senha
  Future<Map<String, dynamic>> login(String login, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Chama o serviço mock para autenticar
      // No futuro, substitua por uma chamada HTTP para sua API
      final response = await _mockDataService.authenticateUser(login, password);

      if (response['success']) {
        final userData = response['data']['user'];
        final institutionData = response['data']['institution'];

        // Atualiza estado interno
        _currentUser = User.fromJson(userData);
        _currentInstitution = Institution.fromJson(institutionData);
        _token = response['data']['token'];

        // Salva sessão localmente
        await _saveUserSession();

        _isLoading = false;
        notifyListeners();

        return {'success': true, 'message': 'Login realizado com sucesso'};
      } else {
        _isLoading = false;
        notifyListeners();

        return {'success': false, 'message': response['message']};
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      return {'success': false, 'message': 'Erro ao realizar login: $e'};
    }
  }

  // Método para fazer logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Limpa dados da sessão
      _currentUser = null;
      _currentInstitution = null;
      _token = null;

      
    } catch (e) {
      print('Erro ao fazer logout: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para recuperar senha
  Future<Map<String, dynamic>> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Chama o serviço mock
      final response = await _mockDataService.requestPasswordReset(email);

      _isLoading = false;
      notifyListeners();

      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      return {
        'success': false,
        'message': 'Erro ao solicitar recuperação de senha: $e',
      };
    }
  }

  // Método para atualizar perfil do usuário
  Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> userData,
  ) async {
    if (_currentUser == null) {
      return {'success': false, 'message': 'Usuário não está logado'};
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Chama o serviço mock
      final response = await _mockDataService.updateUserProfile(
        _currentUser!.id,
        userData,
      );

      if (response['success']) {
        // Atualiza o usuário atual
        _currentUser = User.fromJson(response['data']);

        // Salva a sessão atualizada
        await _saveUserSession();
      }

      _isLoading = false;
      notifyListeners();

      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      return {'success': false, 'message': 'Erro ao atualizar perfil: $e'};
    }
  }

}
