import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class StoryRing extends StatefulWidget {
  final String avatarPlaceholder;
  final String name;
  final bool seen;
  final VoidCallback onTap;

  const StoryRing({
    super.key,
    required this.avatarPlaceholder,
    required this.name,
    this.seen = false,
    required this.onTap,
  });

  @override
  State<StoryRing> createState() => _StoryRingState();
}

class _StoryRingState extends State<StoryRing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 66,
                height: 66,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: widget.seen
                      ? const LinearGradient(colors: [AppColors.border, AppColors.border])
                      : SweepGradient(
                          colors: const [AppColors.primary, AppColors.accent, AppColors.primary],
                          transform: GradientRotation(_controller.value * 2 * 3.14159),
                        ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text(widget.avatarPlaceholder, style: const TextStyle(fontSize: 24)),
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 70,
            child: Text(
              widget.name,
              style: AppTextStyles.labelSmall.copyWith(color: AppColors.text, fontSize: 11, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
