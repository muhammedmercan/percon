import 'package:flutter/material.dart';
import 'package:percon/utils/constants.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String dateRange;
  final bool isFavorite;
  final bool isGridView;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.dateRange,
    this.isFavorite = false,
    this.isGridView = false,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          child: isGridView ? _buildGridContent() : _buildListContent(),
        ),
      ),
    );
  }

  Widget _buildListContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(),
        const SizedBox(height: 4),
        _buildSubtitle(),
        const SizedBox(height: AppSizes.paddingSmall),
        _buildDescription(),
        const SizedBox(height: AppSizes.paddingSmall),
        _buildDateRange(),
      ],
    );
  }

  Widget _buildGridContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(),
        const SizedBox(height: 6),
        _buildSubtitle(),
        const SizedBox(height: 6),
        _buildDescription(),
        const Spacer(),
        _buildDateRange(),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: isGridView
                ? AppTextStyles.body1.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )
                : AppTextStyles.heading2,
            maxLines: isGridView ? 2 : null,
            overflow: isGridView ? TextOverflow.ellipsis : null,
          ),
        ),
        GestureDetector(
          onTap: onFavoritePressed,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? AppColors.favorite : AppColors.grey,
            size:
                isGridView ? AppSizes.iconSizeMedium : AppSizes.iconSizeMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle,
      style: isGridView
          ? AppTextStyles.body2.copyWith(
              color: AppColors.greyDark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )
          : AppTextStyles.body2.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.greyDark,
            ),
      maxLines: isGridView ? 1 : null,
      overflow: isGridView ? TextOverflow.ellipsis : null,
    );
  }

  Widget _buildDescription() {
    return Text(
      description,
      style: isGridView
          ? AppTextStyles.body2.copyWith(
              height: 1.3,
              fontSize: 13,
            )
          : AppTextStyles.body2.copyWith(
              height: 1.3,
            ),
      maxLines: isGridView ? 3 : 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDateRange() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Text(
        dateRange,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.greyDark,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
