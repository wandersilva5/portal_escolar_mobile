import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';
import '../components/dashboard_components.dart';

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
            WelcomeBanner(
              userName: user.name,
              message: 'Você tem 4 aulas hoje e 3 tarefas para entregar esta semana.',
              icon: Icons.backpack,
              institution: institution,
            ),
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

  Widget _buildTodaySchedule() {
    // Lista de aulas fictícias para o dia
    final classes = [
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

    return ListContainer(
      title: 'Horário de Hoje',
      child: Column(
        children: classes.map((classInfo) {
          return ScheduleCard(
            time: classInfo['time']!,
            title: classInfo['subject']!,
            subtitle: '${classInfo['teacher']} • ${classInfo['room']}',
            primaryColor: institution.primaryColor,
            secondaryColor: institution.secondaryColor,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGradesSection() {
    // Dados fictícios de notas
    final subjects = [
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
        SectionTitle(
          title: 'Minhas Notas',
          showViewAll: true,
          viewAllColor: institution.secondaryColor,
        ),
        const SizedBox(height: 16),
        HorizontalItemList<Map<String, dynamic>>(
          items: subjects,
          itemWidth: 160,
          itemBuilder: (context, subject, index) {
            final percentage = (subject['grade'] as double) / (subject['maxGrade'] as double);
            
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: institution.secondaryColor.withOpacity(0.2),
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
                  LabeledProgressBar(
                    value: percentage,
                    activeColor: _getGradeColor(percentage),
                    backgroundColor: Colors.white.withOpacity(0.2),
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
    final tasks = [
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

    return ListContainer(
      title: 'Tarefas Pendentes',
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return PendingTaskItem(
            title: task['title'] as String,
            subtitle: task['subject'] as String,
            dueDate: task['due'] as String,
            isUrgent: task['urgent'] as bool,
            secondaryColor: institution.secondaryColor,
            onTap: () {},
          );
        },
      ),
    );
  }
}