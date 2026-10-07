import 'package:flutter/material.dart';
import '../widgets/info_dialog.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // State Variables
  String _selectedGender = 'Male';
  double _age = 18.0;
  bool _hostelRequired = false;
  bool _newsletterSubscribed = true;
  bool _obscurePassword = true;

  final Map<String, bool> _skills = {
    'Flutter': false,
    'Python': false,
    'Web Development': false,
    'Database Management': false,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final selectedSkills = _skills.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

      if (selectedSkills.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one skill or course'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      final registrationData = {
        'Full Name': _nameController.text.trim(),
        'Email Address': _emailController.text.trim(),
        'Phone Number': _phoneController.text.trim(),
        'Gender': _selectedGender,
        'Age': _age.toInt().toString(),
        'Selected Skills': selectedSkills.join(', '),
        'Hostel Facility': _hostelRequired ? 'Required' : 'Not Required',
        'Newsletter': _newsletterSubscribed ? 'Subscribed' : 'No',
      };

      showDialog(
        context: context,
        builder: (ctx) => InfoDialog(data: registrationData),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    setState(() {
      _selectedGender = 'Male';
      _age = 18.0;
      _hostelRequired = false;
      _newsletterSubscribed = true;
      _skills.updateAll((key, value) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title: Personal Information
                const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12.0),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name *',
                    hintText: 'Enter student name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14.0),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address *',
                    hintText: 'student@example.com',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14.0),

                // Phone Field
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number *',
                    hintText: '10-digit mobile number',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14.0),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    hintText: 'Minimum 6 characters',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                // Section: Gender Selection (Radio)
                const Text(
                  'Gender',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: _selectedGender,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {
                          setState(() => _selectedGender = val!);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: _selectedGender,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {
                          setState(() => _selectedGender = val!);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Other'),
                        value: 'Other',
                        groupValue: _selectedGender,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {
                          setState(() => _selectedGender = val!);
                        },
                      ),
                    ),
                  ],
                ),
                const Divider(),

                // Section: Age Selection (Slider)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Age',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${_age.toInt()} years',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: _age,
                  min: 16.0,
                  max: 35.0,
                  divisions: 19,
                  label: _age.toInt().toString(),
                  onChanged: (double val) {
                    setState(() => _age = val);
                  },
                ),
                const Divider(),

                // Section: Skill Selection (Checkbox)
                const Text(
                  'Courses / Skills of Interest',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                ..._skills.keys.map((skill) {
                  return CheckboxListTile(
                    title: Text(skill),
                    value: _skills[skill],
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (bool? val) {
                      setState(() {
                        _skills[skill] = val ?? false;
                      });
                    },
                  );
                }),
                const Divider(),

                // Section: Additional Preferences (Switch)
                const Text(
                  'Preferences',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                SwitchListTile(
                  title: const Text('Hostel Accommodation Required'),
                  subtitle: const Text('Check availability on campus'),
                  value: _hostelRequired,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (bool val) {
                    setState(() => _hostelRequired = val);
                  },
                ),
                SwitchListTile(
                  title: const Text('Subscribe to University Circulars'),
                  subtitle: const Text('Receive announcements and events'),
                  value: _newsletterSubscribed,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (bool val) {
                    setState(() => _newsletterSubscribed = val);
                  },
                ),
                const SizedBox(height: 24.0),

                // Form Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _resetForm,
                        child: const Text('Reset'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: FilledButton(
                        onPressed: _submitForm,
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}