import 'package:flutter/material.dart';

class NetworkImageWithLoader extends StatelessWidget {
  const NetworkImageWithLoader({
    super.key,
    required this.imageSrc
  });

  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Image.network(
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
          imageSrc,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Text('Failed to load image');
          }
    ));
  }
}
