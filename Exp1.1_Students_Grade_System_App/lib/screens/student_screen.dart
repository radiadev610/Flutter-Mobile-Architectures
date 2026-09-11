import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {

  bool _isLoading = false;
  bool _hasData = false;

  String studentName = '';
  String enrollmentNo = '';
  String course = '';
  String semester = '';

  Future<void> fetchStudentData() async {

    setState(() {
      _isLoading = true;
      _hasData = false;
    });

    await Future.delayed(const Duration (milliseconds: 2500));

    setState(() {
      studentName = "Dev Radia";
      enrollmentNo = '92400133044';
      course = 'B.Tech Information & Communication Technology';
      semester = 'Semester 5 (CPMAD)';
      _isLoading = false;
      _hasData = true;
    });
  }

  void resetState() {
    setState(() {
      _isLoading = false;
      _hasData = false;
      studentName = '';
      enrollmentNo = '';
      course = '';
      semester = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Portal Sync'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              if (_isLoading)...[
                const CircularProgressIndicator(
                  color: Colors.indigo,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Fetching student record from server...',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ]

              else if (_hasData) ...[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const[
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.indigo,
                              child: Icon(Icons.person, color: Colors.white, size: 30),
                            ),
                            SizedBox(width: 14),
                            Text(
                              'Student Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 28),
                        _buildDataRow(Icons.badge, 'Name', studentName),
                        const SizedBox(height: 10),
                        _buildDataRow(Icons.numbers, 'Enrollment', enrollmentNo),
                        const SizedBox(height: 10),
                        _buildDataRow(Icons.school, 'Course', course),
                        const SizedBox(height: 10),
                        _buildDataRow(Icons.calendar_today, 'Term', semester),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: resetState,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Clear / Reset'),
                ),
              ]

              else ...[
                const Icon(
                  Icons.cloud_download_outlined,
                  size: 70,
                  color: Colors.indigo,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No student record loaded',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Click the button below to fetch data asynchronously.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: fetchStudentData,
                  icon: const Icon(Icons.download), 
                  label: const Text('Fetch Details'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                ),
              ],
            ],              
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.indigo),
        const SizedBox(width: 10),
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}