import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Sozlamalar',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(24),

          _Section(title: 'Ilova haqida', tiles: [
            _SettingsTile(
              icon: Iconsax.info_circle,
              label: 'Versiya',
              value: '1.0.0',
            ),
            _SettingsTile(
              icon: Iconsax.global,
              label: 'Til',
              value: "O'zbek",
            ),
            _SettingsTile(
              icon: Iconsax.money,
              label: 'Valyuta',
              value: "So'm (UZS)",
            ),
          ]),

          const Gap(16),

          _Section(title: "Ma'lumot", tiles: [
            _SettingsTile(
              icon: Iconsax.shield_tick,
              label: 'Maxfiylik siyosati',
              onTap: () {},
            ),
            _SettingsTile(
              icon: Iconsax.document_text,
              label: 'Foydalanish shartlari',
              onTap: () {},
            ),
          ]),

          const Gap(32),

          Center(
            child: Text(
              'Xarajat — O\'zbek moliya yordamchisi 🇺🇿',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textHint,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const _Section({required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(children: tiles),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: value != null
          ? Text(value!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ))
          : const Icon(Icons.arrow_forward_ios,
              size: 14, color: AppColors.textHint),
      onTap: onTap,
    );
  }
}
