import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percon/presentation/home/home_view_model.dart';
import 'package:percon/presentation/home/infoCard.dart';
import 'package:percon/presentation/home/filter_dialog.dart';
import 'package:percon/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  void _onScroll() {
    final viewModel = context.read<HomeViewModel>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        viewModel.hasMoreData &&
        !viewModel.isLoading) {
      viewModel.loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homePage),
        backgroundColor: Colors.blueAccent.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          _buildContent(l10n),
        ],
      ),
    );
  }

  Widget _buildToolbar() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFilterButton(),
            Row(
              children: [
                _buildFavoritesButton(),
                const SizedBox(width: 12),
                _buildGridToggleButton(),
              ],
            ),
          ],
        ),
      );

  Widget _buildFilterButton() {
    return Consumer<HomeViewModel>(
      builder: (context, vm, _) {
        final hasFilters = vm.currentFilter.hasActiveFilters;
        final l10n = AppLocalizations.of(context)!;
        return _ToolbarButton(
          active: hasFilters,
          activeColor: Colors.blue,
          onTap: () => _showFilterDialog(vm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.filter_list,
                  size: AppSizes.iconSizeMedium,
                  color: hasFilters ? Colors.blue : AppColors.textPrimary),
              const SizedBox(width: AppSizes.paddingSmall),
              Text(
                l10n.filter,
                style: AppTextStyles.body2.copyWith(
                  fontWeight: FontWeight.w500,
                  color: hasFilters ? Colors.blue : AppColors.textPrimary,
                ),
              ),
              if (hasFilters)
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.check, size: 12, color: Colors.white),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  void _showFilterDialog(HomeViewModel vm) {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        currentFilter: vm.currentFilter,
        availableCountries: vm.availableCountries,
        availableRegions: vm.availableRegions,
        availableCategories: vm.availableCategories,
        onApplyFilters: vm.applyFilters,
        onClearFilters: vm.clearFilters,
      ),
    );
  }

  Widget _buildGridToggleButton() => Consumer<HomeViewModel>(
        builder: (context, vm, _) => _ToolbarIcon(
          icon: vm.isGridView ? Icons.view_list : Icons.grid_view,
          onTap: vm.toggleGridView,
        ),
      );

  Widget _buildFavoritesButton() => Consumer<HomeViewModel>(
        builder: (context, vm, _) => _ToolbarButton(
          active: vm.isShowingFavorites,
          activeColor: Colors.red,
          onTap: () =>
              vm.isShowingFavorites ? vm.showAllData() : vm.filterFavorites(),
          child: Icon(Icons.favorite,
              size: AppSizes.iconSizeMedium,
              color:
                  vm.isShowingFavorites ? Colors.red : AppColors.textPrimary),
        ),
      );

  Widget _buildContent(AppLocalizations l10n) {
    return Expanded(
      child: Consumer<HomeViewModel>(
        builder: (context, vm, _) => Column(
          children: [
            if (vm.currentFilter.hasActiveFilters)
              _FilterInfoBar(
                l10n: l10n,
                shown: vm.travelDataCount,
                total: vm.filteredTotalCount,
                onClear: vm.clearFilters,
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: vm.refreshData,
                child: vm.isGridView ? _buildGridView(vm) : _buildListView(vm),
              ),
            ),
            if (vm.isLoading && vm.travelDataCount > 0)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(HomeViewModel vm) => ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        itemCount: vm.travelDataCount + (vm.hasMoreData ? 1 : 0),
        itemBuilder: (_, i) {
          if (i == vm.travelDataCount) {
            return vm.isLoading
                ? _buildLoadingIndicator()
                : const SizedBox.shrink();
          }
          return _buildItem(vm, i, false);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
      );

  Widget _buildGridView(HomeViewModel vm) => GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 180,
        ),
        itemCount: vm.travelDataCount + (vm.hasMoreData ? 1 : 0),
        itemBuilder: (_, i) {
          if (i == vm.travelDataCount) {
            return vm.isLoading
                ? _buildLoadingIndicator()
                : const SizedBox.shrink();
          }
          return _buildItem(vm, i, true);
        },
      );

  Widget _buildItem(HomeViewModel vm, int index, bool grid) {
    final t = vm.getTravelDataByIndex(index);
    if (t == null) return const SizedBox.shrink();
    return InfoCard(
      title: t.title,
      subtitle: "${t.country} - ${t.region}",
      description: t.description,
      dateRange: '${t.startDate} - ${t.endDate}',
      isFavorite: t.isFavorite,
      isGridView: grid,
      onFavoritePressed: () => vm.toggleFavorite(index),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;
  final Widget child;
  const _ToolbarButton({
    required this.active,
    required this.activeColor,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: active ? activeColor : AppColors.greyLight,
            width: active ? 2 : 1),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        color: active ? activeColor.withOpacity(.1) : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingSmall,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _ToolbarIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ToolbarIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingSmall),
            child: Icon(icon,
                size: AppSizes.iconSizeMedium, color: AppColors.textPrimary),
          ),
        ),
      );
}

class _FilterInfoBar extends StatelessWidget {
  final AppLocalizations l10n;
  final int shown, total;
  final VoidCallback onClear;
  const _FilterInfoBar({
    required this.l10n,
    required this.shown,
    required this.total,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.filteredResults,
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  Text(
                      '${l10n.showing}: $shown / ${l10n.total}: $total ${l10n.travels}',
                      style:
                          TextStyle(color: Colors.blue.shade600, fontSize: 12)),
                ],
              ),
            ),
            TextButton(
              onPressed: onClear,
              child: Text(l10n.clear,
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
}
