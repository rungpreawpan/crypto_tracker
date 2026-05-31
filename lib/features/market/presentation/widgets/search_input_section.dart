import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchInputSection extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchInputSection({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        isDense: true,
        hintText: 'market.search_hint'.tr(),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
