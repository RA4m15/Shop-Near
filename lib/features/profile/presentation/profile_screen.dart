import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/providers/user_providers.dart';
import '../../../shared/models/user.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int _activeTabIndex = 0;
  final List<String> _tabs = ['Wishlist', 'Orders', 'Reviews', 'Badges'];

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: userAsync.when(
        data: (user) => _buildProfileBody(user),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildProfileBody(User user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
            // Profile Cover
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF5B5FEF), Color(0xFF764ba2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: GestureDetector(
                      onTap: () => context.push('/home/settings'),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.settings_outlined, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: (user.avatar ?? '').isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: user.avatar!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.person, size: 50),
                                )
                              : Container(
                                  color: AppColors.primary.withOpacity(0.1),
                                  alignment: Alignment.center,
                                  child: Text(
                                    user.name[0].toUpperCase(),
                                    style: AppTextStyles.h1.copyWith(color: AppColors.primary),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(user.name, style: AppTextStyles.h2.copyWith(fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text('${user.handle ?? "@${user.name.replaceAll(" ", "_").toLowerCase()}"} · ${user.location ?? "Indore, MP"}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Text(
                    user.bio ?? 'Local shopping enthusiast 🛍️ Supporting local sellers!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.text, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('47', 'Orders', 1),
                      _buildDivider(),
                      _buildStat('128', 'Following', null),
                      _buildDivider(),
                      _buildStat('34', 'Reviews', 2),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.push('/home/profile/edit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                          ),
                          child: Text('Edit Profile', style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.go('/seller'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: AppColors.border, width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            backgroundColor: AppColors.background,
                          ),
                          child: Text('Seller Mode', style: AppTextStyles.labelMedium.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Loyalty Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF4E6A), Color(0xFFFF7A90)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🏆 LOYALTY POINTS', style: AppTextStyles.labelSmall.copyWith(color: Colors.white.withOpacity(0.9), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                  const SizedBox(height: 6),
                  Text('1,240 pts', style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
                  Text('260 pts away from Gold tier 🥇', style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withOpacity(0.85), fontSize: 12)),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.82,
                      backgroundColor: Colors.white.withOpacity(0.25),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Quick Links Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _activeTabIndex = 1),
                      child: _buildQuickCard(Icons.local_shipping_outlined, 'My Orders', '47 orders', AppColors.secondary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _activeTabIndex = 0),
                      child: _buildQuickCard(Icons.favorite_border, 'Wishlist', '12 items', AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_tabs.length, (index) {
                  return _buildTab(_tabs[index], _activeTabIndex == index, index);
                }),
              ),
            ),

            const SizedBox(height: 12),

            // Tab Content
            _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_activeTabIndex) {
      case 0: // Wishlist
        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildGridItem(context, '👗', const [Color(0xFFFFECD2), Color(0xFFFCB69F)]),
            _buildGridItem(context, '🌿', const [Color(0xFFA8EDEA), Color(0xFFFED6E3)]),
            _buildGridItem(context, '🎨', const [Color(0xFFD4FC79), Color(0xFF96E6A1)]),
            _buildGridItem(context, '💍', const [Color(0xFFF7797D), Color(0xFFFBD786)]),
            _buildGridItem(context, '📱', const [Color(0xFF667EEA), Color(0xFF764BA2)]),
            _buildGridItem(context, '🎀', const [Color(0xFFf093fb), Color(0xFFf5576c)]),
          ],
        );
      case 1: // Orders
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _buildOrderListItem(context, 'Silk Saree Blue', '#BL2048', 'Pending', AppColors.accent),
            _buildOrderListItem(context, 'Banarasi Dupatta', '#BL2047', 'Delivered', AppColors.success),
            _buildOrderListItem(context, 'Cotton Kurti Set', '#BL2046', 'Delivered', AppColors.success),
          ],
        );
      case 2: // Reviews
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _buildReviewItem('Priya Fashion', 'Great quality saree! The fabric is very soft and the color is exactly as shown in the live session.', 5),
            _buildReviewItem('Green Bazaar', 'Fresh organic honey. Delivery was quick and packaging was eco-friendly.', 4),
          ],
        );
      case 3: // Badges
        return GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _buildBadgeItem('🌟', 'Top Buyer'),
            _buildBadgeItem('🔥', 'Early Adopter'),
            _buildBadgeItem('🤝', 'Local Supporter'),
            _buildBadgeItem('💎', 'Premium'),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildOrderListItem(BuildContext context, String name, String id, String status, Color color) {
    return GestureDetector(
      onTap: () => context.push('/home/order-track'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: const Text('🛍️'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.labelMedium),
                  Text(id, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(status, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(String shop, String review, int stars) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(shop, style: AppTextStyles.labelMedium),
              Row(children: List.generate(stars, (i) => const Icon(Icons.star, color: AppColors.accent, size: 12))),
            ],
          ),
          const SizedBox(height: 4),
          Text(review, style: AppTextStyles.bodySmall.copyWith(height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(String emoji, String label) {
    return Column(
      children: [
        Container(
          width: 50, height: 50,
          decoration: BoxDecoration(
            color: AppColors.card,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelSmall.copyWith(fontSize: 8, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildStat(String val, String lbl, int? tabIndex) {
    return GestureDetector(
      onTap: tabIndex != null ? () => setState(() => _activeTabIndex = tabIndex) : null,
      child: Column(
        children: [
          Text(val, style: AppTextStyles.h3.copyWith(fontSize: 18, fontWeight: FontWeight.w900)),
          Text(lbl, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 30, color: AppColors.border);
  }

  Widget _buildQuickCard(IconData icon, String title, String sub, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
              Text(sub, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool active, int index) {
    return GestureDetector(
      onTap: () => setState(() => _activeTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: active ? AppColors.text : Colors.transparent, width: 2.5)),
        ),
        child: Text(
          text,
          style: AppTextStyles.labelMedium.copyWith(
            color: active ? AppColors.text : AppColors.muted,
            fontWeight: active ? FontWeight.w900 : FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String emoji, List<Color> gradient) {
    return GestureDetector(
      onTap: () => context.push('/home/product/1'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        alignment: Alignment.center,
        child: Text(emoji, style: const TextStyle(fontSize: 34)),
      ),
    );
  }
}
