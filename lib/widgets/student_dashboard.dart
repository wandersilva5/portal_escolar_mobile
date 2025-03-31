import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';

class StudentDashboard extends StatelessWidget {
  final User user;
  final Institution institution;

  const StudentDashboard({
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
            _buildGradesSection(),
            const SizedBox(height: 24),
            _buildPendingTasksSection(),
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
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.backpack, size: 45, color: Colors.white.withOpacity(0.9)),
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
                  'Você tem 4 aulas hoje e 3 tarefas para entregar esta semana.',
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
        'time': '07:30 - 08:20',
        'subject': 'Matemática',
        'teacher': 'Prof. João Silva',
        'room': 'Sala 103',
      },
      {
        'time': '08:20 - 09:10',
        'subject': 'Português',
        'teacher': 'Profa. Maria Souza',
        'room': 'Sala 103',
      },
      {
        'time': '09:30 - 10:20',
        'subject': 'História',
        'teacher': 'Prof. Carlos Oliveira',
        'room': 'Sala 103',
      },
      {
        'time': '10:20 - 11:10',
        'subject': 'Geografia',
        'teacher': 'Profa. Ana Santos',
        'room': 'Sala 103',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horário de Hoje',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children:
                classes.map((classInfo) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
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
                                '${classInfo['teacher']} • ${classInfo['room']}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
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

  Widget _buildGradesSection() {
    // Dados fictícios de notas
    final List<Map<String, dynamic>> subjects = [
      {
        'name': 'Matemática',
        'grade': 8.5,
        'maxGrade': 10.0,
        'teacher': 'Prof. João Silva',
      },
      {
        'name': 'Português',
        'grade': 7.8,
        'maxGrade': 10.0,
        'teacher': 'Profa. Maria Souza',
      },
      {
        'name': 'História',
        'grade': 9.0,
        'maxGrade': 10.0,
        'teacher': 'Prof. Carlos Oliveira',
      },
      {
        'name': 'Geografia',
        'grade': 8.2,
        'maxGrade': 10.0,
        'teacher': 'Profa. Ana Santos',
      },
      {
        'name': 'Biologia',
        'grade': 7.5,
        'maxGrade': 10.0,
        'teacher': 'Prof. Roberto Martins',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Minhas Notas',
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
                  color: Colors.white.withOpacity(0.8),
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
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              final percentage =
                  (subject['grade'] as double) /
                  (subject['maxGrade'] as double);

              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '${subject['grade']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          '/${subject['maxGrade']}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: percentage,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getGradeColor(percentage),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subject['teacher']!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  Color _getGradeColor(double percentage) {
    if (percentage >= 0.8) {
      return Colors.green.shade300;
    } else if (percentage >= 0.6) {
      return Colors.amber.shade300;
    } else {
      return Colors.red.shade300;
    }
  }

  Widget _buildPendingTasksSection() {
    // Lista fictícia de tarefas pendentes
    final List<Map<String, dynamic>> tasks = [
      {
        'title': 'Trabalho de Matemática',
        'subject': 'Matemática',
        'due': 'Hoje, 23:59',
        'urgent': true,
      },
      {
        'title': 'Redação sobre Meio Ambiente',
        'subject': 'Português',
        'due': 'Amanhã, 23:59',
        'urgent': true,
      },
      {
        'title': 'Pesquisa História Antiga',
        'subject': 'História',
        'due': 'Em 3 dias',
        'urgent': false,
      },
      {
        'title': 'Questionário de Geografia',
        'subject': 'Geografia',
        'due': 'Em 5 dias',
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
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      task['urgent'] == true
                          ? Colors.red.withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                  child: Icon(
                    task['urgent'] == true
                        ? Icons.assignment_late
                        : Icons.assignment,
                    color:
                        task['urgent'] == true
                            ? Colors.red.shade300
                            : Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  task['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  task['subject']!,
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        task['urgent'] == true
                            ? Colors.red.withOpacity(0.2)
                            : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    task['due']!,
                    style: TextStyle(
                      color:
                          task['urgent'] == true
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
