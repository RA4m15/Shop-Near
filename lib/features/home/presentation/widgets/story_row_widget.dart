import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/story_ring.dart';
import '../../../../shared/providers/seller_providers.dart';

class StoryRowWidget extends ConsumerWidget {
  const StoryRowWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellersAsync = ref.watch(sellersProvider);

    return sellersAsync.when(
      data: (sellers) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryRing(
            avatarPlaceholder: '+',
            name: 'Your Story',
            seen: true,
            onTap: () {},
          ),
          const SizedBox(width: 10),
          ...sellers.map((seller) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: StoryRing(
                avatarPlaceholder: seller.avatarPlaceholder,
                name: seller.name,
                seen: false,
                onTap: () {},
              ),
            );
          }),
        ],
      ),
    ),
      loading: () => const SizedBox(height: 100),
      error: (_, __) => const SizedBox(),
    );
  }
}
