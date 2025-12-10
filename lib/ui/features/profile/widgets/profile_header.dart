import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String specialization;
  final String? avatarUrl;

  const ProfileHeader({
    super.key,
    this.name = 'Др. Анна Смирнова',
    this.specialization = 'Главный врач терапевтического отделения',
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final defaultAvatar = 'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg?semt=ais_hybrid&w=740&q=80';
    
    return Container(
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
            backgroundImage: CachedNetworkImageProvider(avatarUrl ?? defaultAvatar),
          ),
          const SizedBox(height: 16),
          Text(
            'Др. $name',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            specialization,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


