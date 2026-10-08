import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/booking_model.dart';
import '../models/event_model.dart';
import '../providers/booking_provider.dart';

class BookingFormScreen extends StatefulWidget {
  final EventModel event;

  const BookingFormScreen({super.key, required this.event});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  int _ticketsCount = 1;
  String _selectedPaymentMethod = 'UPI / Card';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submitBooking() {
    if (!_formKey.currentState!.validate()) return;

    final booking = BookingModel(
      bookingId: 'BK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      eventId: widget.event.id,
      eventTitle: widget.event.title,
      attendeeName: _nameCtrl.text.trim(),
      attendeeEmail: _emailCtrl.text.trim(),
      attendeePhone: _phoneCtrl.text.trim(),
      ticketsCount: _ticketsCount,
      totalAmount: widget.event.price * _ticketsCount,
      bookedAt: DateTime.now(),
    );

    context.read<BookingProvider>().confirmBooking(booking);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Booking Successful!'),
        content: Text(
          'Your ticket ID ${booking.bookingId} has been generated and saved locally.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.event.price * _ticketsCount;

    return Scaffold(
      appBar: AppBar(title: const Text('Reserve Tickets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) => v == null || v.isEmpty ? 'Please enter name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (v) =>
                    v == null || !v.contains('@') ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (v) =>
                    v == null || v.length < 10 ? 'Enter valid 10-digit phone' : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of Tickets:', style: TextStyle(fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: _ticketsCount > 1
                            ? () => setState(() => _ticketsCount--)
                            : null,
                      ),
                      Text('$_ticketsCount', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: _ticketsCount < 10
                            ? () => setState(() => _ticketsCount++)
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedPaymentMethod,
                decoration: const InputDecoration(labelText: 'Payment Method'),
                items: ['UPI / Card', 'Net Banking', 'Pay at Venue']
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedPaymentMethod = v!),
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Payable:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _submitBooking,
                  child: const Text('Confirm & Pay'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}