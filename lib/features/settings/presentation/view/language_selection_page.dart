import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_gradient_background.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedLocale = context.locale;

    return Scaffold(
      appBar: AppBar(title: Text('settings.language'.tr())),
      body: AppGradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _languageOptionTile(
              context,
              selectedLocale: selectedLocale,
              locale: const Locale('en'),
              icon: Icons.language,
              title: 'settings.language_english'.tr(),
            ),
            const SizedBox(height: AppSpacing.sm),
            _languageOptionTile(
              context,
              selectedLocale: selectedLocale,
              locale: const Locale('th'),
              icon: Icons.translate,
              title: 'settings.language_thai'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageOptionTile(
    BuildContext context, {
    required Locale selectedLocale,
    required Locale locale,
    required IconData icon,
    required String title,
  }) {
    final selected = selectedLocale.languageCode == locale.languageCode;

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
          context.setLocale(locale);
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
