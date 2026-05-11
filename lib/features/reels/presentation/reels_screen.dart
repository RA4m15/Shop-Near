import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _reels = [
    {
      'seller': 'Priya Fashion',
      'desc': 'Authentic Chanderi Saree demo! Check the gold zari work. 😍 #Handloom #Saree',
      'likes': '2.4k',
      'comments': '156',
      'emoji': '👗',
      'color': const Color(0xFF2B1B54),
    },
    {
      'seller': 'Indore Handcrafts',
      'desc': 'New wooden home decor collection. Hand-carved by local artisans. #Decor #Art',
      'likes': '1.1k',
      'comments': '42',
      'emoji': '🪵',
      'color': const Color(0xFF1B4D54),
    },
    {
      'seller': 'Ethnic Wear',
      'desc': 'Bridal Lehenga collection 2024. Pre-order now! 💍 #Wedding #Lehenga',
      'likes': '5.2k',
      'comments': '890',
      'emoji': '👘',
      'color': const Color(0xFF541B2B),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _reels.length,
        itemBuilder: (context, index) {
          final reel = _reels[index];
          return _buildReelItem(reel);
        },
      ),
    );
  }

  Widget _buildReelItem(Map<String, dynamic> reel) {
    return Stack(
      children: [
        // Video Placeholder
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [reel['color'], reel['color'].withOpacity(0.5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: Text(reel['emoji'], style: const TextStyle(fontSize: 140)),
        ),
        
        // Dark Overlay at Bottom
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 1.0],
              ),
            ),
          ),
        ),

        // Right Side Actions
        Positioned(
          right: 16,
          bottom: 120,
          child: Column(
            children: [
              _buildReelAction(Icons.favorite, reel['likes'], Colors.redAccent),
              const SizedBox(height: 20),
              _buildReelAction(Icons.chat_bubble, reel['comments'], Colors.white),
              const SizedBox(height: 20),
              _buildReelAction(Icons.share, 'Share', Colors.white),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => context.push('/home/product/1'),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),

        // Bottom Info
        Positioned(
          left: 16,
          right: 80,
          bottom: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Text('👗')),
                  const SizedBox(width: 10),
                  Text(reel['seller'], style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w900)),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                    child: Text('Follow', style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontSize: 10)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                reel['desc'],
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontSize: 13, height: 1.4),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReelAction(IconData icon, String label, Color col) {
    return Column(
      children: [
        Icon(icon, color: col, size: 30),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}
