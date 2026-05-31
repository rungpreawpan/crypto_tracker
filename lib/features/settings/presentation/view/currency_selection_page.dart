import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_gradient_background.dart';
import '../../domain/entities/app_currency.dart';
import '../providers/currency_providers.dart';

class CurrencySelectionPage extends ConsumerWidget {
  const CurrencySelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCurrency = ref.watch(appCurrencyProvider);

    return Scaffold(
      appBar: AppBar(title: Text('settings.currency'.tr())),
      body: AppGradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _currencyOptionTile(
              context,
              ref,
              selectedCurrency: selectedCurrency,
              currency: AppCurrency.usd,
              title: 'settings.currency_usd'.tr(),
            ),
            const SizedBox(height: AppSpacing.sm),
            _currencyOptionTile(
              context,
              ref,
              selectedCurrency: selectedCurrency,
              currency: AppCurrency.thb,
              title: 'settings.currency_thb'.tr(),
            ),
            const SizedBox(height: AppSpacing.sm),
            _currencyOptionTile(
              context,
              ref,
              selectedCurrency: selectedCurrency,
              currency: AppCurrency.eur,
              title: 'settings.currency_eur'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _currencyOptionTile(
    BuildContext context,
    WidgetRef ref, {
    required AppCurrency selectedCurrency,
    required AppCurrency currency,
    required String title,
  }) {
    final selected = selectedCurrency == currency;

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
          ref.read(appCurrencyProvider.notifier).updateCurrency(currency);
        },
        leading: CircleAvatar(child: Text(currency.symbol)),
        title: Text(title),
        trailing: selected
            ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
            : null,
      ),
    );
  }
}
