import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';

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
    final matricula = studentMatricula ?? "04"; // Valor padrão
    final turma = studentTurma ?? "04"; // Valor padrão 
    final periodo = periodoLetivo ?? "2024"; // Valor padrão
    
    return Column(
      children: [
        // TopBar com foto do usuário, nome e menu
        Container(
          height: 72,
          color: Colors.blue[900],
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
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ) : null,
              ),
              const SizedBox(width: 12),
              
              // Nome e informações do estudante
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
                    ),
                    const SizedBox(height: 2),
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
}