import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/live_badge.dart';

class LiveSessionScreen extends StatefulWidget {
  const LiveSessionScreen({super.key});

  @override
  State<LiveSessionScreen> createState() => _LiveSessionScreenState();
}

class _LiveSessionScreenState extends State<LiveSessionScreen> with TickerProviderStateMixin {
  final List<Widget> _floatingHearts = [];
  final math.Random _random = math.Random();
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _chatMessages = [
    {'user': 'Anjali', 'msg': 'Love this collection! 😍'},
    {'user': 'Rohit K', 'msg': 'What\'s the price for blue one?'},
    {'user': 'Priya', 'msg': '₹1,299 only! Limited stock!', 'isSeller': true},
    {'user': 'Meena', 'msg': 'Can I get COD option? 🙏'},
  ];

  void _addHeart(String emoji) {
    setState(() {
      _floatingHearts.add(
        _FloatingHeart(
          key: UniqueKey(),
          emoji: emoji,
          onComplete: (key) {
            setState(() {
              _floatingHearts.removeWhere((element) => element.key == key);
            });
          },
        ),
      );
    });
  }

  void _sendChatMessage() {
    if (_chatController.text.trim().isEmpty) return;
    setState(() {
      _chatMessages.add({
        'user': 'You',
        'msg': _chatController.text.trim(),
      });
      _chatController.clear();
    });
    // Auto scroll
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video background placeholder
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2B1B54), Color(0xFFEE7B9D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text('👗', style: TextStyle(fontSize: 120, color: Colors.white54)),
              ),
            ),
          ),

          // Floating Hearts Layer
          ..._floatingHearts,
          
          // Header
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/home');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 16, backgroundColor: Colors.white, child: Text('👗')),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Priya Fashion', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                          Text('1.2k viewers', style: AppTextStyles.labelSmall.copyWith(color: Colors.white70)),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(16)),
                        child: Text('Follow', style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const LiveBadge(pulse: true),
              ],
            ),
          ),
          
          // Reactions Side
          Positioned(
            right: 14,
            bottom: 250,
            child: Column(
              children: [
                _buildReactBtn('❤️'),
                const SizedBox(height: 10),
                _buildReactBtn('🔥'),
                const SizedBox(height: 10),
                _buildReactBtn('👏'),
                const SizedBox(height: 10),
                _buildReactBtn('😍'),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => context.push('/home/cart'),
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          
          // Chat Area
          Positioned(
            bottom: 210,
            left: 14,
            right: 70,
            height: 160,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chatMessages.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final chat = _chatMessages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: _buildChatBubble(chat['user'], chat['msg'], isSeller: chat['isSeller'] ?? false),
                );
              },
            ),
          ),
          
          // Live Product Bar
          Positioned(
            bottom: 136,
            left: 14,
            right: 70,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [Color(0xFFFFECD2), Color(0xFFFCB69F)]),
                    ),
                    alignment: Alignment.center,
                    child: const Text('👗', style: TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Silk Saree — Royal Blue', style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
                        Text('₹1,299', style: AppTextStyles.labelMedium.copyWith(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/home/cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size.zero,
                    ),
                    child: Text('Buy Now', style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
          ),
          
          // Live Input Area
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 28),
              color: Colors.black.withOpacity(0.65),
              child: Row(
                children: [
                  const Text('🎁', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.14),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _chatController,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Say something...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withOpacity(0.45), fontSize: 13),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _sendChatMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendChatMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.send, color: Colors.white, size: 16),
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

  Widget _buildReactBtn(String emoji) {
    return GestureDetector(
      onTap: () => _addHeart(emoji),
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          border: Border.all(color: Colors.white.withOpacity(0.25)),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(emoji, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildChatBubble(String user, String msg, {bool isSeller = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        text: TextSpan(
          text: '$user: ',
          style: AppTextStyles.labelMedium.copyWith(color: isSeller ? AppColors.accent : Colors.white, fontSize: 12, fontWeight: FontWeight.w800),
          children: [
            TextSpan(text: msg, style: AppTextStyles.bodySmall.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

class _FloatingHeart extends StatefulWidget {
  final String emoji;
  final Function(Key?) onComplete;

  const _FloatingHeart({super.key, required this.emoji, required this.onComplete});

  @override
  State<_FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<_FloatingHeart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _left;
  late double _size;

  @override
  void initState() {
    super.initState();
    _left = 150 + math.Random().nextDouble() * 200;
    _size = 20 + math.Random().nextDouble() * 15;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..forward().then((_) => widget.onComplete(widget.key));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double progress = _controller.value;
        final double y = 400 * progress;
        final double x = 50 * math.sin(progress * 2 * math.pi);
        final double opacity = 1 - progress;

        return Positioned(
          bottom: 100 + y,
          left: _left + x,
          child: Opacity(
            opacity: opacity,
            child: Text(widget.emoji, style: TextStyle(fontSize: _size)),
          ),
        );
      },
    );
  }
}
