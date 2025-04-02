import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';
import '../utils/constants.dart';

class AppTopBar extends StatelessWidget {
  final User user;
  final Institution institution;
  final VoidCallback onMenuPressed;
  final String? studentName;
  final String? studentMatricula;
  final String? studentTurma;
  final String? periodoLetivo;

  const AppTopBar({
    super.key,
    required this.user,
    required this.institution,
    required this.onMenuPressed,
    this.studentName,
    this.studentMatricula,
    this.studentTurma,
    this.periodoLetivo,
  });

  @override
  Widget build(BuildContext context) {
    // Determinar valores a exibir (usar dados do aluno ou do usuário)
    final displayName = studentName ?? user.name;
    final matricula = studentMatricula ?? "0"; // Valor padrão
    final turma = studentTurma ?? "00"; // Valor padrão 
    final periodo = periodoLetivo ?? "0000"; // Valor padrão
    
    return Column(
      children: [
        // TopBar com foto do usuário, nome e menu
        Container(
          height: 72,
          color: AppConstants.primaryDark, // Using primary color from constants
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Foto do usuário em círculo
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                backgroundImage: user.profileImage != null ? 
                  NetworkImage(user.profileImage!) : 
                  const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                child: user.profileImage == null ? 
                  Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: AppConstants.primaryDark, // Using primary color from constants
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ) : null,
              ),
              const SizedBox(width: 12),
              
              // Nome e informações do estudante ou tipo de usuário
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    
                    // Show student information only for students, otherwise show user type
                    if (user.isStudent || user.isGuardian) 
                      // Student info (matrícula and turma)
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(text: 'Matrícula: $matricula'),
                            const TextSpan(text: '    '),
                            TextSpan(text: 'Turma: $turma'),
                          ],
                        ),
                      )
                    else
                      // User type for other profiles
                      Text(
                        _getUserTypeLabel(user.userType),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      
                    const SizedBox(height: 2),
                    
                    // Show period information only for students
                    if (user.isStudent || user.isGuardian)
                      Text(
                        'Período Letivo: $periodo',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              
              // Botão do menu
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: onMenuPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Helper method to get user type label
  String _getUserTypeLabel(String userType) {
    switch (userType) {
      case 'admin':
        return 'Administrador';
      case 'teacher':
        return 'Professor';
      case 'student':
        return 'Aluno';
      case 'director':
        return 'Diretor';
      case 'guardian':
        return 'Responsável';
      default:
        return 'Usuário';
    }
  }
}