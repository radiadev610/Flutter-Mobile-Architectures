import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_translations.dart';
import '../widgets/info_row.dart';

class StudentInfoScreen extends StatelessWidget {
  final String currentLang;
  final Function(String) onLanguageChange;

  const StudentInfoScreen({
    super.key,
    required this.currentLang,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    final t = (String key) => AppTranslations.getText(currentLang, key);
    final fn = (String numStr) => AppTranslations.formatNumber(numStr, currentLang);

    // Formatted Date
    final DateTime admissionDate = DateTime(2023, 8, 16);
    final String formattedDate =
        DateFormat('dd MMMM yyyy', currentLang).format(admissionDate);

    // Formatted Currency
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹ ',
      decimalDigits: 0,
    );
    final String feesPaid =
        fn(currencyFormat.format(78500));

    return Scaffold(
      appBar: AppBar(
        title: Text(t('app_title')),
        actions: [
          // Post-Experiment Navigation Icons
          IconButton(
            tooltip: t('nav_calculator'),
            icon: const Icon(Icons.calculate_outlined),
            onPressed: () => Navigator.pushNamed(context, '/calculator'),
          ),
          IconButton(
            tooltip: t('nav_events'),
            icon: const Icon(Icons.event_outlined),
            onPressed: () => Navigator.pushNamed(context, '/events'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Language Selection Card
              Card(
                elevation: 2.0,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.language,
                              color: Theme.of(context).colorScheme.onPrimaryContainer),
                          const SizedBox(width: 10.0),
                          Text(
                            t('select_language'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        value: currentLang,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: const [
                          DropdownMenuItem(value: 'en', child: Text('English (EN)')),
                          DropdownMenuItem(value: 'gu', child: Text('ગુજરાતી (GU)')),
                          DropdownMenuItem(value: 'hi', child: Text('हिन्दी (HI)')),
                        ],
                        onChanged: (newLang) {
                          if (newLang != null) {
                            onLanguageChange(newLang);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppTranslations.getText(newLang, 'language_saved'),
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Student Card Header
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 44.0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Icon(Icons.person, size: 48.0, color: Colors.white),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        t('student_name'),
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${t('enrollment_label')}: ${fn(t('enrollment_value'))}',
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 13.0),
                      ),
                      const Divider(height: 24.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  fn(t('semester_value')),
                                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Text(t('semester_label'), style: const TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                          Container(height: 28, width: 1, color: Colors.grey.shade300),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  fn(t('cgpa_value')),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(t('cgpa_label'), style: const TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Detailed Profile Fields Card
              Card(
                elevation: 1.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t('personal_details'),
                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 18.0),
                      InfoRow(
                        icon: Icons.school_outlined,
                        label: t('department_label'),
                        value: t('department_value'),
                      ),
                      InfoRow(
                        icon: Icons.calendar_today_outlined,
                        label: t('admission_date_label'),
                        value: fn(formattedDate),
                      ),
                      InfoRow(
                        icon: Icons.fact_check_outlined,
                        label: t('attendance_label'),
                        value: '${fn('91.5')} %',
                      ),
                      InfoRow(
                        icon: Icons.payments_outlined,
                        label: t('fees_paid_label'),
                        value: feesPaid,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}