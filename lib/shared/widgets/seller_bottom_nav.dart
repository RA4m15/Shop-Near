import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SellerBottomNav extends StatelessWidget {
  final String currentRoute;

  const SellerBottomNav({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: Row(
        children: [
          _buildNavItem(context, 'Dashboard', Icons.home_filled, Icons.home_outlined, '/seller'),
          _buildNavItem(context, 'Products', Icons.inventory, Icons.inventory_2_outlined, '/seller/products'),
          _buildLiveNavBtn(context),
          _buildNavItem(context, 'Orders', Icons.shopping_bag, Icons.shopping_bag_outlined, '/seller/orders'),
          _buildNavItem(context, 'Analytics', Icons.bar_chart, Icons.bar_chart, '/seller/analytics'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String label, IconData activeIcon, IconData inactiveIcon, String route) {
    final isActive = currentRoute == route;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!isActive) context.go(route);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? AppColors.primary : AppColors.muted,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isActive ? AppColors.primary : AppColors.muted,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveNavBtn(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => context.push('/seller/golive'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(0, -14),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.liveRed, Color(0xFFFF6B35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.liveRed.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: const Icon(Icons.sensors, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'GO LIVE',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.liveRed,
                fontWeight: FontWeight.w900,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
