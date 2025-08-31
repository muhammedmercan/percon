import 'package:flutter/material.dart';
import 'package:percon/domain/models/travel.dart';
import 'package:percon/domain/models/filter_model.dart';
import 'package:percon/data/local/database_helper.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isGridView = false;
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 0;
  static const int _pageSize = 10;

  List<Travel> _displayedTravelData = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  FilterModel _currentFilter = FilterModel();
  List<String> _availableCountries = [];
  List<String> _availableRegions = [];
  List<String> _availableCategories = [];
  int _filteredTotalCount = 0;
  bool _isShowingFavorites = false;

  bool get isGridView => _isGridView;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;
  List<Travel> get travelData => _displayedTravelData;
  int get travelDataCount => _displayedTravelData.length;
  FilterModel get currentFilter => _currentFilter;
  List<String> get availableCountries => _availableCountries;
  List<String> get availableRegions => _availableRegions;
  List<String> get availableCategories => _availableCategories;
  int get filteredTotalCount => _filteredTotalCount;
  bool get isShowingFavorites => _isShowingFavorites;

  HomeViewModel() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      _loadTravelData(),
      _loadFilterOptions(),
    ]);
  }

  // Helpers
  Future<void> _runWithLoading(Future<void> Function() action) async {
    _isLoading = true;
    notifyListeners();
    try {
      await action();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Travel> _applyFavoritesFilter(List<Travel> travels) {
    return _isShowingFavorites
        ? travels.where((t) => t.isFavorite).toList()
        : travels;
  }

  // Methods
  void toggleGridView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  Future<void> toggleFavorite(int index) async {
    if (index < 0 || index >= _displayedTravelData.length) return;

    final travel = _displayedTravelData[index];
    final updatedTravel = travel.copyWith(isFavorite: !travel.isFavorite);

    await _databaseHelper.toggleFavorite(travel.id, updatedTravel.isFavorite);

    _displayedTravelData[index] = updatedTravel;
    notifyListeners();
  }

  void onFilterPressed() => _loadFilterOptions();

  Future<void> _loadFilterOptions() async {
    try {
      _availableCountries = await _databaseHelper.getAllCountries();
      _availableRegions = await _databaseHelper.getAllRegions();
      _availableCategories = await _databaseHelper.getAllCategories();
      notifyListeners();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> applyFilters(FilterModel filter) async {
    _currentFilter = filter;
    _currentPage = 0;
    _hasMoreData = true;
    await _loadFilteredData();
  }

  Future<void> _loadFilteredData() async {
    await _runWithLoading(() async {
      var travels = await _databaseHelper.getTravelsWithFiltersAndPagination(
        country: _currentFilter.selectedCountry,
        region: _currentFilter.selectedRegion,
        category: _currentFilter.selectedCategory,
        startDate: _currentFilter.selectedStartDate,
        endDate: _currentFilter.selectedEndDate,
        offset: 0,
        limit: _pageSize,
      );

      _displayedTravelData = _applyFavoritesFilter(travels);
      _currentPage = 1;

      _filteredTotalCount = await _databaseHelper.getFilteredTravelCount(
        country: _currentFilter.selectedCountry,
        region: _currentFilter.selectedRegion,
        category: _currentFilter.selectedCategory,
        startDate: _currentFilter.selectedStartDate,
        endDate: _currentFilter.selectedEndDate,
      );

      _hasMoreData = _displayedTravelData.length < _filteredTotalCount;
    });
  }

  Future<void> loadMoreFilteredData() async {
    if (_isLoading || !_hasMoreData) return;

    await _runWithLoading(() async {
      var newTravels = await _databaseHelper.getTravelsWithFiltersAndPagination(
        country: _currentFilter.selectedCountry,
        region: _currentFilter.selectedRegion,
        category: _currentFilter.selectedCategory,
        startDate: _currentFilter.selectedStartDate,
        endDate: _currentFilter.selectedEndDate,
        offset: _currentPage * _pageSize,
        limit: _pageSize,
      );

      newTravels = _applyFavoritesFilter(newTravels);

      if (newTravels.isNotEmpty) {
        _displayedTravelData.addAll(newTravels);
        _currentPage++;
        if (newTravels.length < _pageSize) _hasMoreData = false;
      } else {
        _hasMoreData = false;
      }
    });
  }

  Future<void> clearFilters() async {
    _currentFilter = FilterModel();
    _currentPage = 0;
    _hasMoreData = true;
    _displayedTravelData.clear();
    await _loadTravelData();
  }

  Travel? getTravelDataByIndex(int index) =>
      (index >= 0 && index < _displayedTravelData.length)
          ? _displayedTravelData[index]
          : null;

  Future<void> refreshData() async {
    _currentPage = 0;
    _hasMoreData = true;
    _displayedTravelData.clear();
    await _loadTravelData();
  }

  Future<void> loadMoreData() async {
    if (_isLoading || !_hasMoreData) return;

    if (_currentFilter.hasActiveFilters) {
      await loadMoreFilteredData();
      return;
    }

    await _runWithLoading(() async {
      final newTravels = await _databaseHelper.getTravelsWithPagination(
        _currentPage * _pageSize,
        _pageSize,
      );

      if (newTravels.isNotEmpty) {
        _displayedTravelData.addAll(_applyFavoritesFilter(newTravels));
        _currentPage++;
        if (newTravels.length < _pageSize) _hasMoreData = false;
      } else {
        _hasMoreData = false;
      }
    });
  }

  void filterFavorites() async {
    await _runWithLoading(() async {
      _currentPage = 0;
      _hasMoreData = false;
      _isShowingFavorites = true;
      _displayedTravelData = await _databaseHelper.getFavoriteTravels();
    });
  }

  Future<void> showAllData() async {
    _currentPage = 0;
    _hasMoreData = true;
    _isShowingFavorites = false;
    _displayedTravelData.clear();
    await _loadTravelData();
  }

  Future<void> _loadTravelData() async {
    await _runWithLoading(() async {
      var travels =
          await _databaseHelper.getTravelsWithPagination(0, _pageSize);
      _displayedTravelData = _applyFavoritesFilter(travels);
      _currentPage = 1;

      final totalCount = await _databaseHelper.getTotalTravelCount();
      _hasMoreData = _displayedTravelData.length < totalCount;
    });
  }
}
