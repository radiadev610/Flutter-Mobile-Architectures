import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense_model.dart';
import '../widgets/expense_dialog.dart';
import '../widgets/income_dialog.dart';
import 'category_summary_screen.dart';

class ExpenseHomeScreen extends StatefulWidget {
  const ExpenseHomeScreen({super.key});

  @override
  State<ExpenseHomeScreen> createState() => _ExpenseHomeScreenState();
}

class _ExpenseHomeScreenState extends State<ExpenseHomeScreen> {
  static const String _storageKey = 'saved_transactions';
  List<Expense> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  // Local Persistence: Load items
  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedList = prefs.getStringList(_storageKey);

    if (storedList != null) {
      setState(() {
        _transactions =
            storedList.map((item) => Expense.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  // Local Persistence: Save items
  Future<void> _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> encodedList =
        _transactions.map((item) => item.toJson()).toList();
    await prefs.setStringList(_storageKey, encodedList);
  }

  // CRUD: Add
  void _addTransaction(Expense expense) {
    setState(() {
      _transactions.insert(0, expense);
    });
    _saveTransactions();
  }

  // CRUD: Edit
  void _editTransaction(Expense updatedExpense) {
    setState(() {
      final index =
          _transactions.indexWhere((e) => e.id == updatedExpense.id);
      if (index != -1) {
        _transactions[index] = updatedExpense;
      }
    });
    _saveTransactions();
  }

  // CRUD: Delete
  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((e) => e.id == id);
    });
    _saveTransactions();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaction removed'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Calculations
  double get _totalExpense => _transactions
      .where((e) => !e.isIncome)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get _totalIncome => _transactions
      .where((e) => e.isIncome)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get _netBalance => _totalIncome - _totalExpense;

  void _openExpenseDialog({Expense? expense}) {
    showDialog(
      context: context,
      builder: (ctx) => ExpenseDialog(
        existingExpense: expense,
        onSave: (saved) {
          if (expense == null) {
            _addTransaction(saved);
          } else {
            _editTransaction(saved);
          }
        },
      ),
    );
  }

  void _openIncomeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => IncomeDialog(onSave: _addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Manager'),
        actions: [
          IconButton(
            tooltip: 'Category Summary',
            icon: const Icon(Icons.pie_chart_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      CategorySummaryScreen(expenses: _transactions),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Financial Overview Card (Income, Expense, Net Balance)
                Card(
                  margin: const EdgeInsets.all(12.0),
                  elevation: 2.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12.0),
                    child: Column(
                      children: [
                        Text(
                          'Net Balance',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '₹${_netBalance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: _netBalance >= 0
                                ? Colors.teal
                                : Colors.redAccent,
                          ),
                        ),
                        const Divider(height: 24.0),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Income',
                                      style: TextStyle(fontSize: 12.0)),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    '+₹${_totalIncome.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 28,
                                width: 1,
                                color: Colors.grey.shade300),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Expense',
                                      style: TextStyle(fontSize: 12.0)),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    '-₹${_totalExpense.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Transactions List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_transactions.length} items',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: _transactions.isEmpty
                      ? const Center(
                          child: Text(
                            'No transactions yet. Click + to add!',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _transactions.length,
                          itemBuilder: (context, index) {
                            final item = _transactions[index];
                            return Dismissible(
                              key: Key(item.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20.0),
                                color: Colors.redAccent,
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              onDismissed: (_) =>
                                  _deleteTransaction(item.id),
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 5.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: item.isIncome
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                    child: Icon(
                                      item.isIncome
                                          ? Icons.arrow_downward
                                          : Icons.shopping_bag_outlined,
                                      color: item.isIncome
                                          ? Colors.green
                                          : Colors.redAccent,
                                      size: 20,
                                    ),
                                  ),
                                  title: Text(
                                    item.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    '${item.category} • ${item.date.day}/${item.date.month}/${item.date.year}',
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${item.isIncome ? '+' : '-'}₹${item.amount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: item.isIncome
                                              ? Colors.green
                                              : Colors.redAccent,
                                        ),
                                      ),
                                      if (!item.isIncome)
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              size: 18, color: Colors.grey),
                                          onPressed: () => _openExpenseDialog(
                                              expense: item),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'income_btn',
            onPressed: _openIncomeDialog,
            icon: const Icon(Icons.add),
            label: const Text('Income'),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          const SizedBox(width: 12.0),
          FloatingActionButton.extended(
            heroTag: 'expense_btn',
            onPressed: () => _openExpenseDialog(),
            icon: const Icon(Icons.remove),
            label: const Text('Expense'),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}