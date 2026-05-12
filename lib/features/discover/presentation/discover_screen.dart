import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/providers/seller_providers.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch(String query) {
    if (query.trim().isNotEmpty) {
      context.push('/home/discover/${query.trim()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sellersAsync = ref.watch(sellersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Discover', style: AppTextStyles.h3),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.text, size: 24),
            onPressed: () => context.go('/home'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.muted, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: _handleSearch,
                        decoration: InputDecoration(
                          hintText: 'Search products, sellers, categories...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.muted, fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Text('BROWSE CATEGORIES', style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 2.8,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildCatCard(context, '👗', 'Fashion', const [Color(0xFFf093fb), Color(0xFFf5576c)]),
                _buildCatCard(context, '🌿', 'Organic', const [Color(0xFF4facfe), Color(0xFF00f2fe)]),
                _buildCatCard(context, '🍕', 'Food & Snacks', const [Color(0xFF43e97b), Color(0xFF38f9d7)]),
                _buildCatCard(context, '💍', 'Jewellery', const [Color(0xFFfa709a), Color(0xFFfee140)]),
                _buildCatCard(context, '🎨', 'Handicraft', const [Color(0xFFa18cd1), Color(0xFFfbc2eb)]),
                _buildCatCard(context, '📱', 'Electronics', const [Color(0xFFfda085), Color(0xFFf6d365)]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Text('TRENDING SEARCHES', style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildChip(context, 'Silk Saree'), _buildChip(context, 'Organic Ghee'),
                  _buildChip(context, 'Madhubani Art'), _buildChip(context, 'Silver Jewellery'),
                  _buildChip(context, 'Poha'), _buildChip(context, 'Handloom Dupatta'),
                  _buildChip(context, 'Pottery'), _buildChip(context, 'Home Pickles'),
                  _buildChip(context, 'Beeswax Candles'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Text('TOP SELLERS NEAR YOU', style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: sellersAsync.when(
                data: (sellers) => Column(
                  children: sellers.map((seller) => _buildSellerItem(
                    context, 
                    seller.avatarPlaceholder, 
                    seller.name, 
                    '${seller.handle} · ${seller.location}', 
                    false,
                  )).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Text('Error: $err'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCatCard(BuildContext context, String emoji, String title, List<Color> gradient) {
    return GestureDetector(
      onTap: () => context.push('/home/discover/$title'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800))),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String text) {
    return GestureDetector(
      onTap: () => context.push('/home/discover/$text'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: AppTextStyles.labelSmall.copyWith(fontSize: 12, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildSellerItem(BuildContext context, String emoji, String name, String preview, bool following) {
    return GestureDetector(
      onTap: () => context.go('/home/shop/1'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFFFFECD2), Color(0xFFFCB69F)]),
              ),
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 22)),
                  if (following)
                    Positioned(
                      bottom: -4,
                      right: -4,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.labelLarge.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 1),
                  Text(preview, style: AppTextStyles.bodySmall.copyWith(fontSize: 12, color: AppColors.muted), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(following ? 'Unfollowed $name' : 'Following $name! ✨')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: following ? AppColors.primary : AppColors.background,
                  border: Border.all(color: following ? AppColors.primary : AppColors.border, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  following ? 'Following' : 'Follow',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: following ? Colors.white : AppColors.text,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
