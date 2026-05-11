import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/product_card.dart';
import '../../../../data/mock/mock_data.dart';

class ProductGridWidget extends StatelessWidget {
  final String category;
  const ProductGridWidget({super.key, this.category = 'All'});

  @override
  Widget build(BuildContext context) {
    var products = MockData.products;
    
    // Proper category filtering
    if (category != 'All') {
      products = products.where((p) => p.category == category).toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onTap: () => context.push('/home/product/${product.id}'),
          );
        },
      ),
    );
  }
}
