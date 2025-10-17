/// Константы приложения
class AppConstants {
  // Размеры
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  // Радиусы
  static const double defaultBorderRadius = 8.0;
  static const double cardBorderRadius = 12.0;
  
  // Анимации
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  
  // Статусы пациентов
  static const String patientStatusStable = 'Стабилен';
  static const String patientStatusUnderObservation = 'Под наблюдением';
  static const String patientStatusCritical = 'Критический';
  
  // Пол пациентов
  static const String patientSexMale = 'Мужчина';
  static const String patientSexFemale = 'Женщина';
  
  // Форматы дат
  static const String dateFormat = 'dd.MM.yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd.MM.yyyy HH:mm';
  
  // Ограничения
  static const int maxPatientsPerPage = 20;
  static const int maxVitalsPerPage = 50;
  
  // Сообщения
  static const String successMessage = 'Операция выполнена успешно';
  static const String errorMessage = 'Произошла ошибка';
  static const String loadingMessage = 'Загрузка...';
  
  // Валидация
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int maxDiagnosisLength = 200;
  static const int maxPhoneLength = 20;
}
