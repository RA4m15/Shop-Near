import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        title: Text('Orders', style: AppTextStyles.h3),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.muted,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'All (18)'),
            Tab(text: 'Pending (4)'),
            Tab(text: 'Processing (6)'),
            Tab(text: 'Delivered (7)'),
            Tab(text: 'Cancelled (1)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(),
          _buildOrderList(),
          _buildOrderList(),
          _buildOrderList(),
          _buildOrderList(),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
          child: Text('TODAY — 11 May 2026', style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted, fontSize: 11, fontWeight: FontWeight.w800)),
        ),
        _buildOrderCard('👗', 'Silk Saree Blue', '#BL2048', 'Anjali S. · ₹1,299 · COD', '2.3km · 12 min ago', 'Pending', const Color(0xFFFEF3C7), const Color(0xFF92400E), showAccept: true),
        _buildOrderCard('🧣', 'Banarasi Dupatta', '#BL2047', 'Meena R. · ₹850 · UPI ✅', '4.1km · 1 hr ago', 'Packing', const Color(0xFFDBEAFE), const Color(0xFF1E40AF)),
        _buildOrderCard('👘', 'Cotton Kurti Set', '#BL2046', 'Kavita D. · ₹699 · UPI ✅', '1.8km · 2 hr ago', 'Delivered', const Color(0xFFDCFCE7), const Color(0xFF166534)),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
          child: Text('YESTERDAY — 10 May 2026', style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted, fontSize: 11, fontWeight: FontWeight.w800)),
        ),
        _buildOrderCard('🥻', 'Designer Lehenga', '#BL2041', 'Pooja K. · ₹3,200 · Card ✅', null, 'Delivered', const Color(0xFFDCFCE7), const Color(0xFF166534)),
        _buildOrderCard('🥻', 'Chanderi Saree Pink', '#BL2038', 'Ritu M. · ₹1,099 · COD', null, 'Cancelled', const Color(0xFFFEE2E2), const Color(0xFFB91C1C)),
      ],
    );
  }

  Widget _buildOrderCard(String icon, String name, String orderId, String buyerDetails, String? distance, String status, Color statusBg, Color statusText, {bool showAccept = false}) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order details for $orderId coming soon!')),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(icon, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '$name ',
                      style: AppTextStyles.labelLarge.copyWith(color: AppColors.text),
                      children: [
                        TextSpan(text: orderId, style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted, fontSize: 10)),
                      ],
                    ),
                  ),
                  Text(buyerDetails, style: AppTextStyles.bodySmall),
                  if (distance != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, color: AppColors.primary, size: 10),
                          const SizedBox(width: 4),
                          Text(distance, style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted, fontSize: 10)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: AppTextStyles.labelSmall.copyWith(color: statusText, fontWeight: FontWeight.w800, fontSize: 11),
                  ),
                ),
                if (showAccept)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Order $orderId accepted! 📦'), backgroundColor: AppColors.success),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          border: Border.all(color: AppColors.secondary, width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Accept',
                          style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w800, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
