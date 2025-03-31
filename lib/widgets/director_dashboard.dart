import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';

class DirectorDashboard extends StatelessWidget {
  final User user;
  final Institution institution;

  const DirectorDashboard({
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
            _buildPerformanceSection(),
            const SizedBox(height: 24),
            _buildDepartmentsSection(),
            const SizedBox(height: 24),
            _buildPendingApprovalsSection(),
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
          Icon(
            Icons.account_balance,
            size: 45,
            color: Colors.white.withOpacity(0.9),
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
                  'Você tem 5 reuniões agendadas hoje e 3 relatórios pendentes para revisão.',
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

  Widget _buildPerformanceSection() {
    // Dados fictícios para métricas de performance
    final List<Map<String, String>> performanceData = [
      {
        'title': 'Taxa de Aprovação',
        'value': '92%',
        'trend': 'up',
        'change': '+2.5%',
      },
      {
        'title': 'Média Geral',
        'value': '7.8',
        'trend': 'up',
        'change': '+0.3',
      },
      {
        'title': 'Frequência',
        'value': '95%',
        'trend': 'down',
        'change': '-1.2%',
      },
      {
        'title': 'Satisfação',
        'value': '4.7/5',
        'trend': 'up',
        'change': '+0.2',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Métricas de Desempenho',
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
          children: performanceData.map((data) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['title']!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    data['value']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        data['trend'] == 'up' ? Icons.arrow_upward : Icons.arrow_downward,
                        color: data['trend'] == 'up' ? Colors.green.shade300 : Colors.red.shade300,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data['change']!,
                        style: TextStyle(
                          color: data['trend'] == 'up' ? Colors.green.shade300 : Colors.red.shade300,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDepartmentsSection() {
    // Dados fictícios para os departamentos
    final List<Map<String, dynamic>> departments = [
      {
        'name': 'Ciências Exatas',
        'teachers': 12,
        'students': 320,
        'performance': 0.85,
      },
      {
        'name': 'Humanidades',
        'teachers': 10,
        'students': 280,
        'performance': 0.90,
      },
      {
        'name': 'Linguagens',
        'teachers': 8,
        'students': 350,
        'performance': 0.80,
      },
      {
        'name': 'Ciências Naturais',
        'teachers': 9,
        'students': 300,
        'performance': 0.82,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Departamentos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Ver Todos',
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
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: departments.length,
            itemBuilder: (context, index) {
              final dept = departments[index];
              return Container(
                width: 220,
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
                      dept['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDeptStat(
                          icon: Icons.person,
                          value: '${dept['teachers']}',
                          label: 'Professores',
                        ),
                        _buildDeptStat(
                          icon: Icons.groups,
                          value: '${dept['students']}',
                          label: 'Alunos',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Desempenho',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: dept['performance'] as double,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getPerformanceColor(dept['performance'] as double),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${((dept['performance'] as double) * 100).toInt()}%',
                      style: TextStyle(
                        color: _getPerformanceColor(dept['performance'] as double),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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

  Widget _buildDeptStat({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.8),
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _getPerformanceColor(double percentage) {
    if (percentage >= 0.8) {
      return Colors.green.shade300;
    } else if (percentage >= 0.6) {
      return Colors.amber.shade300;
    } else {
      return Colors.red.shade300;
    }
  }

  Widget _buildPendingApprovalsSection() {
    // Lista fictícia de aprovações pendentes
    final List<Map<String, dynamic>> approvals = [
      {
        'title': 'Solicitação de Orçamento',
        'department': 'Ciências Exatas',
        'requester': 'Prof. Roberto Martins',
        'amount': 'R\$ 5.200,00',
        'urgent': true,
      },
      {
        'title': 'Projeto Extracurricular',
        'department': 'Humanidades',
        'requester': 'Profa. Carla Almeida',
        'amount': 'N/A',
        'urgent': false,
      },
      {
        'title': 'Relatório de Desempenho',
        'department': 'Coordenação',
        'requester': 'Coord. Marcos Pereira',
        'amount': 'N/A',
        'urgent': true,
      },
      {
        'title': 'Pedido de Material Didático',
        'department': 'Linguagens',
        'requester': 'Profa. Lúcia Mendes',
        'amount': 'R\$ 2.800,00',
        'urgent': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aprovações Pendentes',
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
            itemCount: approvals.length,
            itemBuilder: (context, index) {
              final approval = approvals[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: approval['urgent'] == true
                      ? Colors.red.withOpacity(0.2)
                      : Colors.white.withOpacity(0.2),
                  child: Icon(
                    approval['urgent'] == true ? Icons.priority_high : Icons.approval,
                    color: approval['urgent'] == true ? Colors.red.shade300 : Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  approval['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${approval['department']} • ${approval['requester']}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                trailing: approval['amount'] != 'N/A'
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          approval['amount']!,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : null,
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}