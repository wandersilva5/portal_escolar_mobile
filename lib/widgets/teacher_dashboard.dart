import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';
import '../components/dashboard_components.dart';

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
            WelcomeBanner(
              userName: user.name,
              message: 'Você tem 3 turmas hoje e 15 tarefas para corrigir.',
              icon: Icons.school,
              institution: institution,
            ),
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

  Widget _buildTodaySchedule() {
    // Lista de aulas fictícias para o dia
    final classes = [
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

    return ListContainer(
      title: 'Agenda de Hoje',
      child: Column(
        children: classes.map((classInfo) {
          return ScheduleCard(
            time: classInfo['time']!,
            title: classInfo['subject']!,
            subtitle: '${classInfo['class']} • ${classInfo['room']}',
            primaryColor: institution.primaryColor,
            secondaryColor: institution.secondaryColor,
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }

  Widget _buildClassesSection() {
    // Lista fictícia de turmas
    final classes = [
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
        SectionTitle(
          title: 'Minhas Turmas',
          showViewAll: true,
          viewAllColor: institution.secondaryColor,
        ),
        const SizedBox(height: 16),
        HorizontalItemList<Map<String, dynamic>>(
          items: classes,
          itemWidth: 200,
          itemBuilder: (context, classInfo, index) {
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
                  LabeledProgressBar(
                    value: classInfo['progress'] as double,
                    activeColor: institution.primaryColor,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueLabel: 'Progresso do conteúdo: ${((classInfo['progress'] as double) * 100).toInt()}%',
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPendingAssignmentsSection() {
    // Lista fictícia de tarefas pendentes
    final assignments = [
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

    return ListContainer(
      title: 'Tarefas Pendentes',
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return PendingTaskItem(
            title: assignment['title'] as String,
            subtitle: assignment['class'] as String,
            dueDate: assignment['due'] as String,
            isUrgent: assignment['urgent'] as bool,
            secondaryColor: institution.secondaryColor,
            onTap: () {},
          );
        },
      ),
    );
  }
}