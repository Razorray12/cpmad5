import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.bars, AppColors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.bars,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Др. Анна Смирнова',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Главный врач терапевтического отделения',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          _buildInfoCard(
            'Образование',
            'Московский медицинский университет им. Сеченова\nСпециальность: Терапия\nГод окончания: 2015',
            Icons.school,
            Colors.green,
          ),
          
          _buildInfoCard(
            'Опыт работы',
            '8 лет практики\nСтарший врач терапевтического отделения\nВедущий специалист по внутренним болезням',
            Icons.work,
            Colors.orange,
          ),
          
          _buildInfoCard(
            'Специализации',
            '• Внутренние болезни\n• Кардиология\n• Эндокринология\n• Диабетология',
            Icons.medical_services,
            Colors.red,
          ),
          
          _buildInfoCard(
            'Контакты',
            'Email: a.smirnova@meditrack.ru\nТелефон: +7 (495) 123-45-67\nКабинет: 205, 2 этаж',
            Icons.contact_phone,
            Colors.purple,
          ),
          
          const SizedBox(height: 24),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Статистика работы',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Пациентов', '1,247', Colors.blue),
                    _buildStatItem('Консультаций', '3,892', Colors.green),
                    _buildStatItem('Лет опыта', '8', Colors.orange),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Редактировать'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                  label: const Text('Настройки'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
