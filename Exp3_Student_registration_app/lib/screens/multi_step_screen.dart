import 'package:flutter/material.dart';

class MultiStepRegistrationScreen extends StatefulWidget {
  const MultiStepRegistrationScreen({super.key});

  @override
  State<MultiStepRegistrationScreen> createState() =>
      _MultiStepRegistrationScreenState();
}

class _MultiStepRegistrationScreenState
    extends State<MultiStepRegistrationScreen> {
  int _currentStep = 0;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _enrollmentController = TextEditingController();
  final _departmentController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _enrollmentController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  void _onStepContinue() {
    if (_currentStep < 2) {
      setState(() => _currentStep += 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successfully recorded!'),
          backgroundColor: Colors.teal,
        ),
      );
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi-Step Registration')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        steps: [
          Step(
            title: const Text('Personal'),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Academic'),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: Column(
              children: [
                TextField(
                  controller: _enrollmentController,
                  decoration: const InputDecoration(labelText: 'Enrollment No.'),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: _departmentController,
                  decoration: const InputDecoration(labelText: 'Department / Branch'),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Confirm'),
            isActive: _currentStep >= 2,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${_nameController.text}'),
                const SizedBox(height: 6.0),
                Text('Email: ${_emailController.text}'),
                const SizedBox(height: 6.0),
                Text('Enrollment: ${_enrollmentController.text}'),
                const SizedBox(height: 6.0),
                Text('Department: ${_departmentController.text}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}