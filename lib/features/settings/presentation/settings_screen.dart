import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/providers/user_providers.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../data/repositories/auth_repository.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Local toggle states (initialized from server data)
  bool _liveSessionAlerts = true;
  bool _orderUpdates = true;
  bool _offersDeals = true;
  bool _chatMessages = false;
  bool _biometricLogin = true;
  bool _publicProfile = true;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyles.h3.copyWith(fontSize: 18)),
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
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.danger),
              const SizedBox(height: 16),
              Text('Failed to load settings', style: AppTextStyles.labelMedium),
              const SizedBox(height: 8),
              Text(err.toString(), style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(userProfileProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (user) {
          // Initialize local toggle states from server data once
          if (!_initialized) {
            _liveSessionAlerts = user.settings.liveSessionAlerts;
            _orderUpdates = user.settings.orderUpdates;
            _offersDeals = user.settings.offersDeals;
            _chatMessages = user.settings.chatMessages;
            _biometricLogin = user.settings.biometricLogin;
            _publicProfile = user.settings.publicProfile;
            _initialized = true;
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // ── Profile Row ──
                GestureDetector(
                  onTap: () => context.push('/home/profile/edit'),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.card,
                    child: Row(
                      children: [
                        Container(
                          width: 56, height: 56,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [Color(0xFFf093fb), Color(0xFFf5576c)]),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            user.avatar != null && user.avatar!.isNotEmpty ? '😊' : '😊',
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name, style: AppTextStyles.labelLarge.copyWith(fontSize: 15, fontWeight: FontWeight.w900)),
                              Text(
                                '@${user.handle ?? 'user'} · ${_getTierLabel()} Member',
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.muted),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // ── ACCOUNT ──
                _buildSection('ACCOUNT', [
                  _buildSettingsItem(Icons.person, const Color(0xFFFFF0F3), AppColors.primary, 'Edit Profile', 'Name, photo, bio, location', () {
                    context.push('/home/profile/edit');
                  }),
                  _buildSettingsItem(Icons.phone, const Color(0xFFEFF6FF), AppColors.secondary, 'Phone & Email', '${user.phone ?? 'Not set'} · ${user.email}', () {
                    _showPhoneEmailDialog(user.phone ?? '', user.email);
                  }),
                  _buildSettingsItem(Icons.location_on, const Color(0xFFECFDF5), AppColors.success, 'Location', user.location ?? 'Not set', () {
                    _showEditFieldDialog('Location', user.location ?? '', 'location');
                  }),
                  _buildSettingsItem(Icons.credit_card, const Color(0xFFFFF9EC), AppColors.accent, 'Payment Methods', 'Manage payment options', () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment methods coming soon! 💳')),
                    );
                  }),
                ]),

                const SizedBox(height: 8),

                // ── NOTIFICATIONS ──
                _buildSection('NOTIFICATIONS', [
                  _buildToggleItem(Icons.live_tv, const Color(0xFFFFF0F3), AppColors.live, 'Live Session Alerts', 'When sellers you follow go live', _liveSessionAlerts, (val) {
                    setState(() => _liveSessionAlerts = val);
                    _updateSetting('liveSessionAlerts', val);
                  }),
                  _buildToggleItem(Icons.shopping_bag, const Color(0xFFECFDF5), AppColors.success, 'Order Updates', 'Dispatch, delivery notifications', _orderUpdates, (val) {
                    setState(() => _orderUpdates = val);
                    _updateSetting('orderUpdates', val);
                  }),
                  _buildToggleItem(Icons.local_offer, const Color(0xFFFFF9EC), AppColors.accent, 'Offers & Deals', 'Flash sales, promo codes', _offersDeals, (val) {
                    setState(() => _offersDeals = val);
                    _updateSetting('offersDeals', val);
                  }),
                  _buildToggleItem(Icons.chat_bubble, const Color(0xFFEFF6FF), AppColors.secondary, 'Chat Messages', 'New messages from sellers', _chatMessages, (val) {
                    setState(() => _chatMessages = val);
                    _updateSetting('chatMessages', val);
                  }),
                ]),

                const SizedBox(height: 8),

                // ── PRIVACY & SECURITY ──
                _buildSection('PRIVACY & SECURITY', [
                  _buildToggleItem(Icons.visibility, const Color(0xFFEFF6FF), AppColors.secondary, 'Public Profile', 'Let others find you', _publicProfile, (val) {
                    setState(() => _publicProfile = val);
                    _updateSetting('publicProfile', val);
                  }),
                  _buildToggleItem(Icons.fingerprint, const Color(0xFFECFDF5), AppColors.success, 'Biometric Login', 'Use fingerprint or Face ID', _biometricLogin, (val) {
                    setState(() => _biometricLogin = val);
                    _updateSetting('biometricLogin', val);
                  }),
                  _buildSettingsItem(Icons.key, const Color(0xFFFFF9EC), AppColors.accent, 'Change Password', 'Update your account password', () {
                    _showChangePasswordDialog();
                  }),
                ]),

                const SizedBox(height: 8),

                // ── SUPPORT ──
                _buildSection('SUPPORT', [
                  _buildSettingsItem(Icons.headset_mic, const Color(0xFFEFF6FF), AppColors.secondary, 'Help & Support', 'FAQs, contact us', () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Support center coming soon! 🎧')),
                    );
                  }),
                  _buildSettingsItem(Icons.star_outline, const Color(0xFFFFF9EC), AppColors.accent, 'Rate the App', 'Share your feedback', () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Thank you for your feedback! ⭐')),
                    );
                  }),
                  _buildLogoutItem(),
                ]),

                const SizedBox(height: 16),
                Text('ShopNear v2.4.1 · Made with ❤️ for Local India', textAlign: TextAlign.center, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11, fontWeight: FontWeight.w700)),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getTierLabel() {
    int points = 1500; // This would come from backend in future
    if (points >= 1500) return 'Gold';
    if (points >= 500) return 'Silver';
    return 'Bronze';
  }

  Future<void> _updateSetting(String key, bool value) async {
    try {
      final repository = ref.read(userRepositoryProvider);
      await repository.updateSettings({key: value});
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save setting: ${e.toString()}')),
        );
      }
    }
  }

  void _showPhoneEmailDialog(String phone, String email) {
    final phoneController = TextEditingController(text: phone);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Phone & Email'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.border.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.email, color: AppColors.muted, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(email, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted))),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text('Email cannot be changed', style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 10)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                final repository = ref.read(userRepositoryProvider);
                await repository.updateProfile({'phone': phoneController.text});
                ref.invalidate(userProfileProvider);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Phone updated successfully! 📱')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditFieldDialog(String label, String currentValue, String fieldKey) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit $label'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                final repository = ref.read(userRepositoryProvider);
                await repository.updateProfile({fieldKey: controller.text});
                ref.invalidate(userProfileProvider);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$label updated! ✨')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    final currentPwController = TextEditingController();
    final newPwController = TextEditingController();
    final confirmPwController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPwController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPwController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPwController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (newPwController.text != confirmPwController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Passwords do not match!')),
                );
                return;
              }
              if (newPwController.text.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password must be at least 6 characters')),
                );
                return;
              }
              Navigator.pop(ctx);
              try {
                final repository = ref.read(userRepositoryProvider);
                await repository.changePassword(currentPwController.text, newPwController.text);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully! 🔐')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  // ── UI Builder Methods ──

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
          child: Text(title, style: AppTextStyles.labelSmall.copyWith(color: AppColors.muted, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
        ),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.card,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, Color iconBg, Color iconColor, String label, String sub, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
        child: Row(
          children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
                  Text(sub, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.muted, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem(IconData icon, Color iconBg, Color iconColor, String label, String sub, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800)),
                Text(sub, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44, height: 24,
              decoration: BoxDecoration(
                color: value ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(2),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 20, height: 20,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutItem() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
                onPressed: () async {
                  Navigator.pop(ctx);
                  try {
                    final authRepo = ref.read(authRepositoryProvider);
                    await authRepo.logout();
                    if (mounted) context.go('/');
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout failed: ${e.toString()}')),
                      );
                    }
                  }
                },
                child: const Text('Log Out', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(color: const Color(0xFFFFF0F3), borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: const Icon(Icons.logout, color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Log Out', style: AppTextStyles.labelMedium.copyWith(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary)),
                  Consumer(builder: (context, ref, _) {
                    final user = ref.watch(userProfileProvider).value;
                    return Text(user?.email ?? '', style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11));
                  }),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.muted, size: 18),
          ],
        ),
      ),
    );
  }
}
