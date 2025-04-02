import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';

class TeacherDashboard extends StatelessWidget {
  final User user;
  final Institution institution;

  const TeacherDashboard({
    super.key, 
    required this.user, 
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: 24),
            _buildTodaySchedule(),
            const SizedBox(height: 24),
            _buildClassesSection(),
            const SizedBox(height: 24),
            _buildPendingAssignmentsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    // Obter a hora do dia para saudação personalizada
    final hour = DateTime.now().hour;
    String greeting;
    
    if (hour < 12) {
      greeting = 'Bom dia';
    } else if (hour < 18) {
      greeting = 'Boa tarde';
    } else {
      greeting = 'Boa noite';
    }
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: institution.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.school,
            size: 45,
            color: institution.primaryColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, ${user.name}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Você tem 3 turmas hoje e 15 tarefas para corrigir.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySchedule() {
    // Lista de aulas fictícias para o dia
    final List<Map<String, String>> classes = [
      {
        'time': '08:00 - 09:30',
        'subject': 'Matemática',
        'class': '9º Ano A',
        'room': 'Sala 103',
      },
      {
        'time': '10:00 - 11:30',
        'subject': 'Matemática',
        'class': '8º Ano B',
        'room': 'Sala 105',
      },
      {
        'time': '13:00 - 14:30',
        'subject': 'Geometria',
        'class': '7º Ano C',
        'room': 'Sala 201',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Agenda de Hoje',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: institution.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: classes.map((classInfo) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: institution.secondaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        classInfo['time']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classInfo['subject']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${classInfo['class']} • ${classInfo['room']}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: institution.secondaryColor,
                        size: 18,
                      ),
                      onPressed: () {
                        // Navegação para detalhes da aula
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildClassesSection() {
    // Lista fictícia de turmas
    final List<Map<String, dynamic>> classes = [
      {
        'name': '9º Ano A',
        'subject': 'Matemática',
        'students': 32,
        'progress': 0.75,
      },
      {
        'name': '8º Ano B',
        'subject': 'Matemática',
        'students': 28,
        'progress': 0.65,
      },
      {
        'name': '7º Ano C',
        'subject': 'Geometria',
        'students': 30,
        'progress': 0.50,
      },
      {
        'name': '6º Ano D',
        'subject': 'Matemática',
        'students': 35,
        'progress': 0.80,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Minhas Turmas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Ver Todas',
                style: TextStyle(
                  color: institution.secondaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final classInfo = classes[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: institution.secondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classInfo['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      classInfo['subject']!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${classInfo['students']} alunos',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: classInfo['progress'] as double,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        institution.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Progresso do conteúdo: ${((classInfo['progress'] as double) * 100).toInt()}%',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPendingAssignmentsSection() {
    // Lista fictícia de tarefas pendentes
    final List<Map<String, dynamic>> assignments = [
      {
        'title': 'Correção da Prova Bimestral',
        'class': '9º Ano A',
        'due': 'Hoje',
        'urgent': true,
      },
      {
        'title': 'Lançamento de Notas',
        'class': '8º Ano B',
        'due': 'Amanhã',
        'urgent': true,
      },
      {
        'title': 'Plano de Aula Semanal',
        'class': 'Todas as turmas',
        'due': 'Em 2 dias',
        'urgent': false,
      },
      {
        'title': 'Formulário de Avaliação',
        'class': '7º Ano C',
        'due': 'Em 3 dias',
        'urgent': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tarefas Pendentes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: institution.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final assignment = assignments[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: assignment['urgent'] == true
                      ? Colors.red.withOpacity(0.2)
                      : institution.secondaryColor.withOpacity(0.3),
                  child: Icon(
                    assignment['urgent'] == true ? Icons.priority_high : Icons.assignment,
                    color: assignment['urgent'] == true ? Colors.red.shade300 : institution.secondaryColor,
                    size: 20,
                  ),
                ),
                title: Text(
                  assignment['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  assignment['class']!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: assignment['urgent'] == true
                        ? Colors.red.withOpacity(0.2)
                        : institution.secondaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    assignment['due']!,
                    style: TextStyle(
                      color: assignment['urgent'] == true
                          ? Colors.red.shade300
                          : Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}