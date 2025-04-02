import 'package:flutter/material.dart';
import '../models/institution_model.dart';

/// Componentes reutilizáveis para as dashboards

/// Seção de boas-vindas com ícone, saudação e mensagem
class WelcomeBanner extends StatelessWidget {
  final String userName;
  final String message;
  final IconData icon;
  final Institution institution;

  const WelcomeBanner({
    super.key,
    required this.userName,
    required this.message,
    required this.icon,
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
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
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 45,
            color: institution.primaryColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, $userName!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
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
}

/// Título de seção com opção "Ver Todos"
class SectionTitle extends StatelessWidget {
  final String title;
  final bool showViewAll;
  final VoidCallback? onViewAll;
  final Color? viewAllColor;

  const SectionTitle({
    super.key,
    required this.title,
    this.showViewAll = false,
    this.onViewAll,
    this.viewAllColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (showViewAll)
          TextButton(
            onPressed: onViewAll ?? () {},
            child: Text(
              'Ver Todos',
              style: TextStyle(
                color: viewAllColor ?? Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }
}

/// Card para estatísticas
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? change;
  final bool? isPositive;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.change,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
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
          if (change != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                if (isPositive != null) Icon(
                  isPositive! ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isPositive! ? Colors.green.shade300 : Colors.red.shade300,
                  size: 16,
                ),
                if (isPositive != null) const SizedBox(width: 4),
                Text(
                  change!,
                  style: TextStyle(
                    color: isPositive != null 
                      ? (isPositive! ? Colors.green.shade300 : Colors.red.shade300)
                      : Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Card de ação rápida (botão)
class QuickActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const QuickActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
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
}

/// Lista de itens com rolagem horizontal
class HorizontalItemList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final double height;
  final double? itemWidth;
  final double itemSpacing;

  const HorizontalItemList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height = 140,
    this.itemWidth,
    this.itemSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: itemWidth,
            margin: EdgeInsets.only(right: index < items.length - 1 ? itemSpacing : 0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: itemBuilder(context, items[index], index),
          );
        },
      ),
    );
  }
}

/// Container para listas, com título opcional
class ListContainer extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool showViewAll;
  final VoidCallback? onViewAll;
  final Color? viewAllColor;

  const ListContainer({
    super.key,
    this.title,
    required this.child,
    this.showViewAll = false,
    this.onViewAll,
    this.viewAllColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          SectionTitle(
            title: title!,
            showViewAll: showViewAll,
            onViewAll: onViewAll,
            viewAllColor: viewAllColor,
          ),
        if (title != null) const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ],
    );
  }
}

/// Item de tarefa pendente
class PendingTaskItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dueDate;
  final bool isUrgent;
  final VoidCallback? onTap;
  final Color secondaryColor;

  const PendingTaskItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dueDate,
    this.isUrgent = false,
    this.onTap,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isUrgent
            ? Colors.red.withOpacity(0.2)
            : secondaryColor.withOpacity(0.3),
        child: Icon(
          isUrgent ? Icons.priority_high : Icons.assignment,
          color: isUrgent ? Colors.red.shade300 : secondaryColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white.withOpacity(0.7)),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: isUrgent
              ? Colors.red.withOpacity(0.2)
              : secondaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          dueDate,
          style: TextStyle(
            color: isUrgent
                ? Colors.red.shade300
                : Colors.white.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

/// Barra de progresso com legenda
class LabeledProgressBar extends StatelessWidget {
  final double value;
  final String? label;
  final String? valueLabel;
  final Color activeColor;
  final Color backgroundColor;

  const LabeledProgressBar({
    super.key,
    required this.value,
    this.label,
    this.valueLabel,
    required this.activeColor,
    this.backgroundColor = Colors.white24,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
        ],
        LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(activeColor),
        ),
        if (valueLabel != null) ...[
          const SizedBox(height: 4),
          Text(
            valueLabel!,
            style: TextStyle(
              color: activeColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

/// Card de horário/agenda
class ScheduleCard extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback? onTap;

  const ScheduleCard({
    super.key,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.primaryColor,
    required this.secondaryColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time,
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
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null)
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: secondaryColor,
                size: 18,
              ),
              onPressed: onTap,
            ),
        ],
      ),
    );
  }
}