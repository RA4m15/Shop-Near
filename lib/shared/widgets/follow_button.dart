import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onTap;

  const FollowButton({super.key, required this.isFollowing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isFollowing ? const Color(0xFFDCFCE7) : AppColors.background,
          border: Border.all(
            color: isFollowing ? const Color(0xFF86EFAC) : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          isFollowing ? 'Following' : 'Follow',
          style: AppTextStyles.labelSmall.copyWith(
            color: isFollowing ? const Color(0xFF166534) : AppColors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
