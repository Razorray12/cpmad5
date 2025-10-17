import 'package:flutter/material.dart';
import '../models/disease_info.dart';

class SymptomResultItem extends StatelessWidget {
  final DiseaseInfo disease;

  const SymptomResultItem({
    super.key,
    required this.disease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(disease.name),
        subtitle: Text(disease.description, maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
