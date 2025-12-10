import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../shared/di/locator.dart';
import '../../../../presentation/state/app_scope.dart';
import '../../auth/state/auth_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/profile_stat_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = getIt<AuthState>();
    
    return Observer(
      builder: (context) {
        final user = auth.currentUser;
        final app = AppScope.of(context);
        final totalPatients = app.patients.length;
        final totalConsultations = app.consultationsCount;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfileHeader(
                name: user?.fullName ?? 'Врач',
                specialization: user?.specialization ?? 'Терапевт',
                avatarUrl: user?.avatarUrl,
              ),
              
              const SizedBox(height: 24),
              
              const ProfileInfoCard(
                title: 'Образование',
                content: 'Московский медицинский университет им. Сеченова\nСпециальность: Терапия\nГод окончания: 2015',
                icon: Icons.school,
                color: Colors.green,
              ),
              
              ProfileInfoCard(
                title: 'Отделение',
                content: user?.department ?? 'Терапевтическое отделение',
                icon: Icons.local_hospital,
                color: Colors.blue,
              ),
              
              const ProfileInfoCard(
                title: 'Специализации',
                content: '• Внутренние болезни\n• Кардиология\n• Эндокринология\n• Диабетология',
                icon: Icons.medical_services,
                color: Colors.red,
              ),
              
              ProfileInfoCard(
                title: 'Контакты',
                content: 'Email: ${user?.email ?? "doctor@meditrack.ru"}\nТелефон: ${user?.phoneNumber ?? "+7 (495) 123-45-67"}\nКабинет: 205, 2 этаж',
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
                      children: [
                        ProfileStatItem(
                          label: 'Пациентов',
                          value: '$totalPatients',
                          color: Colors.blue,
                        ),
                        ProfileStatItem(
                          label: 'Консультаций',
                          value: '$totalConsultations',
                          color: Colors.green,
                        ),
                        const ProfileStatItem(
                          label: 'Лет опыта',
                          value: '8',
                          color: Colors.orange,
                        ),
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Редактирование профиля')),
                        );
                      },
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Настройки приложения')),
                        );
                      },
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
      },
    );
  }
}
