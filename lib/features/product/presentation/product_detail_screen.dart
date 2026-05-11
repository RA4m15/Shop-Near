import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? productId;
  const ProductDetailScreen({super.key, this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String heroTag = widget.productId != null ? 'product_img_${widget.productId}' : 'product_img_default';
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.92), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.chevron_left, color: AppColors.text, size: 20),
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.92), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.share, color: AppColors.text, size: 18),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product link copied! 🔗')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: heroTag,
                  child: Container(
                    height: 380,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFECD2), Color(0xFFFCB69F)],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text('👗', style: TextStyle(fontSize: 120, decoration: TextDecoration.none)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildBadge('#Handloom', const Color(0xFFDBEAFE), const Color(0xFF1E40AF)),
                          const SizedBox(width: 8),
                          _buildBadge('#Bestseller', const Color(0xFFDCFCE7), const Color(0xFF166534)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text('Silk Saree Blue — Chanderi', style: AppTextStyles.h2.copyWith(fontSize: 24, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text('By ', style: AppTextStyles.bodySmall.copyWith(fontSize: 13, color: AppColors.muted)),
                          Text('Priya Fashion', style: AppTextStyles.labelSmall.copyWith(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.text)),
                          Text(' · Indore ', style: AppTextStyles.bodySmall.copyWith(fontSize: 13, color: AppColors.muted)),
                          const Icon(Icons.location_on, color: AppColors.primary, size: 12),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text('₹1,299', style: AppTextStyles.h1.copyWith(fontSize: 32, color: AppColors.primary, fontWeight: FontWeight.w900)),
                          const SizedBox(width: 14),
                          Text('₹1,999', style: AppTextStyles.bodyMedium.copyWith(fontSize: 16, color: AppColors.muted, decoration: TextDecoration.lineThrough)),
                          const SizedBox(width: 14),
                          _buildBadge('35% OFF', const Color(0xFFFEF3C7), const Color(0xFF92400E)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: AppColors.accent, size: 18),
                          Text(' 4.8 ', style: AppTextStyles.labelSmall.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                          Text('(234 reviews)', style: AppTextStyles.bodySmall.copyWith(fontSize: 13, color: AppColors.muted)),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(height: 1, color: AppColors.border),
                      ),
                      Text('Product Details', style: AppTextStyles.labelMedium.copyWith(fontSize: 15, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text(
                        'Authentic Chanderi silk saree with golden zari work. Perfect for festive occasions and weddings. Handwoven by local artisans of Madhya Pradesh. Care: Dry clean only. Length: 5.5 meters + 0.8 meter blouse piece.',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.muted, fontSize: 14, height: 1.7),
                      ),
                      const SizedBox(height: 24),
                      
                      // Seller Card with Shine
                      AnimatedBuilder(
                        animation: _shineController,
                        builder: (context, child) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.border),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [Color(0xFFFFECD2), Color(0xFFFCB69F)]),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text('👗', style: TextStyle(fontSize: 28)),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Priya Fashion', style: AppTextStyles.labelMedium.copyWith(fontSize: 15, fontWeight: FontWeight.w900)),
                                          const SizedBox(width: 6),
                                          _buildVerifiedBadge(),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text('⭐ 4.9 · 100% Response Rate', style: AppTextStyles.bodySmall.copyWith(fontSize: 12, color: AppColors.muted)),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
                                  onPressed: () => context.go('/home/chat'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Text('Top Reviews', style: AppTextStyles.labelMedium.copyWith(fontSize: 15, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 12),
                      _buildReview('Anjali S.', 'Beautiful color and fabric. Looks exactly like the live session demo. Very happy with the purchase! 😍'),
                      _buildReview('Kavita D.', 'Fast delivery. The zari work is stunning. Will buy more from Priya Fashion.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Floating Bottom Action Bar
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              height: 64,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to Cart! 🛒')),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Add to Cart',
                          style: AppTextStyles.labelMedium.copyWith(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => context.push('/home/cart'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Buy Now',
                          style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: AppTextStyles.labelSmall.copyWith(color: textCol, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(color: Color(0xFF3B82F6), shape: BoxShape.circle),
      child: const Icon(Icons.check, color: Colors.white, size: 8),
    );
  }

  Widget _buildReview(String name, String review) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: AppTextStyles.labelSmall.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
              const Spacer(),
              const Icon(Icons.star_rounded, color: AppColors.accent, size: 14),
              const Icon(Icons.star_rounded, color: AppColors.accent, size: 14),
              const Icon(Icons.star_rounded, color: AppColors.accent, size: 14),
              const Icon(Icons.star_rounded, color: AppColors.accent, size: 14),
              const Icon(Icons.star_rounded, color: AppColors.accent, size: 14),
            ],
          ),
          const SizedBox(height: 4),
          Text(review, style: AppTextStyles.bodySmall.copyWith(fontSize: 13, color: AppColors.muted, height: 1.6)),
        ],
      ),
    );
  }
}
