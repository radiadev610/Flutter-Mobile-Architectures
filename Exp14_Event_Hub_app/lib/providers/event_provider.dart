import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class EventProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  List<EventModel> _allEvents = [];
  bool _isLoading = false;
  bool _isOfflineBackup = false;
  String _errorMessage = '';

  // Multi-Condition Filtering parameters
  String _searchKeyword = '';
  String _selectedCategory = 'All';
  double _maxPrice = 200.0;

  List<EventModel> get allEvents => _allEvents;
  bool get isLoading => _isLoading;
  bool get isOfflineBackup => _isOfflineBackup;
  String get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  double get maxPrice => _maxPrice;

  List<EventModel> get filteredEvents {
    return _allEvents.where((event) {
      final matchesSearch = event.title
              .toLowerCase()
              .contains(_searchKeyword.toLowerCase()) ||
          event.location.toLowerCase().contains(_searchKeyword.toLowerCase());

      final matchesCategory =
          _selectedCategory == 'All' || event.category == _selectedCategory;

      final matchesPrice = event.price <= _maxPrice;

      return matchesSearch && matchesCategory && matchesPrice;
    }).toList();
  }

  Future<void> fetchEvents() async {
    _isLoading = true;
    _errorMessage = '';
    _isOfflineBackup = false;
    notifyListeners();

    try {
      final fetched = await _apiService.fetchEvents();
      _allEvents = fetched;
      await _storageService.cacheEvents(fetched);
    } catch (_) {
      final cached = await _storageService.getCachedEvents();
      if (cached.isNotEmpty) {
        _allEvents = cached;
        _isOfflineBackup = true;
      } else {
        _errorMessage = 'No network connection and no cached events available.';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearch(String val) {
    _searchKeyword = val;
    notifyListeners();
  }

  void setFilters({required String category, required double maxPrice}) {
    _selectedCategory = category;
    _maxPrice = maxPrice;
    notifyListeners();
  }

  void resetFilters() {
    _selectedCategory = 'All';
    _maxPrice = 200.0;
    _searchKeyword = '';
    notifyListeners();
  }
}