import 'package:flutter/material.dart';

import '../../utils/constant/size.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
            top: CustomSize.spaceBetweenItems * 1.5,
            left: CustomSize.defaultSpace,
            right: CustomSize.defaultSpace,
            bottom: CustomSize.spaceBetweenItems
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}