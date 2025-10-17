import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/profile_stat_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const ProfileHeader(),
          
          const SizedBox(height: 24),
          
          const ProfileInfoCard(
            title: 'Образование',
            content: 'Московский медицинский университет им. Сеченова\nСпециальность: Терапия\nГод окончания: 2015',
            icon: Icons.school,
            color: Colors.green,
          ),
          
          const ProfileInfoCard(
            title: 'Опыт работы',
            content: '8 лет практики\nСтарший врач терапевтического отделения\nВедущий специалист по внутренним болезням',
            icon: Icons.work,
            color: Colors.orange,
          ),
          
          const ProfileInfoCard(
            title: 'Специализации',
            content: '• Внутренние болезни\n• Кардиология\n• Эндокринология\n• Диабетология',
            icon: Icons.medical_services,
            color: Colors.red,
          ),
          
          const ProfileInfoCard(
            title: 'Контакты',
            content: 'Email: a.smirnova@meditrack.ru\nТелефон: +7 (495) 123-45-67\nКабинет: 205, 2 этаж',
            icon: Icons.contact_phone,
            color: Colors.purple,
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
                  children: const [
                    ProfileStatItem(label: 'Пациентов', value: '1,247', color: Colors.blue),
                    ProfileStatItem(label: 'Консультаций', value: '3,892', color: Colors.green),
                    ProfileStatItem(label: 'Лет опыта', value: '8', color: Colors.orange),
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

}
