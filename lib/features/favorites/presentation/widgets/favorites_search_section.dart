import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FavoritesSearchSection extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const FavoritesSearchSection({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        isDense: true,
        hintText: 'favorites.search_hint'.tr(),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
