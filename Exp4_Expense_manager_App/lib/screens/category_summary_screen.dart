import 'package:flutter/material.dart';
import '../models/expense_model.dart';

class CategorySummaryScreen extends StatelessWidget {
  final List<Expense> expenses;

  const CategorySummaryScreen({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final expenseOnly = expenses.where((e) => !e.isIncome).toList();

    // Group totals by category
    final Map<String, double> categoryTotals = {};
    for (var item in expenseOnly) {
      categoryTotals[item.category] =
          (categoryTotals[item.category] ?? 0.0) + item.amount;
    }

    // Determine highest expense category
    String highestCategory = 'None';
    double highestAmount = 0.0;
    categoryTotals.forEach((cat, amt) {
      if (amt > highestAmount) {
        highestAmount = amt;
        highestCategory = cat;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Category Breakdown')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.red.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Colors.red.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.red, size: 36),
                      const SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Highest Expense Category',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                            Text(
                              highestCategory,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              'Total: ₹${highestAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Expenditure by Category',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: categoryTotals.isEmpty
                    ? const Center(child: Text('No expenses recorded yet.'))
                    : ListView(
                        children: categoryTotals.entries.map((entry) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                child: Text(entry.key[0]),
                              ),
                              title: Text(entry.key,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              trailing: Text(
                                '₹${entry.value.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}