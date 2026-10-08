import 'package:flutter/material.dart';
import '../models/student_record_model.dart';

class StudentFormDialog extends StatefulWidget {
  final StudentRecord? existingRecord;
  final Function(StudentRecord) onSave;

  const StudentFormDialog({
    super.key,
    this.existingRecord,
    required this.onSave,
  });

  @override
  State<StudentFormDialog> createState() => _StudentFormDialogState();
}

class _StudentFormDialogState extends State<StudentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _enrollmentCtrl;
  late TextEditingController _deptCtrl;
  late TextEditingController _cgpaCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existingRecord?.name ?? '');
    _enrollmentCtrl =
        TextEditingController(text: widget.existingRecord?.enrollment ?? '');
    _deptCtrl =
        TextEditingController(text: widget.existingRecord?.department ?? '');
    _cgpaCtrl = TextEditingController(
      text: widget.existingRecord != null
          ? widget.existingRecord!.cgpa.toString()
          : '',
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _enrollmentCtrl.dispose();
    _deptCtrl.dispose();
    _cgpaCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final record = StudentRecord(
        id: widget.existingRecord?.id ?? '',
        name: _nameCtrl.text.trim(),
        enrollment: _enrollmentCtrl.text.trim(),
        department: _deptCtrl.text.trim(),
        cgpa: double.parse(_cgpaCtrl.text.trim()),
      );
      widget.onSave(record);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingRecord != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Student Record' : 'Add New Student'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Student Name *'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _enrollmentCtrl,
                decoration: const InputDecoration(labelText: 'Enrollment No. *'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter enrollment' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _deptCtrl,
                decoration: const InputDecoration(labelText: 'Department *'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter department' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cgpaCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'CGPA (0 - 10) *'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Enter CGPA';
                  final val = double.tryParse(v.trim());
                  if (val == null || val < 0.0 || val > 10.0) {
                    return 'Enter valid CGPA between 0 and 10';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(isEditing ? 'Update' : 'Save'),
        ),
      ],
    );
  }
}