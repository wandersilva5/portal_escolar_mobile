// Esta classe simula uma API para testes
// Quando você estiver pronto para integrar com uma API real,
// substitua os métodos por chamadas HTTP reais

import 'dart:convert';
import 'dart:async';
import '../models/user_model.dart';
import '../models/institution_model.dart';

class MockDataService {
  // Singleton pattern
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  // Dados simulados de usuários
  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'username': 'admin',
      'email': 'admin@portalescolar.com',
      'password': '123456',
      'name': 'Administrador',
      'userType': 'admin',
      'profileImage': 'https://i.pravatar.cc/150?img=1',
      'institutionId': '1',
    },
    {
      'id': '2',
      'username': 'professor',
      'email': 'professor@portalescolar.com',
      'password': '123456',
      'name': 'João Silva',
      'userType': 'teacher',
      'profileImage': 'https://i.pravatar.cc/150?img=8',
      'institutionId': '1',
    },
    {
      'id': '3',
      'username': 'aluno',
      'email': 'aluno@portalescolar.com',
      'password': '123456',
      'name': 'Maria Santos',
      'userType': 'student',
      'profileImage': 'https://i.pravatar.cc/150?img=5',
      'institutionId': '1',
    },
    {
      'id': '4',
      'username': 'diretor',
      'email': 'diretor@escola2.com',
      'password': '123456',
      'name': 'Carlos Oliveira',
      'userType': 'director',
      'profileImage': 'https://i.pravatar.cc/150?img=12',
      'institutionId': '2',
    },
    {
      'id': '5',
      'username': 'guardian',
      'email': 'responsavel@portalescolar.com',
      'password': '123456',
      'name': 'Tatiane Silva',
      'userType': 'guardian',
      'profileImage': 'https://i.pravatar.cc/150?img=5',
      'institutionId': '1',
    },
  ];

  // Dados simulados de instituições
  final List<Map<String, dynamic>> _institutions = [
    {
      'id': '1',
      'name': 'Escola Municipal João da Silva',
      'address': 'Rua das Flores, 123',
      'city': 'São Paulo',
      'state': 'SP',
      'phone': '(11) 1234-5678',
      'email': 'contato@escolajoao.edu.br',
      'logo': 'https://via.placeholder.com/150',
      'primaryColor': '#1A237E',
      'secondaryColor': '#3949AB',
    },
    {
      'id': '2',
      'name': 'Colégio Estadual Maria de Souza',
      'address': 'Av. Central, 456',
      'city': 'Rio de Janeiro',
      'state': 'RJ',
      'phone': '(21) 9876-5432',
      'email': 'contato@colegiomaria.edu.br',
      'logo': 'https://via.placeholder.com/150',
      'primaryColor': '#004D40',
      'secondaryColor': '#00796B',
    },
  ];

  // Método para autenticar usuário
  Future<Map<String, dynamic>> authenticateUser(
    String login,
    String password,
  ) async {
    // Simula atraso de rede
    await Future.delayed(const Duration(seconds: 1));

    // Verifica se o login é email ou username
    final user = _users.firstWhere(
      (user) =>
          (user['email'].toLowerCase() == login.toLowerCase())
              //|| user['username'].toLowerCase() == login.toLowerCase()) 
              && user['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) {
      // Retorna erro se usuário não for encontrado
      return {
        'success': false,
        'message': 'Credenciais inválidas',
        'data': null,
      };
    }

    // Remove senha antes de retornar os dados
    final userData = Map<String, dynamic>.from(user);
    userData.remove('password');

    // Busca dados da instituição do usuário
    final institution = await getInstitutionById(userData['institutionId']);

    return {
      'success': true,
      'message': 'Login realizado com sucesso',
      'data': {
        'user': userData,
        'institution': institution['data'],
        'token': 'mock-jwt-token-${DateTime.now().millisecondsSinceEpoch}',
      },
    };
  }

  // Método para buscar usuário por ID
  Future<Map<String, dynamic>> getUserById(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final user = _users.firstWhere(
      (user) => user['id'] == userId,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return {
        'success': false,
        'message': 'Usuário não encontrado',
        'data': null,
      };
    }

    // Remove senha antes de retornar os dados
    final userData = Map<String, dynamic>.from(user);
    userData.remove('password');

    return {'success': true, 'message': 'Usuário encontrado', 'data': userData};
  }

  // Método para buscar instituição por ID
  Future<Map<String, dynamic>> getInstitutionById(String institutionId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final institution = _institutions.firstWhere(
      (inst) => inst['id'] == institutionId,
      orElse: () => {},
    );

    if (institution.isEmpty) {
      return {
        'success': false,
        'message': 'Instituição não encontrada',
        'data': null,
      };
    }

    return {
      'success': true,
      'message': 'Instituição encontrada',
      'data': institution,
    };
  }

  // Método para listar todas as instituições
  Future<Map<String, dynamic>> getAllInstitutions() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'success': true,
      'message': 'Instituições encontradas',
      'data': _institutions,
    };
  }

  // Método para listar usuários por tipo
  Future<Map<String, dynamic>> getUsersByType(String userType) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final filteredUsers =
        _users.where((user) => user['userType'] == userType).map((user) {
          final userData = Map<String, dynamic>.from(user);
          userData.remove('password');
          return userData;
        }).toList();

    return {
      'success': true,
      'message': 'Usuários encontrados',
      'data': filteredUsers,
    };
  }

  // Método para recuperar senha (simulação)
  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    final user = _users.firstWhere(
      (user) => user['email'] == email,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return {
        'success': false,
        'message': 'Email não encontrado',
        'data': null,
      };
    }

    return {
      'success': true,
      'message': 'Email de recuperação enviado com sucesso',
      'data': null,
    };
  }

  // Método para simular atualização de perfil
  Future<Map<String, dynamic>> updateUserProfile(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final index = _users.indexWhere((user) => user['id'] == userId);

    if (index == -1) {
      return {
        'success': false,
        'message': 'Usuário não encontrado',
        'data': null,
      };
    }

    // Dados que não podem ser alterados pelo usuário
    userData.remove('id');
    userData.remove('userType');
    userData.remove('institutionId');

    // Atualiza os dados do usuário
    _users[index] = {..._users[index], ...userData};

    // Remove a senha antes de retornar
    final updatedUser = Map<String, dynamic>.from(_users[index]);
    updatedUser.remove('password');

    return {
      'success': true,
      'message': 'Perfil atualizado com sucesso',
      'data': updatedUser,
    };
  }

  // Dentro da classe MockDataService, adicione os dados dos sliders:
  final Map<String, List<Map<String, dynamic>>> _slidersData = {
    '1': [
      {
        'id': '1',
        'institutionId': '1',
        'imageUrl':
            'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1000',
        'title': 'Bem-vindo à Escola João da Silva',
        'description': 'Educação de qualidade para o futuro',
        'order': 1,
        'isActive': true,
      },
      {
        'id': '2',
        'institutionId': '1',
        'imageUrl':
            'https://images.unsplash.com/photo-1577896851231-70ef18881754?q=80&w=1000',
        'title': 'Matrículas Abertas',
        'description': 'Inscreva-se para o próximo ano letivo',
        'order': 2,
        'isActive': true,
      },
      {
        'id': '3',
        'institutionId': '1',
        'imageUrl':
            'https://images.unsplash.com/photo-1580582932707-520aed937b7b?q=80&w=1000',
        'title': 'Feira de Ciências',
        'description': 'Apresentação de projetos no dia 15',
        'order': 3,
        'isActive': true,
      },
    ],
    '2': [
      {
        'id': '4',
        'institutionId': '2',
        'imageUrl':
            'https://images.unsplash.com/photo-1532012197267-da84d127e765?q=80&w=1000',
        'title': 'Colégio Estadual Maria de Souza',
        'description': 'Preparando líderes do amanhã',
        'order': 1,
        'isActive': true,
      },
      {
        'id': '5',
        'institutionId': '2',
        'imageUrl':
            'https://images.unsplash.com/photo-1555967522-37949fc21dcb?q=80&w=1000',
        'title': 'Novos Laboratórios',
        'description': 'Investindo no futuro da educação',
        'order': 2,
        'isActive': true,
      },
      {
        'id': '6',
        'institutionId': '2',
        'imageUrl':
            'https://images.unsplash.com/photo-1536337005238-94b997371b40?q=80&w=1000',
        'title': 'Olimpíada de Matemática',
        'description': 'Inscrições até 20/11',
        'order': 3,
        'isActive': true,
      },
    ],
  };

  // Método para obter imagens do slider por instituição
  Future<Map<String, dynamic>> getSlidersByInstitution(
    String institutionId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final sliders = _slidersData[institutionId];

    if (sliders == null || sliders.isEmpty) {
      return {
        'success': false,
        'message': 'Nenhuma imagem de slider encontrada para esta instituição',
        'data': [],
      };
    }

    return {
      'success': true,
      'message': 'Imagens de slider encontradas',
      'data': sliders,
    };
  }

  // Método para adicionar uma nova imagem ao slider
  Future<Map<String, dynamic>> addSliderImage(
    Map<String, dynamic> sliderData,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final institutionId = sliderData['institutionId'];
    final sliders = _slidersData[institutionId];

    if (sliders == null) {
      _slidersData[institutionId] = [];
    }

    final newSliderId = DateTime.now().millisecondsSinceEpoch.toString();
    final newSlider = {...sliderData, 'id': newSliderId};

    _slidersData[institutionId]!.add(newSlider);

    return {
      'success': true,
      'message': 'Imagem de slider adicionada com sucesso',
      'data': newSlider,
    };
  }

  // Método para remover uma imagem do slider
  Future<Map<String, dynamic>> removeSliderImage(
    String sliderId,
    String institutionId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final sliders = _slidersData[institutionId];

    if (sliders == null) {
      return {
        'success': false,
        'message': 'Nenhuma imagem de slider encontrada para esta instituição',
        'data': null,
      };
    }

    final index = sliders.indexWhere((slider) => slider['id'] == sliderId);

    if (index == -1) {
      return {
        'success': false,
        'message': 'Imagem de slider não encontrada',
        'data': null,
      };
    }

    final removedSlider = sliders.removeAt(index);

    return {
      'success': true,
      'message': 'Imagem de slider removida com sucesso',
      'data': removedSlider,
    };
  }

  // Método para atualizar uma imagem do slider
  Future<Map<String, dynamic>> updateSliderImage(
    String sliderId,
    Map<String, dynamic> updatedData,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final institutionId = updatedData['institutionId'];
    final sliders = _slidersData[institutionId];

    if (sliders == null) {
      return {
        'success': false,
        'message': 'Nenhuma imagem de slider encontrada para esta instituição',
        'data': null,
      };
    }

    final index = sliders.indexWhere((slider) => slider['id'] == sliderId);

    if (index == -1) {
      return {
        'success': false,
        'message': 'Imagem de slider não encontrada',
        'data': null,
      };
    }

    // Atualizar os dados mantendo o ID original
    sliders[index] = {...updatedData, 'id': sliderId};

    return {
      'success': true,
      'message': 'Imagem de slider atualizada com sucesso',
      'data': sliders[index],
    };
  }
}
