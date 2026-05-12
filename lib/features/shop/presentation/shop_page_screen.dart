import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ShopPageScreen extends StatelessWidget {
  const ShopPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Shop shared successfully! 🔗')),
                );
              },
              child: Container(
                width: 38,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: const Icon(Icons.share, color: Colors.white, size: 18),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            // Shop Cover
            SizedBox(
              height: 180,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1)),
                    alignment: Alignment.center,
                    child: const Text('👗👗👗', style: TextStyle(fontSize: 50, color: Colors.black12)),
                  ),
                  Positioned(
                    bottom: -35,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
                            ),
                            alignment: Alignment.center,
                            child: const Text('👗', style: TextStyle(fontSize: 34)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                              alignment: Alignment.center,
                              child: const Icon(Icons.check, color: Colors.white, size: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),
            
            // Shop Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text('Priya Fashion', style: AppTextStyles.h2.copyWith(fontSize: 20, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: AppColors.primary, size: 12),
                      Text(' Indore, Madhya Pradesh · ', style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted)),
                      const Icon(Icons.access_time, color: AppColors.muted, size: 12),
                      Text(' Est. 2018', style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBF0),
                      border: Border.all(color: AppColors.accent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('⭐ 4.9 · Verified Seller · Top Rated', style: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF92400E), fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Handwoven treasures from local artisans of MP 🌸 Specializing in Banarasi, Chanderi & Maheshwari sarees. Supporting 40+ local weavers.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.text, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  
                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('1.2K', 'Followers'),
                      _buildStat('48', 'Products'),
                      _buildStat('5.2K', 'Sales'),
                      _buildStat('234', 'Reviews'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Now following Priya Fashion! ❤️')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: Text('❤️ Follow Shop', style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.push('/home/chat'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: AppColors.border, width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            backgroundColor: AppColors.background,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.chat_bubble_outline, color: AppColors.text, size: 16),
                              const SizedBox(width: 6),
                              Text('Message', style: AppTextStyles.labelMedium.copyWith(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Live Now Banner
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: GestureDetector(
                onTap: () => context.push('/home/live'),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF1a0a2e), Color(0xFF0d0d1a)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(colors: [Color(0xFFf093fb), Color(0xFFf5576c)]),
                            ),
                            alignment: Alignment.center,
                            child: const Text('👗', style: TextStyle(fontSize: 26)),
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.live, borderRadius: BorderRadius.circular(5)),
                              child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Priya is Live Now!', style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
                            Text('342 watching · Saree demo', style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withOpacity(0.65), fontSize: 11)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(color: AppColors.live, borderRadius: BorderRadius.circular(10)),
                        child: Text('Join', style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTab('Products', true),
                  _buildTab('Reels', false),
                  _buildTab('Reviews', false),
                  _buildTab('About', false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Product Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
              children: [
                _buildProductCard('👗', 'Silk Saree Blue', '₹1,299', '4.8', true, const [Color(0xFFFFECD2), Color(0xFFFCB69F)]),
                _buildProductCard('🧣', 'Banarasi Dupatta', '₹850', '4.9', false, const [Color(0xFFF7E6D0), Color(0xFFF5C0A0)]),
                _buildProductCard('👘', 'Cotton Kurti Set', '₹699', '4.6', false, const [Color(0xFFFFECD2), Color(0xFFF5B49F)]),
                _buildProductCard('🥻', 'Chanderi Saree Pink', '₹1,099', '4.7', true, const [Color(0xFFE0D0F0), Color(0xFFC8A8E8)]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String val, String lbl) {
    return Column(
      children: [
        Text(val, style: AppTextStyles.h3.copyWith(fontSize: 16, fontWeight: FontWeight.w900)),
        Text(lbl, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11)),
      ],
    );
  }

  Widget _buildTab(String text, bool active) {
    return Container(
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
    );
  }

  Widget _buildProductCard(String emoji, String title, String price, String rating, bool liked, List<Color> gradient) {
    return GestureDetector(
      onTap: () {}, // Navigate to product
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      gradient: LinearGradient(colors: gradient),
                    ),
                    alignment: Alignment.center,
                    child: Text(emoji, style: const TextStyle(fontSize: 40)),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Text(liked ? '❤️' : '🤍', style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price, style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w900)),
                      Text('⭐ $rating', style: AppTextStyles.labelSmall.copyWith(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
