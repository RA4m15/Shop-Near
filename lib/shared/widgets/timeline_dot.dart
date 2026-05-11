import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum TimelineStatus { done, active, pending }

class TimelineDot extends StatelessWidget {
  final TimelineStatus status;
  final IconData? icon;

  const TimelineDot({super.key, required this.status, this.icon});

  @override
  Widget build(BuildContext context) {
    if (status == TimelineStatus.done) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(icon ?? Icons.check, color: Colors.white, size: 10),
      );
    } else if (status == TimelineStatus.active) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              spreadRadius: 4,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon ?? Icons.circle, color: Colors.white, size: 10),
      );
    } else {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(color: AppColors.border, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(icon ?? Icons.circle, color: AppColors.muted, size: 10),
      );
    }
  }
}
