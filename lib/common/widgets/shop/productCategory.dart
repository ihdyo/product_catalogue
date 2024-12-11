import 'package:flutter/material.dart';

import '../../../utils/constant/size.dart';
import '../../../utils/helper/helper.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    this.onClick,
  });

  final String name;
  final IconData icon;
  final MaterialColor color;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return GestureDetector(
      onTap: onClick,
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
            color: dark ? color[900]!.withOpacity(0.5) : color[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(CustomSize.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: dark ? color[400] : color[500],
                  size: 20,
                ),
                const SizedBox(
                  width: CustomSize.xs,
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: dark ? color[400] : color[500],
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}