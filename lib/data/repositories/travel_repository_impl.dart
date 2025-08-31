import 'package:percon/data/local/database_helper.dart';
import 'package:percon/domain/models/travel.dart';
import 'package:percon/domain/repositories/travel_repository.dart';

class TravelRepositoryImpl implements TravelRepository {
  final DatabaseHelper _databaseHelper;

  TravelRepositoryImpl({DatabaseHelper? databaseHelper})
      : _databaseHelper = databaseHelper ?? DatabaseHelper();

  @override
  Future<List<Travel>> getTravels({int offset = 0, int limit = 10}) async {
    return await _databaseHelper.getTravelsWithPagination(offset, limit);
  }

  @override
  Future<int> getTotalTravelCount() async {
    return await _databaseHelper.getTotalTravelCount();
  }

  @override
  Future<void> toggleFavorite(String id, bool isFavorite) async {
    await _databaseHelper.toggleFavorite(id, isFavorite);
  }

  @override
  Future<List<Travel>> getFavoriteTravels() async {
    return await _databaseHelper.getFavoriteTravels();
  }

  @override
  Future<List<Travel>> getFilteredTravels({
    String? country,
    String? region,
    String? category,
    String? startDate,
    String? endDate,
    int offset = 0,
    int limit = 10,
  }) async {
    return await _databaseHelper.getTravelsWithFiltersAndPagination(
      country: country,
      region: region,
      category: category,
      startDate: startDate,
      endDate: endDate,
      offset: offset,
      limit: limit,
    );
  }

  @override
  Future<int> getFilteredTravelCount({
    String? country,
    String? region,
    String? category,
    String? startDate,
    String? endDate,
  }) async {
    return await _databaseHelper.getFilteredTravelCount(
      country: country,
      region: region,
      category: category,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<String>> getAllCountries() async {
    return await _databaseHelper.getAllCountries();
  }

  @override
  Future<List<String>> getAllRegions() async {
    return await _databaseHelper.getAllRegions();
  }

  @override
  Future<List<String>> getAllCategories() async {
    return await _databaseHelper.getAllCategories();
  }
}
