import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'My Cart ',
            style: AppTextStyles.h3.copyWith(color: AppColors.text, fontSize: 18),
            children: [
              TextSpan(text: '(3)', style: AppTextStyles.labelMedium.copyWith(color: AppColors.muted, fontSize: 14)),
            ],
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text, size: 20),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text('Clear', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            _buildCartItem('👗', 'Silk Saree Blue', 'Priya Fashion', '₹1,299', '1', const [Color(0xFFFFECD2), Color(0xFFFCB69F)]),
            _buildCartItem('🌿', 'Organic Ghee 500g', 'Green Bazaar', '₹900 (×2)', '2', const [Color(0xFFA8EDEA), Color(0xFFFED6E3)]),
            
            // Promo Box
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_offer, color: AppColors.primary, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter promo code (try: LOCAL10)',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.muted, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: AppTextStyles.labelSmall.copyWith(fontSize: 13),
                      ),
                    ),
                    Text('Apply', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ),
            
            // Summary Box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary', style: AppTextStyles.labelLarge.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Subtotal (3 items)', '₹2,199', false),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Delivery charge', 'FREE 🎉', true),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Promo (LOCAL10)', '−₹220', true),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, color: AppColors.border),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Payable', style: AppTextStyles.labelMedium.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                      Text('₹1,979', style: AppTextStyles.h2.copyWith(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ],
              ),
            ),
            
            // Payment Methods
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Payment Method', style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildPaymentMethod('📱', 'UPI', true)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildPaymentMethod('💳', 'Card', false)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildPaymentMethod('💵', 'COD', false)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildPaymentMethod('🏦', 'Netbank', false)),
                    ],
                  ),
                ],
              ),
            ),
            
            // Place Order Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/home/order-track'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text('Place Order · ₹1,979 →', style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(String emoji, String name, String shop, String price, String qty, List<Color> gradient) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: gradient),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.labelLarge.copyWith(fontSize: 14, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(shop, style: AppTextStyles.bodySmall.copyWith(fontSize: 12, color: AppColors.muted)),
                const SizedBox(height: 4),
                Text(price, style: AppTextStyles.labelMedium.copyWith(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                _buildQtyBtn('−', AppColors.background, AppColors.text),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(qty, style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
                ),
                _buildQtyBtn('+', AppColors.primary, Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(String text, Color bgColor, Color textColor) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isSuccess) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.muted, fontSize: 13)),
        Text(value, style: AppTextStyles.labelSmall.copyWith(color: isSuccess ? AppColors.success : AppColors.text, fontSize: 13, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _buildPaymentMethod(String emoji, String name, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary.withOpacity(0.1) : AppColors.background,
        border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 2 : 1),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(name, style: AppTextStyles.labelSmall.copyWith(fontSize: 11, fontWeight: FontWeight.w800, color: selected ? AppColors.primary : AppColors.text)),
        ],
      ),
    );
  }
}
