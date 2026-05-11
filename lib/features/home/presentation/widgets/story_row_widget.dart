import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/story_ring.dart';
import '../../../../data/mock/mock_data.dart';

class StoryRowWidget extends StatelessWidget {
  const StoryRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          ...MockData.sellers.map((seller) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: StoryRing(
                avatarPlaceholder: seller.avatarPlaceholder,
                name: seller.name,
                seen: seller.id == 's3', // Just mocking some seen state
                onTap: () => context.push('/home/live'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
