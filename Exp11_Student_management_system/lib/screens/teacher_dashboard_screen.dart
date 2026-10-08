import 'package:flutter/material.dart';
import '../models/app_user_model.dart';
import '../models/student_record_model.dart';
import '../services/auth_service.dart';
import '../services/student_db_service.dart';
import 'student_form_dialog.dart';

class TeacherDashboardScreen extends StatefulWidget {
  final AppUser user;

  const TeacherDashboardScreen({super.key, required this.user});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final StudentDbService _dbService = StudentDbService();
  final AuthService _auth = AuthService();
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openStudentDialog({StudentRecord? record}) {
    showDialog(
      context: context,
      builder: (ctx) => StudentFormDialog(
        existingRecord: record,
        onSave: (savedRecord) {
          if (record == null) {
            _dbService.addStudent(savedRecord);
          } else {
            _dbService.updateStudent(record.id, savedRecord);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Faculty Portal'),
            Text(
              '${widget.user.name} (${widget.user.email})',
              style: const TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () => _auth.signOut(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar Querying Firestore
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search student by name...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (val) => setState(() => _searchQuery = val),
              ),
            ),

            // Live Firestore Student Records Stream
            Expanded(
              child: StreamBuilder<List<StudentRecord>>(
                stream: _dbService.getStudentsStream(_searchQuery),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final students = snapshot.data ?? [];

                  if (students.isEmpty) {
                    return const Center(
                      child: Text(
                        'No student records found.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final s = students[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 5.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: Text(s.name.isNotEmpty ? s.name[0] : 'S'),
                          ),
                          title: Text(s.name,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Enr: ${s.enrollment} • Dept: ${s.department}\nCGPA: ${s.cgpa}'),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 20, color: Colors.blue),
                                onPressed: () =>
                                    _openStudentDialog(record: s),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    size: 20, color: Colors.redAccent),
                                onPressed: () =>
                                    _dbService.deleteStudent(s.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openStudentDialog(),
        icon: const Icon(Icons.add),
        label: const Text('Add Student'),
      ),
    );
  }
}