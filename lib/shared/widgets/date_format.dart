String twoDigits(int n) => n.toString().padLeft(2, '0');

String formatDateTimeDDMMYYYYHHMM(DateTime dt) {
  final d = twoDigits(dt.day);
  final m = twoDigits(dt.month);
  final h = twoDigits(dt.hour);
  final min = twoDigits(dt.minute);
  return '$d.$m.${dt.year} $h:$min';
}


