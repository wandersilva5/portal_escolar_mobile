import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';
import '../components/dashboard_components.dart';

class AdminDashboard extends StatelessWidget {
  final User user;
  final Institution institution;

  const AdminDashboard({
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
              message: 'Você tem 3 relatórios pendentes e 5 novos usuários aguardando aprovação.',
              icon: Icons.admin_panel_settings,
              institution: institution,
            ),
            const SizedBox(height: 24),
            _buildStatisticsSection(),
            const SizedBox(height: 24),
            _buildQuickActionsSection(),
            const SizedBox(height: 24),
            _buildRecentActivitiesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    // Dados das estatísticas
    final stats = [
      {
        'title': 'Usuários',
        'value': '352',
        'icon': Icons.people,
        'color': institution.primaryColor,
        'change': '+12% este mês',
        'isPositive': true,
      },
      {
        'title': 'Alunos',
        'value': '287',
        'icon': Icons.school,
        'color': institution.primaryColor,
        'change': '+5% este mês',
        'isPositive': true,
      },
      {
        'title': 'Professores',
        'value': '42',
        'icon': Icons.person,
        'color': institution.primaryColor,
        'change': '+2% este mês',
        'isPositive': true,
      },
      {
        'title': 'Cursos',
        'value': '18',
        'icon': Icons.book,
        'color': institution.primaryColor,
        'change': 'Sem alteração',
        'isPositive': null,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Visão Geral'),
        const SizedBox(height: 16),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: stats.map((stat) => StatCard(
            title: stat['title'] as String,
            value: stat['value'] as String,
            icon: stat['icon'] as IconData,
            color: stat['color'] as Color,
            change: stat['change'] as String,
            isPositive: stat['isPositive'] as bool? ?? true,
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    // Dados das ações rápidas
    final actions = [
      {
        'title': 'Adicionar Usuário',
        'icon': Icons.person_add,
        'color': institution.primaryColor,
      },
      {
        'title': 'Novo Curso',
        'icon': Icons.add_box,
        'color': institution.primaryColor,
      },
      {
        'title': 'Relatórios',
        'icon': Icons.bar_chart,
        'color': institution.primaryColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Ações Rápidas'),
        const SizedBox(height: 16),
        Row(
          children: actions.asMap().entries.map((entry) {
            final index = entry.key;
            final action = entry.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 6, 
                  right: index == actions.length - 1 ? 0 : 6
                ),
                child: QuickActionButton(
                  title: action['title'] as String,
                  icon: action['icon'] as IconData,
                  color: action['color'] as Color,
                  onTap: () {},
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentActivitiesSection() {
    // Dados das atividades recentes
    final activities = [
      {
        'user': 'Maria Silva',
        'action': 'se cadastrou no sistema',
        'time': '2 minutos atrás',
        'type': 'new_user',
      },
      {
        'user': 'Prof. João Santos',
        'action': 'criou um novo curso',
        'time': '1 hora atrás',
        'type': 'new_course',
      },
      {
        'user': 'Carlos Oliveira',
        'action': 'atualizou seu perfil',
        'time': '3 horas atrás',
        'type': 'profile_update',
      },
      {
        'user': 'Admin',
        'action': 'gerou relatório de desempenho',
        'time': '5 horas atrás',
        'type': 'report',
      },
    ];

    return ListContainer(
      title: 'Atividades Recentes',
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: activities.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.white.withOpacity(0.1),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final activity = activities[index];
          IconData activityIcon;
          
          switch(activity['type']) {
            case 'new_user':
              activityIcon = Icons.person_add;
              break;
            case 'new_course':
              activityIcon = Icons.book;
              break;
            case 'profile_update':
              activityIcon = Icons.edit;
              break;
            case 'report':
              activityIcon = Icons.assessment;
              break;
            default:
              activityIcon = Icons.notifications;
          }
          
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: index % 2 == 0 
                ? institution.primaryColor.withOpacity(0.3) 
                : institution.secondaryColor.withOpacity(0.3),
              child: Icon(
                activityIcon,
                color: index % 2 == 0 
                  ? institution.primaryColor 
                  : institution.secondaryColor,
                size: 20,
              ),
            ),
            title: Text(
              activity['user'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              activity['action'] as String,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            trailing: Text(
              activity['time'] as String,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}