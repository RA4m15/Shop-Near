import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Track Header (gradient background)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 52, 16, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5B5FEF), Color(0xFF8B8FF5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/home');
                          }
                        },
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                      ),
                      Text('Track Order', style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
                      IconButton(
                        icon: const Icon(Icons.headset_mic_outlined, color: Colors.white, size: 20),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Customer support coming soon! 🎧')),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.local_shipping_outlined, color: Colors.white, size: 14),
                        const SizedBox(width: 6),
                        Text('Out for Delivery', style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Order #BL2048', style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text('Silk Banarasi Saree · Priya Fashion · ₹1,299', style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                  const SizedBox(height: 14),
                  // Map placeholder
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white, size: 30),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Arriving in ~18 min', style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
                            Text('2.1km from your location', style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Timeline
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Timeline', style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 16),
                  _buildTimelineItem(
                    icon: Icons.check,
                    isDone: true,
                    isActive: false,
                    isLast: false,
                    title: 'Order Placed',
                    subtitle: 'Payment confirmed via UPI',
                    time: 'Today, 9:42 AM',
                  ),
                  _buildTimelineItem(
                    icon: Icons.check,
                    isDone: true,
                    isActive: false,
                    isLast: false,
                    title: 'Seller Accepted',
                    subtitle: 'Priya Fashion confirmed your order',
                    time: 'Today, 9:55 AM',
                  ),
                  _buildTimelineItem(
                    icon: Icons.check,
                    isDone: true,
                    isActive: false,
                    isLast: false,
                    title: 'Packed & Ready',
                    subtitle: 'Order packed securely',
                    time: 'Today, 10:30 AM',
                  ),
                  _buildTimelineItem(
                    icon: Icons.local_shipping,
                    isDone: false,
                    isActive: true,
                    isLast: false,
                    title: 'Out for Delivery',
                    subtitle: 'Rider Raju K. is on the way',
                    time: 'Today, 11:15 AM · Now',
                  ),
                  _buildTimelineItem(
                    icon: Icons.home,
                    isDone: false,
                    isActive: false,
                    isLast: true,
                    title: 'Delivered',
                    subtitle: 'Expected by 11:35 AM',
                    time: '',
                  ),
                ],
              ),
            ),

            // Rider Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Delivery Partner', style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)]),
                        ),
                        alignment: Alignment.center,
                        child: const Text('🚴', style: TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Raju Kumar', style: AppTextStyles.labelLarge.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                            Text('⭐ 4.7 · 847 deliveries', style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 12)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Calling Raju Kumar... 📞')),
                              );
                            },
                            child: _buildIconBtn(Icons.phone, AppColors.success),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => context.go('/home/chat'),
                            child: _buildIconBtn(Icons.chat_bubble_outline, AppColors.secondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Bottom Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cancellation request sent! ❌')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        side: const BorderSide(color: AppColors.border, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: AppColors.background,
                      ),
                      child: Text('Cancel Order', style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.go('/home/chat'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        backgroundColor: AppColors.secondary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: Text('Contact Seller', style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required bool isDone,
    required bool isActive,
    required bool isLast,
    required String title,
    required String subtitle,
    required String time,
  }) {
    final Color dotColor = isDone
        ? AppColors.success
        : isActive
            ? AppColors.primary
            : AppColors.border;
    final Color titleColor = isActive ? AppColors.primary : isLast && !isDone ? AppColors.muted : AppColors.text;
    final Color subColor = isLast && !isDone ? AppColors.muted : AppColors.muted;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: dot + line
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : isDone ? AppColors.success : AppColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(color: dotColor, width: 2),
                ),
                child: Icon(icon, color: isDone || isActive ? Colors.white : AppColors.muted, size: 12),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isDone ? AppColors.success : AppColors.border,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          // Right: content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(title, style: AppTextStyles.labelMedium.copyWith(color: titleColor, fontSize: 13, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: subColor, fontSize: 11)),
                  if (time.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(time, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 10)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconBtn(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: color, size: 18),
    );
  }
}
