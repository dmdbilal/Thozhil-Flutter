import 'package:flutter/material.dart';
import '../model/user.model.dart';
import '../util/util_functions.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title, style: dmSansStyle(15)),
            ),
            Expanded(
                child: Text(value.toString(), style: dmSansStyle(15, fontWeight: FontWeight.w600))
            )
          ],
        ),
        const SizedBox(height: 5)
      ],
    );
  }
}