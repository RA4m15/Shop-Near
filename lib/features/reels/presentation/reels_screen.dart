import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/providers/reel_providers.dart';
import '../../../shared/models/reel.dart';
import 'package:video_player/video_player.dart';
// Web-only imports
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;


class ReelsScreen extends ConsumerStatefulWidget {
  const ReelsScreen({super.key});

  @override
  ConsumerState<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends ConsumerState<ReelsScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final reelsAsync = ref.watch(reelsProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: reelsAsync.when(
        data: (reels) {
          if (reels.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.video_library_outlined, size: 80, color: Colors.white54),
                  const SizedBox(height: 16),
                  Text('No reels yet', style: AppTextStyles.h2.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  Text('Be the first to post one!', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70)),
                ],
              ),
            );
          }
          
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: reels.length,
            itemBuilder: (context, index) {
              final reel = reels[index];
              return _buildReelItem(reel);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
            child: Text('Error: $err',
                style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildReelItem(Reel reel) {
    return Stack(
      children: [
        // Actual Video Player
        Positioned.fill(
          child: ReelVideoPlayer(videoUrl: reel.videoUrl, emoji: reel.emoji),
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
              _buildReelAction(
                  Icons.favorite, reel.likes.toString(), Colors.redAccent),
              const SizedBox(height: 20),
              _buildReelAction(
                  Icons.chat_bubble, reel.comments.toString(), Colors.white),
              const SizedBox(height: 20),
              _buildReelAction(Icons.share, 'Share', Colors.white),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => context.push('/home/product/${reel.sellerId}'),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Icon(Icons.shopping_bag_outlined,
                      color: Colors.white, size: 20),
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
                  CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Text(reel.emoji ?? '👤')),
                  const SizedBox(width: 10),
                  Text(reel.sellerName,
                      style: AppTextStyles.labelLarge.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w900)),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text('Follow',
                        style: AppTextStyles.labelSmall
                            .copyWith(color: Colors.white, fontSize: 10)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                reel.description,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: Colors.white, fontSize: 13, height: 1.4),
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
        Text(label,
            style: AppTextStyles.labelSmall
                .copyWith(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}

class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String? emoji;

  const ReelVideoPlayer({super.key, required this.videoUrl, this.emoji});

  @override
  State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  // Mobile only
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _error = false;

  // Web only
  late final String _viewId;

  String get _resolvedUrl {
    final videoUrl = widget.videoUrl;
    if (videoUrl.isEmpty) return '';
    final uri = Uri.tryParse(videoUrl);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      return videoUrl;
    }
    // Relative path — strip leading slash to avoid double slash
    final rel = videoUrl.startsWith('/') ? videoUrl.substring(1) : videoUrl;
    return 'http://localhost:5000/$rel';
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _viewId = 'reel-video-${widget.videoUrl.hashCode}-${DateTime.now().millisecondsSinceEpoch}';
      _registerWebVideo();
    } else {
      _initMobilePlayer();
    }
  }

  void _registerWebVideo() {
    final url = _resolvedUrl;
    if (url.isEmpty) {
      setState(() => _error = true);
      return;
    }

    final videoEl = html.VideoElement()
      ..src = url
      ..autoplay = true
      ..loop = true
      ..muted = false
      ..controls = false
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover'
      ..setAttribute('playsinline', '')
      ..setAttribute('crossorigin', 'anonymous');

    videoEl.onError.listen((_) {
      debugPrint('HTML video error for: $url');
      if (mounted) setState(() => _error = true);
    });
    videoEl.onCanPlay.listen((_) {
      videoEl.play();
    });

    ui.platformViewRegistry.registerViewFactory(_viewId, (int id) => videoEl);
    setState(() {});
  }

  Future<void> _initMobilePlayer() async {
    final url = _resolvedUrl;
    if (url.isEmpty) {
      setState(() => _error = true);
      return;
    }
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    try {
      await _controller!.initialize();
      _controller!.setLooping(true);
      _controller!.play();
      if (mounted) setState(() => _initialized = true);
    } catch (e) {
      debugPrint('VideoPlayer error: $e | URL: $url');
      if (mounted) setState(() => _error = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final url = _resolvedUrl;

    if (_error || url.isEmpty) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2B1B54), Color(0xFF1A1D2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: Text(widget.emoji ?? '🎬', style: const TextStyle(fontSize: 140)),
      );
    }

    if (kIsWeb) {
      return HtmlElementView(viewType: _viewId);
    }

    if (!_initialized || _controller == null) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    return GestureDetector(
      onTap: () {
        if (_controller!.value.isPlaying) {
          _controller!.pause();
        } else {
          _controller!.play();
        }
      },
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: VideoPlayer(_controller!),
          ),
        ),
      ),
    );
  }
}

