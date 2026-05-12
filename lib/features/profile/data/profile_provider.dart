import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileData {
  final String name;
  final String username;
  final String bio;
  final String location;
  final String phone;
  final String avatar;

  const ProfileData({
    this.name = 'Anjali Sharma',
    this.username = 'anjali_buys',
    this.bio = 'Local shopping enthusiast 🛍️ Supporting local sellers of MP ❤️ Trust local, buy local!',
    this.location = 'Indore, MP',
    this.phone = '+91 98765 43210',
    this.avatar = '😊',
  });

  ProfileData copyWith({
    String? name,
    String? username,
    String? bio,
    String? location,
    String? phone,
    String? avatar,
  }) {
    return ProfileData(
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileData> {
  ProfileNotifier() : super(const ProfileData());

  void updateProfile({
    String? name,
    String? username,
    String? bio,
    String? location,
    String? phone,
    String? avatar,
  }) {
    state = state.copyWith(
      name: name,
      username: username,
      bio: bio,
      location: location,
      phone: phone,
      avatar: avatar,
    );
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileData>(
  (ref) => ProfileNotifier(),
);
