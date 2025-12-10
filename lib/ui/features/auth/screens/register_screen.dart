import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/navigation/app_routes.dart';
import '../../../shared/di/locator.dart';
import '../state/auth_state.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  
  String? _selectedSpecialization;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<String> _specializations = [
    'Терапевт',
    'Кардиолог',
    'Невролог',
    'Хирург',
    'Педиатр',
    'Эндокринолог',
    'Гастроэнтеролог',
    'Пульмонолог',
    'Онколог',
    'Другое',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пароли не совпадают'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    final auth = getIt<AuthState>();
    final success = await auth.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      middleName: _middleNameController.text.trim().isNotEmpty 
        ? _middleNameController.text.trim() 
        : null,
      specialization: _selectedSpecialization,
    );
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Регистрация успешна!'),
          backgroundColor: Colors.green,
        ),
      );
      context.go(AppRoutes.v1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = getIt<AuthState>();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.shade50,
              Colors.white,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Кнопка назад
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => context.go(AppRoutes.login),
                      icon: const Icon(Icons.arrow_back),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Заголовок
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade600,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  const Text(
                    'Регистрация',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Создайте аккаунт врача',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Форма регистрации
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Персональные данные
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.teal.shade600),
                            const SizedBox(width: 8),
                            const Text(
                              'Персональные данные',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        AuthTextField(
                          controller: _lastNameController,
                          label: 'Фамилия *',
                          prefixIcon: Icons.badge_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите фамилию';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 12),
                        
                        AuthTextField(
                          controller: _firstNameController,
                          label: 'Имя *',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите имя';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 12),
                        
                        AuthTextField(
                          controller: _middleNameController,
                          label: 'Отчество',
                          prefixIcon: Icons.person_outline,
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Специализация
                        DropdownButtonFormField<String>(
                          value: _selectedSpecialization,
                          decoration: InputDecoration(
                            labelText: 'Специализация',
                            prefixIcon: const Icon(Icons.medical_services_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: _specializations.map((spec) {
                            return DropdownMenuItem(value: spec, child: Text(spec));
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _selectedSpecialization = value);
                          },
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Данные для входа
                        Row(
                          children: [
                            Icon(Icons.lock, color: Colors.teal.shade600),
                            const SizedBox(width: 8),
                            const Text(
                              'Данные для входа',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        AuthTextField(
                          controller: _emailController,
                          label: 'Email *',
                          hint: 'doctor@meditrack.ru',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите email';
                            }
                            if (!value.contains('@')) {
                              return 'Введите корректный email';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 12),
                        
                        StatefulBuilder(
                          builder: (context, setState) => TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Пароль *',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword 
                                    ? Icons.visibility_off_outlined 
                                    : Icons.visibility_outlined,
                                ),
                                onPressed: () => setState(() {
                                  _obscurePassword = !_obscurePassword;
                                }),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Введите пароль';
                              }
                              if (value.length < 6) {
                                return 'Минимум 6 символов';
                              }
                              return null;
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        StatefulBuilder(
                          builder: (context, setState) => TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            decoration: InputDecoration(
                              labelText: 'Подтвердите пароль *',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword 
                                    ? Icons.visibility_off_outlined 
                                    : Icons.visibility_outlined,
                                ),
                                onPressed: () => setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                }),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Подтвердите пароль';
                              }
                              if (value != _passwordController.text) {
                                return 'Пароли не совпадают';
                              }
                              return null;
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Сообщение об ошибке
                        Observer(
                          builder: (_) {
                            if (auth.errorMessage != null) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  auth.errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Кнопка регистрации
                        Observer(
                          builder: (_) => AuthButton(
                            text: 'Зарегистрироваться',
                            onPressed: _handleRegister,
                            isLoading: auth.isLoading,
                            backgroundColor: Colors.teal.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Ссылка на вход
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Уже есть аккаунт? ',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRoutes.login),
                        child: Text(
                          'Войти',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.teal.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

