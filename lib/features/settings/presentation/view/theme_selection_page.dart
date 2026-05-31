import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_gradient_background.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../providers/theme_providers.dart';

class ThemeSelectionPage extends ConsumerWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode = ref.watch(appThemeModeProvider);

    return Scaffold(
      appBar: AppBar(title: Text('settings.theme'.tr())),
      body: AppGradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _themeOptionTile(
              context,
              ref,
              selectedMode: selectedMode,
              mode: AppThemeMode.system,
              icon: Icons.brightness_auto,
              title: 'settings.theme_system'.tr(),
            ),
            const SizedBox(height: AppSpacing.sm),
            _themeOptionTile(
              context,
              ref,
              selectedMode: selectedMode,
              mode: AppThemeMode.light,
              icon: Icons.light_mode_outlined,
              title: 'settings.theme_light'.tr(),
            ),
            const SizedBox(height: AppSpacing.sm),
            _themeOptionTile(
              context,
              ref,
              selectedMode: selectedMode,
              mode: AppThemeMode.dark,
              icon: Icons.dark_mode_outlined,
              title: 'settings.theme_dark'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeOptionTile(
    BuildContext context,
    WidgetRef ref, {
    required AppThemeMode selectedMode,
    required AppThemeMode mode,
    required IconData icon,
    required String title,
  }) {
    final selected = selectedMode == mode;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: ListTile(
        onTap: () {
          ref.read(appThemeModeProvider.notifier).updateThemeMode(mode);
        },
        leading: Icon(icon),
        title: Text(title),
        trailing: selected
            ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
            : null,
      ),
    );
  }
}
