import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../utils/constant/size.dart';
import '../../utils/helper/helper.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
    this.actionWidget = const SizedBox.shrink(),
    this.hasBackButton = false,
    this.isSection = true,
    this.indicator = '',
  });

  final String title, indicator;
  final Widget actionWidget;
  final bool hasBackButton;
  final bool isSection;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    if (isSection) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            top: CustomSize.spaceBetweenItems * 1.5,
            left: CustomSize.defaultSpace,
            right: CustomSize.defaultSpace,
            bottom: CustomSize.spaceBetweenItems,
          ),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                  width: CustomSize.defaultSpace / 4
              ),
              if (indicator.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: dark ? Colors.blue[900]!.withOpacity(0.5) : Colors.blue[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: CustomSize.xs / 2,
                      horizontal: CustomSize.xs,
                    ),
                    child: Text(
                      indicator,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: dark ? Colors.blue[400] : Colors.blue[500],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            top: CustomSize.spaceBetweenItems * 1.5,
            left: CustomSize.defaultSpace,
            right: CustomSize.defaultSpace,
            bottom: CustomSize.spaceBetweenItems,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasBackButton)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: CustomSize.spaceBetweenItems,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          IconsaxPlusLinear.arrow_left,
                        ),
                      ),
                    ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              actionWidget,
            ],
          ),
        ),
      );
    }
  }
}
