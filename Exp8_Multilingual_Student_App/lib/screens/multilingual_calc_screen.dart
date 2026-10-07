import 'package:flutter/material.dart';
import '../l10n/app_translations.dart';

class MultilingualCalcScreen extends StatefulWidget {
  final String currentLang;

  const MultilingualCalcScreen({super.key, required this.currentLang});

  @override
  State<MultilingualCalcScreen> createState() => _MultilingualCalcScreenState();
}

class _MultilingualCalcScreenState extends State<MultilingualCalcScreen> {
  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();
  String _result = '0';

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  void _calculate(String op) {
    final double? n1 = double.tryParse(_num1Controller.text.trim());
    final double? n2 = double.tryParse(_num2Controller.text.trim());

    if (n1 == null || n2 == null) {
      setState(() => _result = 'Error');
      return;
    }

    double res = 0.0;
    if (op == '+') res = n1 + n2;
    if (op == '-') res = n1 - n2;
    if (op == '*') res = n1 * n2;
    if (op == '/') res = n2 != 0 ? n1 / n2 : 0.0;

    setState(() {
      _result = res.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = (String key) => AppTranslations.getText(widget.currentLang, key);
    final fn = (String val) => AppTranslations.formatNumber(val, widget.currentLang);

    return Scaffold(
      appBar: AppBar(title: Text(t('calc_title'))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _num1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: t('calc_input1'),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _num2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: t('calc_input2'),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(onPressed: () => _calculate('+'), child: Text(t('calc_add'))),
                  FilledButton(onPressed: () => _calculate('-'), child: Text(t('calc_sub'))),
                  FilledButton(onPressed: () => _calculate('*'), child: Text(t('calc_mul'))),
                  FilledButton(onPressed: () => _calculate('/'), child: Text(t('calc_div'))),
                ],
              ),
              const SizedBox(height: 24.0),
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(t('calc_result'), style: const TextStyle(fontSize: 14.0)),
                      const SizedBox(height: 6.0),
                      Text(
                        fn(_result),
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
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