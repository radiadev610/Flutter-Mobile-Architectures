import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _selectedCategory;
  late double _maxPrice;

  final List<String> _categories = ['All', 'Tech', 'Music', 'Design', 'Business'];

  @override
  void initState() {
    super.initState();
    final p = context.read<EventProvider>();
    _selectedCategory = p.selectedCategory;
    _maxPrice = p.maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Events',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  context.read<EventProvider>().resetFilters();
                  Navigator.pop(context);
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Category', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _categories.map((cat) {
              final isSel = _selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: isSel,
                onSelected: (_) => setState(() => _selectedCategory = cat),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Max Price', style: TextStyle(fontWeight: FontWeight.w600)),
              Text('\$${_maxPrice.toStringAsFixed(0)}'),
            ],
          ),
          Slider(
            min: 10,
            max: 200,
            divisions: 19,
            value: _maxPrice,
            onChanged: (val) => setState(() => _maxPrice = val),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<EventProvider>().setFilters(
                      category: _selectedCategory,
                      maxPrice: _maxPrice,
                    );
                Navigator.pop(context);
              },
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}