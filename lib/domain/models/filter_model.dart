class FilterModel {
  final String? selectedCountry;
  final String? selectedRegion;
  final String? selectedCategory;
  final String? selectedStartDate;
  final String? selectedEndDate;

  FilterModel({
    this.selectedCountry,
    this.selectedRegion,
    this.selectedCategory,
    this.selectedStartDate,
    this.selectedEndDate,
  });

  FilterModel copyWith({
    String? selectedCountry,
    String? selectedRegion,
    String? selectedCategory,
    String? selectedStartDate,
    String? selectedEndDate,
  }) {
    return FilterModel(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedStartDate: selectedStartDate ?? this.selectedStartDate,
      selectedEndDate: selectedEndDate ?? this.selectedEndDate,
    );
  }

  bool get hasActiveFilters {
    return selectedCountry != null ||
        selectedRegion != null ||
        selectedCategory != null ||
        selectedStartDate != null ||
        selectedEndDate != null;
  }

  FilterModel clearFilters() {
    return FilterModel();
  }
}
