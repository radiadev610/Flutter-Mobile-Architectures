import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_record_model.dart';

class StudentDbService {
  final CollectionReference _studentsRef =
      FirebaseFirestore.instance.collection('students');

  // CREATE
  Future<void> addStudent(StudentRecord student) async {
    await _studentsRef.add(student.toMap());
  }

  // READ / QUERY: Streams all students or filters by search key prefix
  Stream<List<StudentRecord>> getStudentsStream(String searchQuery) {
    Query query = _studentsRef;

    if (searchQuery.trim().isNotEmpty) {
      final key = searchQuery.trim().toLowerCase();
      query = query
          .where('searchKey', isGreaterThanOrEqualTo: key)
          .where('searchKey', isLessThanOrEqualTo: '$key\uf8ff');
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => StudentRecord.fromFirestore(doc)).toList());
  }

  // UPDATE
  Future<void> updateStudent(String id, StudentRecord student) async {
    await _studentsRef.doc(id).update(student.toMap());
  }

  // DELETE
  Future<void> deleteStudent(String id) async {
    await _studentsRef.doc(id).delete();
  }
}