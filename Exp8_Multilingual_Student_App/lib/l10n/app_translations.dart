class AppTranslations {
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Student Information System',
      'personal_details': 'Personal Details',
      'name_label': 'Full Name',
      'student_name': 'Dev Radia',
      'enrollment_label': 'Enrollment Number',
      'enrollment_value': '92200103001',
      'department_label': 'Department',
      'department_value': 'Computer Science & Engineering',
      'semester_label': 'Current Semester',
      'semester_value': '6',
      'admission_date_label': 'Admission Date',
      'attendance_label': 'Attendance',
      'fees_paid_label': 'Fees Paid',
      'cgpa_label': 'Current CGPA',
      'cgpa_value': '8.92',
      'select_language': 'Select Language',
      'language_saved': 'Language preference saved!',
      'nav_calculator': 'Calculator',
      'nav_events': 'Events',
      // Calculator labels
      'calc_title': 'Localized Calculator',
      'calc_input1': 'First Number',
      'calc_input2': 'Second Number',
      'calc_result': 'Calculated Result',
      'calc_add': 'Add',
      'calc_sub': 'Subtract',
      'calc_mul': 'Multiply',
      'calc_div': 'Divide',
      // Event Planner labels
      'event_title': 'Academic Calendar',
      'event_exam': 'Mid-Semester Examinations',
      'event_hackathon': 'National Hackathon Finale',
      'event_holidays': 'Diwali Vacation',
    },
    'gu': {
      'app_title': 'વિદ્યાર્થી માહિતી પ્રણાલી',
      'personal_details': 'વ્યક્તિગત વિગતો',
      'name_label': 'પૂરું નામ',
      'student_name': 'દેવ રાડિયા',
      'enrollment_label': 'નોંધણી નંબર (Enrollment)',
      'enrollment_value': '92200103001',
      'department_label': 'વિભાગ',
      'department_value': 'કમ્પ્યુટર સાયન્સ અને એન્જિનિયરિંગ',
      'semester_label': 'વર્તમાન સત્ર',
      'semester_value': '6',
      'admission_date_label': 'પ્રવેશ તારીખ',
      'attendance_label': 'હાજરી',
      'fees_paid_label': 'ભરેલી ફી',
      'cgpa_label': 'વર્તમાન સીજીપીએ (CGPA)',
      'cgpa_value': '8.92',
      'select_language': 'ભાષા પસંદ કરો',
      'language_saved': 'ભાષા પસંદગી સાચવવામાં આવી!',
      'nav_calculator': 'કેલ્ક્યુલેટર',
      'nav_events': 'ઇવેન્ટ્સ',
      // Calculator labels
      'calc_title': 'સ્થાનિક કેલ્ક્યુલેટર',
      'calc_input1': 'પ્રથમ સંખ્યા',
      'calc_input2': 'બીજી સંખ્યા',
      'calc_result': 'ગણતરી કરેલ પરિણામ',
      'calc_add': 'સરવાળો',
      'calc_sub': 'બાદબાકી',
      'calc_mul': 'ગુણાકાર',
      'calc_div': 'ભાગાકાર',
      // Event Planner labels
      'event_title': 'શૈક્ષણિક કેલેન્ડર',
      'event_exam': 'મિડ-સેમેસ્ટર પરીક્ષાઓ',
      'event_hackathon': 'રાષ્ટ્રીય હેકાથોન ફિનાલે',
      'event_holidays': 'દિવાળી વેકેશન',
    },
    'hi': {
      'app_title': 'छात्र सूचना प्रणाली',
      'personal_details': 'व्यक्तिगत विवरण',
      'name_label': 'पूरा नाम',
      'student_name': 'देव राडिया',
      'enrollment_label': 'नामांकन संख्या',
      'enrollment_value': '92200103001',
      'department_label': 'विभाग',
      'department_value': 'कंप्यूटर साइंस और इंजीनियरिंग',
      'semester_label': 'वर्तमान सत्र',
      'semester_value': '6',
      'admission_date_label': 'प्रवेश तिथि',
      'attendance_label': 'उपस्थिति',
      'fees_paid_label': 'भुगतान किया गया शुल्क',
      'cgpa_label': 'वर्तमान सीजीपीए',
      'cgpa_value': '8.92',
      'select_language': 'भाषा चुनें',
      'language_saved': 'भाषा प्राथमिकता सहेजी गई!',
      'nav_calculator': 'कैलकुलेटर',
      'nav_events': 'घटनाएं',
      // Calculator labels
      'calc_title': 'स्थानीयकृत कैलकुलेटर',
      'calc_input1': 'पहली संख्या',
      'calc_input2': 'दूसरी संख्या',
      'calc_result': 'परिकलित परिणाम',
      'calc_add': 'जोड़ें',
      'calc_sub': 'घटाएं',
      'calc_mul': 'गुणा करें',
      'calc_div': 'भाग दें',
      // Event Planner labels
      'event_title': 'शैक्षणिक कैलेंडर',
      'event_exam': 'मिड-सेमेस्टर परीक्षाएं',
      'event_hackathon': 'राष्ट्रीय हैकाथॉन ग्रैंड फिनाले',
      'event_holidays': 'दिवाली की छुट्टियां',
    },
  };

  static String getText(String langCode, String key) {
    return _localizedValues[langCode]?[key] ?? _localizedValues['en']![key] ?? key;
  }

  // Gujarati digit converter
  static String formatNumber(String input, String langCode) {
    if (langCode == 'gu') {
      const enDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      const guDigits = ['૦', '૧', '૨', '૩', '૪', '૫', '૬', '૭', '૮', '૯'];
      String output = input;
      for (int i = 0; i < 10; i++) {
        output = output.replaceAll(enDigits[i], guDigits[i]);
      }
      return output;
    } else if (langCode == 'hi') {
      const enDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      const hiDigits = ['०', '१', '२', '३', '४', '५', '६', '७', '८', '९'];
      String output = input;
      for (int i = 0; i < 10; i++) {
        output = output.replaceAll(enDigits[i], hiDigits[i]);
      }
      return output;
    }
    return input;
  }
}