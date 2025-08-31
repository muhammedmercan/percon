import 'package:percon/domain/models/travel.dart';

abstract class TravelRepository {
  Future<List<Travel>> getTravels({int offset = 0, int limit = 10});
  Future<int> getTotalTravelCount();
  Future<void> toggleFavorite(String id, bool isFavorite);
  Future<List<Travel>> getFavoriteTravels();
  Future<List<Travel>> getFilteredTravels({
    String? country,
    String? region,
    String? category,
    String? startDate,
    String? endDate,
    int offset = 0,
    int limit = 10,
  });
  Future<int> getFilteredTravelCount({
    String? country,
    String? region,
    String? category,
    String? startDate,
    String? endDate,
  });
  Future<List<String>> getAllCountries();
  Future<List<String>> getAllRegions();
  Future<List<String>> getAllCategories();
}
