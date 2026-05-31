import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/app_currency.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../providers/currency_providers.dart';
import '../providers/theme_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedThemeMode = ref.watch(appThemeModeProvider);
    final selectedCurrency = ref.watch(appCurrencyProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      children: [
        _appProfileCard(context),
        const SizedBox(height: AppSpacing.xl),
        _settingsGroup(
          context,
          title: 'settings.appearance'.tr(),
          children: [
            _settingsTile(
              context,
              icon: Icons.light_mode_outlined,
              title: 'settings.theme'.tr(),
              value: _themeModeLabel(selectedThemeMode),
              onTap: () {
                context.pushNamed('themeSelection');
              },
            ),
            _settingsTile(
              context,
              icon: Icons.language,
              title: 'settings.language'.tr(),
              value: _languageLabel(context),
              onTap: () {
                context.pushNamed('languageSelection');
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        _settingsGroup(
          context,
          title: 'settings.data'.tr(),
          children: [
            _settingsTile(
              context,
              icon: Icons.attach_money,
              title: 'settings.currency'.tr(),
              value: selectedCurrency.displayCode,
              onTap: () {
                context.pushNamed('currencySelection');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _appProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Image.asset(
              'assets/logo/app_logo.png',
              width: 84.0,
              height: 84.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'app.name'.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppSpacing.sm),
                _versionBadge(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _versionBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        'settings.version'.tr(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white.withValues(alpha: 0.92),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _settingsGroup(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.68),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.08),
            ),
          ),
          child: Column(
            children: List.generate(children.length, (index) {
              final child = children[index];

              if (index == children.length - 1) {
                return child;
              }

              return Column(
                children: [
                  child,
                  Divider(
                    height: 1.0,
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.08),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _settingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: AppSpacing.md,
      leading: _settingsIcon(context, icon),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.isNotEmpty)
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: valueColor ?? Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          const SizedBox(width: AppSpacing.sm),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _settingsIcon(BuildContext context, IconData icon) {
    return Container(
      width: 44.0,
      height: 44.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: Icon(icon),
    );
  }

  String _themeModeLabel(AppThemeMode mode) {
    if (mode == AppThemeMode.light) {
      return 'settings.theme_light'.tr();
    }

    if (mode == AppThemeMode.dark) {
      return 'settings.theme_dark'.tr();
    }

    return 'settings.theme_system'.tr();
  }

  String _languageLabel(BuildContext context) {
    if (context.locale.languageCode == 'th') {
      return 'settings.language_thai'.tr();
    }

    return 'settings.language_english'.tr();
  }
}
