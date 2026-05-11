import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SellerProductsScreen extends StatefulWidget {
  const SellerProductsScreen({super.key});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products', style: AppTextStyles.h3),
        actions: [
          IconButton(
            onPressed: () => context.push('/seller/products/add'),
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.muted),
                        prefixIcon: const Icon(Icons.search, color: AppColors.muted),
                        filled: true,
                        fillColor: AppColors.card.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.muted,
                labelStyle: AppTextStyles.labelMedium,
                tabs: const [
                  Tab(text: 'All (12)'),
                  Tab(text: 'Active (9)'),
                  Tab(text: 'Draft (2)'),
                  Tab(text: 'Out of Stock (1)'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProductList(),
          _buildProductList(), // Placeholders for other tabs
          _buildProductList(),
          _buildProductList(),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    List<Widget> products = [
      _buildProductItem('👗', 'Silk Banarasi Saree — Blue', 'Stock: 14 · ⭐ 4.8 (234)', '₹1,299'),
      _buildProductItem('👘', 'Cotton Kurti Set — Floral', 'Stock: 28 · ⭐ 4.6 (108)', '₹699'),
      _buildProductItem('🧣', 'Banarasi Dupatta — Gold', 'Stock: 8 · ⭐ 4.9 (67)', '₹850'),
      _buildProductItem('🎀', 'Designer Lehenga — Draft', 'Not published yet', '₹3,200', isDraft: true),
      _buildProductItem('🥻', 'Chanderi Saree — Pink', 'Stock: 5 · ⭐ 4.7 (42)', '₹1,099'),
      _buildProductItem('🧶', 'Woolen Shawl — Kashida', '⚠ Out of Stock', '₹1,800', isOutOfStock: true),
    ];

    // Simple filtering logic for demonstration
    if (_tabController.index == 1) { // Active
      products = products.where((w) {
        final p = w as GestureDetector;
        final container = p.child as Container;
        // This is a bit hacky since we are using static widgets, 
        // in a real app we would filter the data list first.
        return !p.toString().contains('Draft') && !p.toString().contains('Out of Stock');
      }).toList();
      // Since the above hacky filter might not work well with wrapped widgets, 
      // let's just manually define lists for this mockup.
      products = [
        _buildProductItem('👗', 'Silk Banarasi Saree — Blue', 'Stock: 14 · ⭐ 4.8 (234)', '₹1,299'),
        _buildProductItem('👘', 'Cotton Kurti Set — Floral', 'Stock: 28 · ⭐ 4.6 (108)', '₹699'),
        _buildProductItem('🧣', 'Banarasi Dupatta — Gold', 'Stock: 8 · ⭐ 4.9 (67)', '₹850'),
        _buildProductItem('🥻', 'Chanderi Saree — Pink', 'Stock: 5 · ⭐ 4.7 (42)', '₹1,099'),
      ];
    } else if (_tabController.index == 2) { // Draft
      products = [
        _buildProductItem('🎀', 'Designer Lehenga — Draft', 'Not published yet', '₹3,200', isDraft: true),
      ];
    } else if (_tabController.index == 3) { // Out of Stock
      products = [
        _buildProductItem('🧶', 'Woolen Shawl — Kashida', '⚠ Out of Stock', '₹1,800', isOutOfStock: true),
      ];
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: products,
    );
  }

  Widget _buildProductItem(String icon, String name, String meta, String price, {bool isDraft = false, bool isOutOfStock = false}) {
    return GestureDetector(
      onTap: () => context.push('/home/product/1'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isOutOfStock ? const Color(0xFFFFF5F5) : (isDraft ? AppColors.background : AppColors.card),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isOutOfStock ? const Color(0xFFFCA5A5) : AppColors.border,
            width: isDraft ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'product_img_${name.hashCode}',
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isDraft ? AppColors.border : AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(icon, style: const TextStyle(fontSize: 28, decoration: TextDecoration.none)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.labelLarge.copyWith(color: isDraft ? AppColors.muted : AppColors.text)),
                  Text(
                    meta,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isOutOfStock ? AppColors.danger : AppColors.muted,
                    ),
                  ),
                  Text(price, style: AppTextStyles.h4.copyWith(color: isDraft ? AppColors.muted : AppColors.text)),
                ],
              ),
            ),
            Column(
              children: [
                if (isDraft)
                  Row(
                    children: [
                      _buildActionBtn('Edit', Icons.edit_outlined, AppColors.secondary, () => context.push('/seller/products/add')),
                      const SizedBox(width: 4),
                      _buildActionBtn('Upload', Icons.cloud_upload_outlined, AppColors.success, () {}, bg: const Color(0xFFDCFCE7), border: const Color(0xFF86EFAC)),
                    ],
                  )
                else if (isOutOfStock)
                  Row(
                    children: [
                      _buildActionBtn('Edit', Icons.edit_outlined, AppColors.secondary, () => context.push('/seller/products/add')),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Restock successful!')),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBEAFE),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFBFDBFE)),
                          ),
                          child: Text(
                            'Restock',
                            style: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF1E40AF), fontSize: 11, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      _buildActionBtn('Edit', Icons.edit_outlined, AppColors.secondary, () => context.push('/seller/products/add')),
                      const SizedBox(width: 4),
                      _buildActionBtn('Delete', Icons.delete_outline, AppColors.primary, () {}),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(String action, IconData icon, Color color, VoidCallback onTap, {Color? bg, Color? border}) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$action successful!')),
            );
            onTap();
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: bg ?? Colors.transparent,
              border: Border.all(color: border ?? AppColors.border, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
        );
      }
    );
  }
}
