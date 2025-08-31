import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percon/domain/models/filter_model.dart';

class FilterDialog extends StatefulWidget {
  final FilterModel currentFilter;
  final List<String> availableCountries;
  final List<String> availableRegions;
  final List<String> availableCategories;
  final Function(FilterModel) onApplyFilters;
  final VoidCallback onClearFilters;

  const FilterDialog({
    super.key,
    required this.currentFilter,
    required this.availableCountries,
    required this.availableRegions,
    required this.availableCategories,
    required this.onApplyFilters,
    required this.onClearFilters,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late FilterModel _filter;
  String? _selectedCountry;
  String? _selectedRegion;
  String? _selectedCategory;
  String? _selectedStartDate;
  String? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _filter = widget.currentFilter;
    _selectedCountry = _filter.selectedCountry;
    _selectedRegion = _filter.selectedRegion;
    _selectedCategory = _filter.selectedCategory;
    _selectedStartDate = _filter.selectedStartDate;
    _selectedEndDate = _filter.selectedEndDate;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(l10n),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCountryFilter(l10n),
                    const SizedBox(height: 16),
                    _buildRegionFilter(l10n),
                    const SizedBox(height: 16),
                    _buildCategoryFilter(l10n),
                    const SizedBox(height: 16),
                    _buildDateRangeFilter(l10n),
                  ],
                ),
              ),
            ),
            _buildActions(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_list, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            l10n.filtering,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryFilter(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.country,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCountry,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: l10n.allCountries,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text(l10n.allCountries),
            ),
            ...widget.availableCountries.map((country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }),
          ],
          onChanged: (value) {
            setState(() {
              _selectedCountry = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildRegionFilter(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.region,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedRegion,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: l10n.allRegions,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text(l10n.allRegions),
            ),
            ...widget.availableRegions.map((region) {
              return DropdownMenuItem<String>(
                value: region,
                child: Text(region),
              );
            }),
          ],
          onChanged: (value) {
            setState(() {
              _selectedRegion = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.category,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: l10n.allCategories,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text(l10n.allCategories),
            ),
            ...widget.availableCategories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }),
          ],
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDateRangeFilter(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.dateRange,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller:
                    TextEditingController(text: _selectedStartDate ?? ''),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: l10n.startDate,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onTap: () => _selectDate(true),
                readOnly: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: TextEditingController(text: _selectedEndDate ?? ''),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: l10n.endDate,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onTap: () => _selectDate(false),
                readOnly: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        final dateString =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        if (isStartDate) {
          _selectedStartDate = dateString;
        } else {
          _selectedEndDate = dateString;
        }
      });
    }
  }

  Widget _buildActions(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                widget.onClearFilters();
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(l10n.clear),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final newFilter = FilterModel(
                  selectedCountry: _selectedCountry,
                  selectedRegion: _selectedRegion,
                  selectedCategory: _selectedCategory,
                  selectedStartDate: _selectedStartDate,
                  selectedEndDate: _selectedEndDate,
                );
                widget.onApplyFilters(newFilter);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(l10n.apply),
            ),
          ),
        ],
      ),
    );
  }
}
