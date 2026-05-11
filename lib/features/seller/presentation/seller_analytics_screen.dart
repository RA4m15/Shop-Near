import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/section_header.dart';

class SellerAnalyticsScreen extends StatelessWidget {
  const SellerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics & Insights', style: AppTextStyles.h3),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPeriodSelector(),
            _buildSummaryGrid(),
            const SectionHeader(title: '📈 Sales Trend'),
            _buildSalesChart(),
            const SectionHeader(title: '🏆 Top Selling Products'),
            _buildTopProducts(),
            const SectionHeader(title: '📡 Live Session Stats'),
            _buildLiveStats(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: ['Week', 'Month', 'Year'].map((p) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: p == 'Month' ? AppColors.primary : AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: p == 'Month' ? AppColors.primary : AppColors.border),
            ),
            alignment: Alignment.center,
            child: Text(
              p,
              style: AppTextStyles.labelMedium.copyWith(color: p == 'Month' ? Colors.white : AppColors.text),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSummaryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildMetricCard('Total Sales', '₹48,290', '+12%', true)),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('Orders', '142', '+5%', true)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Conversion', '4.2%', '-1%', false)),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('Avg. Order', '₹340', '+8%', true)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String trend, bool positive) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: AppTextStyles.h3),
              Text(
                trend,
                style: AppTextStyles.labelSmall.copyWith(color: positive ? AppColors.success : AppColors.danger),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalesChart() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(12, (index) {
          final h = 0.2 + (0.7 * (index % 5) / 5);
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 150 * h,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(index == 10 ? 1 : 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTopProducts() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildTopProductItem('1', '👗', 'Silk Saree Blue', '62 sold', '₹80,538', const Color(0xFFFEF3C7), const Color(0xFF92400E)),
          const Divider(color: AppColors.border),
          _buildTopProductItem('2', '👘', 'Cotton Kurti Set', '45 sold', '₹31,455', const Color(0xFFDBEAFE), const Color(0xFF1E40AF)),
          const Divider(color: AppColors.border),
          _buildTopProductItem('3', '🧣', 'Banarasi Dupatta', '28 sold', '₹23,800', const Color(0xFFDCFCE7), const Color(0xFF166534)),
        ],
      ),
    );
  }

  Widget _buildTopProductItem(String rank, String emoji, String name, String sold, String rev, Color rankBg, Color rankText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(color: rankBg, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Text(rank, style: AppTextStyles.labelSmall.copyWith(color: rankText, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.labelMedium),
                Text(sold, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11)),
              ],
            ),
          ),
          Text(rev, style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildLiveStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildStatRow('Sessions this week', '7 sessions'),
          _buildStatRow('Avg viewers', '247'),
          _buildStatRow('Avg session duration', '42 min'),
          _buildStatRow('Orders from live', '68 (46%)', valueColor: AppColors.success),
          _buildStatRow('Conversion rate', '7.3%', valueColor: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted)),
          Text(value, style: AppTextStyles.labelMedium.copyWith(color: valueColor ?? AppColors.text)),
        ],
      ),
    );
  }
}
