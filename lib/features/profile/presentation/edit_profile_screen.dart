import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../data/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;
  late TextEditingController _phoneController;
  late String _selectedAvatar;

  final List<String> _avatarOptions = [
    '😊', '😎', '🥰', '🤗', '😄', '🦊', '🐱', '🦋', '🌸', '🌟', '💎', '🎭'
  ];

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _nameController = TextEditingController(text: profile.name);
    _usernameController = TextEditingController(text: profile.username);
    _bioController = TextEditingController(text: profile.bio);
    _locationController = TextEditingController(text: profile.location);
    _phoneController = TextEditingController(text: profile.phone);
    _selectedAvatar = profile.avatar;

    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 800));

    ref.read(profileProvider.notifier).updateProfile(
      name: _nameController.text.trim(),
      username: _usernameController.text.trim(),
      bio: _bioController.text.trim(),
      location: _locationController.text.trim(),
      phone: _phoneController.text.trim(),
      avatar: _selectedAvatar,
    );

    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        const Icon(Icons.check_circle, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Text('Profile updated! ✨', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
      ]),
      backgroundColor: AppColors.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    ));

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5B5FEF), Color(0xFF764ba2), Color(0xFFf093fb)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(top: -30, right: -40, child: Container(width: 140, height: 140, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.08)))),
          Positioned(top: 60, left: -20, child: Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.06)))),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                        ),
                      ),
                      const Spacer(),
                      Text('Edit Profile', style: AppTextStyles.h3.copyWith(color: Colors.white, fontWeight: FontWeight.w900)),
                      const Spacer(),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            _buildAvatarSection(),
                            const SizedBox(height: 20),
                            _buildFormCard(),
                            const SizedBox(height: 16),
                            _buildPreferencesCard(),
                            const SizedBox(height: 24),
                            _buildSaveButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 90, height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4),
                gradient: const LinearGradient(colors: [Color(0xFFf093fb), Color(0xFFf5576c)]),
                boxShadow: [BoxShadow(color: const Color(0xFFf093fb).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              alignment: Alignment.center,
              child: Text(_selectedAvatar, style: const TextStyle(fontSize: 44)),
            ),
            Positioned(
              bottom: 0, right: 0,
              child: Container(
                width: 30, height: 30,
                decoration: BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: [BoxShadow(color: AppColors.secondary.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 2))]),
                alignment: Alignment.center,
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text('Choose your avatar', style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
          child: Wrap(
            spacing: 6, runSpacing: 6, alignment: WrapAlignment.center,
            children: _avatarOptions.map((emoji) {
              final sel = _selectedAvatar == emoji;
              return GestureDetector(
                onTap: () => setState(() => _selectedAvatar = emoji),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200), width: 42, height: 42,
                  decoration: BoxDecoration(
                    color: sel ? Colors.white : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: sel ? Border.all(color: AppColors.secondary, width: 2) : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(emoji, style: TextStyle(fontSize: sel ? 22 : 20)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 6))]),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Personal Info', style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text('Update your personal details', style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted)),
            const SizedBox(height: 20),
            _buildField(_nameController, 'Full Name', Icons.person_outline, validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null),
            const SizedBox(height: 16),
            _buildField(_usernameController, 'Username', Icons.alternate_email, prefix: '@',
                validator: (v) { if (v == null || v.trim().isEmpty) return 'Required'; if (v.contains(' ')) return 'No spaces'; return null; }),
            const SizedBox(height: 16),
            _buildField(_locationController, 'Location', Icons.location_on_outlined),
            const SizedBox(height: 16),
            _buildField(_phoneController, 'Phone', Icons.phone_outlined, keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            _buildField(_bioController, 'Bio', Icons.edit_note, maxLines: 3, maxLength: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 6))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preferences', style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text('Customize your experience', style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted)),
          const SizedBox(height: 16),
          _buildToggle(icon: Icons.notifications_outlined, title: 'Push Notifications', subtitle: 'Live session alerts', value: true),
          const SizedBox(height: 12),
          _buildToggle(icon: Icons.visibility_outlined, title: 'Public Profile', subtitle: 'Let others find you', value: true),
          const SizedBox(height: 12),
          _buildToggle(icon: Icons.local_offer_outlined, title: 'Deal Alerts', subtitle: 'Flash sales nearby', value: false),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity, height: 52,
        child: ElevatedButton(
          onPressed: _isSaving ? null : _saveProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            disabledBackgroundColor: AppColors.secondary.withOpacity(0.6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4, shadowColor: AppColors.secondary.withOpacity(0.4),
          ),
          child: _isSaving
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
                  const SizedBox(width: 12),
                  Text('Saving...', style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                ])
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text('Save Changes', style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15)),
                ]),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, IconData icon, {String? prefix, int maxLines = 1, int? maxLength, TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w800, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl, maxLines: maxLines, maxLength: maxLength, keyboardType: keyboardType, validator: validator,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.text, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Padding(padding: const EdgeInsets.only(left: 12, right: 8), child: Icon(icon, color: AppColors.secondary, size: 20)),
            prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            prefixText: prefix, prefixStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.muted, fontWeight: FontWeight.w600),
            filled: true, fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.secondary, width: 1.5)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.danger)),
            counterStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.muted),
          ),
        ),
      ],
    );
  }

  Widget _buildToggle({required IconData icon, required String title, required String subtitle, required bool value}) {
    return StatefulBuilder(builder: (ctx, setS) {
      bool on = value;
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center, child: Icon(icon, color: AppColors.secondary, size: 20)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w800, fontSize: 13)),
            Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.muted, fontSize: 11)),
          ])),
          Switch.adaptive(value: on, onChanged: (v) => setS(() => on = v), activeColor: AppColors.secondary),
        ]),
      );
    });
  }
}
