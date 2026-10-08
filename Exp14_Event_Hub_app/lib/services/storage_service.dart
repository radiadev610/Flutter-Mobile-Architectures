import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking_model.dart';
import '../models/event_model.dart';

class StorageService {
  static const String _offlineEventsKey = 'cached_offline_events_v1';
  static const String _bookingsKey = 'saved_user_bookings_v1';

  Future<void> cacheEvents(List<EventModel> events) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = events.map((e) => e.toJson()).toList();
    await prefs.setString(_offlineEventsKey, json.encode(jsonList));
  }

  Future<List<EventModel>> getCachedEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_offlineEventsKey);
    if (raw == null || raw.isEmpty) return [];

    try {
      final List<dynamic> list = json.decode(raw);
      return list.map((item) => EventModel.fromJson(item as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveBooking(BookingModel booking) async {
    final prefs = await SharedPreferences.getInstance();
    final currentBookings = await getBookings();
    currentBookings.insert(0, booking);

    final jsonList = currentBookings.map((b) => b.toJson()).toList();
    await prefs.setString(_bookingsKey, json.encode(jsonList));
  }

  Future<List<BookingModel>> getBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_bookingsKey);
    if (raw == null || raw.isEmpty) return [];

    try {
      final List<dynamic> list = json.decode(raw);
      return list.map((item) => BookingModel.fromJson(item as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }
}