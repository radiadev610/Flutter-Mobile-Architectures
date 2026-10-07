import 'package:flutter/material.dart';
import '../models/expense_model.dart';

class IncomeDialog extends StatefulWidget {
  final Function(Expense) onSave;

  const IncomeDialog({super.key, required this.onSave});

  @override
  State<IncomeDialog> createState() => _IncomeDialogState();
}

class _IncomeDialogState extends State<IncomeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _sourceController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _sourceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final income = Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _sourceController.text.trim(),
        amount: double.parse(_amountController.text.trim()),
        category: 'Income',
        date: DateTime.now(),
        isIncome: true,
      );
      widget.onSave(income);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Income'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _sourceController,
              decoration: const InputDecoration(labelText: 'Income Source (e.g. Salary, Stipend)'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Enter source' : null,
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Amount (₹)', prefixText: '₹ '),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Enter amount';
                if (double.tryParse(v.trim()) == null) return 'Enter valid number';
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        FilledButton(onPressed: _submit, child: const Text('Add Income')),
      ],
    );
  }
}