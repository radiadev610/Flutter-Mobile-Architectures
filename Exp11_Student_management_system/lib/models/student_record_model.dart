import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRecord {
  final String id;
  final String name;
  final String enrollment;
  final String department;
  final double cgpa;

  StudentRecord({
    required this.id,
    required this.name,
    required this.enrollment,
    required this.department,
    required this.cgpa,
  });

  factory StudentRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return StudentRecord(
      id: doc.id,
      name: data['name'] ?? '',
      enrollment: data['enrollment'] ?? '',
      department: data['department'] ?? '',
      cgpa: (data['cgpa'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'enrollment': enrollment,
      'department': department,
      'cgpa': cgpa,
      'searchKey': name.toLowerCase(),
    };
  }
}