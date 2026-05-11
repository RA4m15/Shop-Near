import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
            style: AppTextStyles.h3.copyWith(fontSize: 18)),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text, size: 20),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text('Mark All Read',
                  style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildNotif(
            context,
            icon: '🔴',
            title: 'Priya Fashion just went ',
            bold: 'LIVE!',
            tail: ' 342 people watching sarees demo',
            time: '2 min ago',
            unread: true,
            onTap: () => context.push('/home/live'),
          ),
          _buildNotif(
            context,
            icon: '📦',
            title: 'Your order #BL2048 is ',
            bold: 'out for delivery',
            tail: '! Expected in 18 min',
            time: '1 hour ago',
            unread: true,
            onTap: () => context.push('/home/order-track'),
          ),
          _buildNotif(
            context,
            icon: '💬',
            title:
                'Green Bazaar replied: "Yes, COD available for Indore area!"',
            bold: '',
            tail: '',
            time: '2 hours ago',
            unread: true,
            onTap: () => context.go('/home/chat'),
          ),
          _buildNotif(
            context,
            icon: '🏆',
            title: 'You earned ',
            bold: 'Loyal Buyer',
            tail: ' badge! Keep supporting local sellers 🎉',
            time: 'Yesterday',
            unread: false,
            onTap: () {},
          ),
          _buildNotif(
            context,
            icon: '🌟',
            title:
                'CraftHub MP posted new Madhubani art collection. Check it out!',
            bold: '',
            tail: '',
            time: 'Yesterday',
            unread: false,
            onTap: () {},
          ),
          _buildNotif(
            context,
            icon: '🎁',
            title:
                'You have 1,240 loyalty points! Redeem for discount on next order',
            bold: '',
            tail: '',
            time: '2 days ago',
            unread: false,
            onTap: () {},
          ),
          _buildNotif(
            context,
            icon: '💰',
            title:
                'Flash sale alert! 40% off on Handloom Sarees. Ends in 2 hours!',
            bold: '',
            tail: '',
            time: '3 days ago',
            unread: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotif(
    BuildContext context, {
    required String icon,
    required String title,
    required String bold,
    required String tail,
    required String time,
    required bool unread,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color:
              unread ? AppColors.primary.withOpacity(0.04) : Colors.transparent,
          border: const Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(icon, style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: title,
                      style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.text, fontSize: 13, height: 1.5),
                      children: bold.isNotEmpty
                          ? [
                              TextSpan(
                                  text: bold,
                                  style: AppTextStyles.labelSmall.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.text)),
                              TextSpan(
                                  text: tail,
                                  style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.text,
                                      fontSize: 13,
                                      height: 1.5)),
                            ]
                          : null,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(time,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.muted, fontSize: 11)),
                ],
              ),
            ),
            if (unread)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
              ),
          ],
        ),
      ),
    );
  }
}
