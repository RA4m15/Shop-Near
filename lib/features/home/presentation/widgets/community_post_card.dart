import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CommunityPostCard extends StatefulWidget {
  const CommunityPostCard({super.key});

  @override
  State<CommunityPostCard> createState() => _CommunityPostCardState();
}

class _CommunityPostCardState extends State<CommunityPostCard> {
  bool _isLiked = false;
  int _likesCount = 234;
  bool _isSaved = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _isLiked ? _likesCount++ : _likesCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Color(0xFFFFECD2), Color(0xFFFCB69F)]),
                  ),
                  alignment: Alignment.center,
                  child: const Text('👗', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Priya Fashion', style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w800)),
                      Text('2 hours ago · Indore', style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Following Priya Fashion! ✨')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border.all(color: AppColors.border, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Follow', style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
            child: Text(
              'New collection just arrived! Beautiful handwoven sarees from local weavers 🌸 #LocalLove #Handloom #IndoriStyle',
              style: AppTextStyles.bodySmall,
            ),
          ),
          Container(
            height: 230,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFFFECD2), Color(0xFFFCB69F)]),
            ),
            alignment: Alignment.center,
            child: const Text('🛍️', style: TextStyle(fontSize: 64)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                _buildActionItem(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  count: _likesCount.toString(),
                  color: _isLiked ? AppColors.primary : AppColors.muted,
                  onTap: _toggleLike,
                ),
                const SizedBox(width: 14),
                _buildActionItem(
                  icon: Icons.chat_bubble_outline,
                  count: '42',
                  color: AppColors.muted,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Comment section opening... 💬')),
                    );
                  },
                ),
                const SizedBox(width: 14),
                _buildActionItem(
                  icon: Icons.share_outlined,
                  count: '18',
                  color: AppColors.muted,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Post link copied! 🔗')),
                    );
                  },
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border, color: _isSaved ? AppColors.secondary : AppColors.muted, size: 22),
                  onPressed: () {
                    setState(() => _isSaved = !_isSaved);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({required IconData icon, required String count, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 6),
          Text(count, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
