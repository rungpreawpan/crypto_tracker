import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoinAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CoinAvatar({super.key, required this.imageUrl, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          placeholder: (context, url) {
            return const CircularProgressIndicator(strokeWidth: 2.0);
          },
          errorWidget: (context, url, error) {
            return Icon(Icons.currency_bitcoin, size: size * 0.7);
          },
        ),
      ),
    );
  }
}
