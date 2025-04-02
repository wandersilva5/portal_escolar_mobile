import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';

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
            _buildWelcomeSection(),
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
            Icons.admin_panel_settings,
            size: 45,
            color: institution.primaryColor.withOpacity(0.9),
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
                  'Você tem 3 relatórios pendentes e 5 novos usuários aguardando aprovação.',
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

  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visão Geral',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildStatCard(
              title: 'Usuários',
              value: '352',
              icon: Icons.people,
              color: institution.primaryColor,
              change: '+12% este mês',
            ),
            _buildStatCard(
              title: 'Alunos',
              value: '287',
              icon: Icons.school,
              color: institution.secondaryColor,
              change: '+5% este mês',
            ),
            _buildStatCard(
              title: 'Professores',
              value: '42',
              icon: Icons.person,
              color: institution.primaryColor,
              change: '+2% este mês',
            ),
            _buildStatCard(
              title: 'Cursos',
              value: '18',
              icon: Icons.book,
              color: institution.secondaryColor,
              change: 'Sem alteração',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String change,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
              Icon(
                icon,
                color: color,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            change,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ações Rápidas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                title: 'Adicionar Usuário',
                icon: Icons.person_add,
                onTap: () {},
                color: institution.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                title: 'Novo Curso',
                icon: Icons.add_box,
                onTap: () {},
                color: institution.secondaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                title: 'Relatórios',
                icon: Icons.bar_chart,
                onTap: () {},
                color: institution.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitiesSection() {
    final List<Map<String, String>> activities = [
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Atividades Recentes',
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
                  '${activity['user']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${activity['action']}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                trailing: Text(
                  '${activity['time']}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}