import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/institution_model.dart';
import '../components/dashboard_components.dart';

class GuardianDashboard extends StatelessWidget {
  final User user;
  final Institution institution;

  const GuardianDashboard({
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
              message: 'Bem-vindo ao Portal do Responsável. Acompanhe aqui a vida escolar do seu dependente.',
              icon: Icons.family_restroom,
              institution: institution,
            ),
            const SizedBox(height: 24),
            _buildTuitionSection(context),
            const SizedBox(height: 24),
            _buildPaymentHistorySection(),
            const SizedBox(height: 24),
            _buildStudentInfoSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTuitionSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sua mensalidade está disponível',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
              ),
            ),
            const SizedBox(height: 12),
            // Campo de senha ou código de barras
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: institution.primaryColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '••••••••••',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: institution.primaryColor,
                      letterSpacing: 2,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {
                      // Toggle visibility action
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Data de vencimento
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vencimento',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '20/06/2023',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Botão de formas de pagamento
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Ação para exibir formas de pagamento
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: institution.secondaryColor.withOpacity(0.7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Formas de pagamento',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentHistorySection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cabeçalho da tabela
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildTableHeader('Mês', flex: 1),
                _buildTableHeader('Boleto', flex: 1),
                _buildTableHeader('Vencimento', flex: 2),
                _buildTableHeader('Valor', flex: 1),
                _buildTableHeader('Status', flex: 1),
                _buildTableHeader('Ação', flex: 1),
              ],
            ),
          ),
          // Divider
          Divider(color: Colors.grey[300], height: 1),
          // Linha de exemplo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildTableCell('DEZ', flex: 1),
                _buildTableCell('45782', flex: 1),
                _buildTableCell('20/12/2023', flex: 2),
                _buildTableCell('8.700,24', flex: 1),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Pendente',
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios, 
                      size: 16, 
                      color: institution.primaryColor.withOpacity(0.6)
                    ),
                    onPressed: () {
                      // Ação para visualizar detalhes
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildTableCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[800],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildStudentInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: institution.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Informações do Aluno'),
          const SizedBox(height: 20),
          _buildInfoRow(
            icon: Icons.person,
            title: 'Nome',
            value: 'Fernando Ernesto',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.card_membership,
            title: 'Matrícula',
            value: '04',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.class_,
            title: 'Turma',
            value: '04',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.calendar_today,
            title: 'Período Letivo',
            value: '2024',
          ),
          const SizedBox(height: 20),
          // Botão para visualizar boletim
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Ação para visualizar boletim
              },
              icon: const Icon(Icons.assignment),
              label: const Text('Ver Boletim Escolar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: institution.secondaryColor.withOpacity(0.7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: institution.secondaryColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}