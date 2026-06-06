import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  String _themeLabel(BuildContext context, ThemeMode mode) {
    final l10n = context.l10n;
    switch (mode) {
      case ThemeMode.light:
        return l10n.themeLight;
      case ThemeMode.dark:
        return l10n.themeDark;
      case ThemeMode.system:
        return l10n.themeSystem;
    }
  }

  void _showLanguagePicker(BuildContext context) {
    final l10n = context.l10n;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.of(context).surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return _PickerSheet(
          title: l10n.selectLanguage,
          options: [
            _PickerOption(
              label: l10n.uzbek,
              trailing: '🇺🇿',
              selected: LocaleController.languageCode == 'uz',
              onTap: () {
                LocaleController.setLocale(const Locale('uz'));
                Navigator.pop(ctx);
              },
            ),
            _PickerOption(
              label: l10n.russian,
              trailing: '🇷🇺',
              selected: LocaleController.languageCode == 'ru',
              onTap: () {
                LocaleController.setLocale(const Locale('ru'));
                Navigator.pop(ctx);
              },
            ),
          ],
        );
      },
    );
  }

  void _showThemePicker(BuildContext context) {
    final l10n = context.l10n;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.of(context).surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final current = LocaleController.themeMode.value;
        return _PickerSheet(
          title: l10n.themeMode,
          options: [
            _PickerOption(
              label: l10n.themeSystem,
              trailing: '⚙️',
              selected: current == ThemeMode.system,
              onTap: () {
                LocaleController.setThemeMode(ThemeMode.system);
                Navigator.pop(ctx);
              },
            ),
            _PickerOption(
              label: l10n.themeLight,
              trailing: '☀️',
              selected: current == ThemeMode.light,
              onTap: () {
                LocaleController.setThemeMode(ThemeMode.light);
                Navigator.pop(ctx);
              },
            ),
            _PickerOption(
              label: l10n.themeDark,
              trailing: '🌙',
              selected: current == ThemeMode.dark,
              onTap: () {
                LocaleController.setThemeMode(ThemeMode.dark);
                Navigator.pop(ctx);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final l10n = context.l10n;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.settings,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: c.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(24),

          _Section(title: l10n.aboutApp, tiles: [
            _SettingsTile(
              icon: Iconsax.info_circle,
              label: l10n.version,
              value: '1.0.0',
            ),
            _SettingsTile(
              icon: Iconsax.global,
              label: l10n.language,
              value: LocaleController.languageCode == 'ru'
                  ? l10n.russian
                  : l10n.uzbek,
              onTap: () => _showLanguagePicker(context),
            ),
            _SettingsTile(
              icon: Iconsax.money,
              label: l10n.currency,
              value: l10n.currencyName,
            ),
          ]),

          const Gap(16),

          _Section(title: l10n.appearance, tiles: [
            ValueListenableBuilder<ThemeMode>(
              valueListenable: LocaleController.themeMode,
              builder: (context, mode, _) => _SettingsTile(
                icon: Icons.dark_mode_outlined,
                label: l10n.themeMode,
                value: _themeLabel(context, mode),
                onTap: () => _showThemePicker(context),
              ),
            ),
          ]),

          const Gap(16),

          _Section(title: l10n.information, tiles: [
            _SettingsTile(
              icon: Iconsax.shield_tick,
              label: l10n.privacyPolicy,
              onTap: () {},
            ),
            _SettingsTile(
              icon: Iconsax.document_text,
              label: l10n.termsOfUse,
              onTap: () {},
            ),
          ]),

          const Gap(32),

          Center(
            child: Text(
              l10n.footer,
              style: TextStyle(
                fontSize: 12,
                color: c.textHint,
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
    final c = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: c.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.border),
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
    final c = AppColors.of(context);
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
        ),
      ),
      trailing: value != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value!,
                    style: TextStyle(
                      color: c.textSecondary,
                      fontSize: 14,
                    )),
                if (onTap != null) ...[
                  const Gap(4),
                  Icon(Icons.arrow_forward_ios, size: 13, color: c.textHint),
                ],
              ],
            )
          : Icon(Icons.arrow_forward_ios, size: 14, color: c.textHint),
      onTap: onTap,
    );
  }
}

class _PickerSheet extends StatelessWidget {
  final String title;
  final List<_PickerOption> options;

  const _PickerSheet({required this.title, required this.options});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: c.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(16),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
            ),
            const Gap(8),
            ...options,
          ],
        ),
      ),
    );
  }
}

class _PickerOption extends StatelessWidget {
  final String label;
  final String trailing;
  final bool selected;
  final VoidCallback onTap;

  const _PickerOption({
    required this.label,
    required this.trailing,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.10)
              : c.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(trailing, style: const TextStyle(fontSize: 20)),
            const Gap(12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? AppColors.primary : c.textPrimary,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle,
                  color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
