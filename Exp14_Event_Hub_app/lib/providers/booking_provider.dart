import 'package:flutter/foundation.dart';
import '../models/booking_model.dart';
import '../services/notification_service.dart';
import '../services/storage_service.dart';

class BookingProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<BookingModel> _bookings = [];
  bool _isLoading = false;

  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;

  // Analytics derivations
  int get totalBookingsCount => _bookings.length;

  int get totalTicketsBooked =>
      _bookings.fold(0, (sum, item) => sum + item.ticketsCount);

  double get totalRevenue =>
      _bookings.fold(0.0, (sum, item) => sum + item.totalAmount);

  Map<String, int> get bookingsPerEvent {
    final Map<String, int> stats = {};
    for (var b in _bookings) {
      stats[b.eventTitle] = (stats[b.eventTitle] ?? 0) + b.ticketsCount;
    }
    return stats;
  }

  Future<void> loadBookings() async {
    _isLoading = true;
    notifyListeners();

    _bookings = await _storageService.getBookings();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> confirmBooking(BookingModel booking) async {
    await _storageService.saveBooking(booking);
    _bookings.insert(0, booking);
    notifyListeners();

    NotificationService.showEventReminder(
      title: 'Ticket Confirmed!',
      message: '${booking.ticketsCount} seat(s) booked for ${booking.eventTitle}.',
    );
  }
}