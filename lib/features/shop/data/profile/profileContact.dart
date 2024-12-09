import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/screen/profile/widgets/profileContactInfo.dart';

import '../../../../utils/constant/strings.dart';

final List<ContactInfoItem> contactInfoList = [
  ContactInfoItem(
    title: Strings.name,
    body: Strings.placeholder,
    icon: IconsaxPlusBold.user,
    iconColorDark: Colors.lightBlue[400]!,
    iconColorLight: Colors.lightBlue[500]!,
    backgroundColorDark: Colors.lightBlue[900]!.withOpacity(0.5),
    backgroundColorLight: Colors.lightBlue[50]!,
  ),
  ContactInfoItem(
    title: Strings.email,
    body: Strings.placeholder,
    icon: IconsaxPlusBold.sms,
    iconColorDark: Colors.orange[400]!,
    iconColorLight: Colors.orange[500]!,
    backgroundColorDark: Colors.orange[900]!.withOpacity(0.5),
    backgroundColorLight: Colors.orange[50]!,
  ),
  ContactInfoItem(
    title: Strings.phoneNumber,
    body: Strings.placeholder,
    icon: IconsaxPlusBold.call,
    iconColorDark: Colors.green[400]!,
    iconColorLight: Colors.green[500]!,
    backgroundColorDark: Colors.green[900]!.withOpacity(0.5),
    backgroundColorLight: Colors.green[50]!,
  ),
  ContactInfoItem(
    title: Strings.address,
    body: Strings.placeholder,
    icon: IconsaxPlusBold.location,
    iconColorDark: Colors.red[400]!,
    iconColorLight: Colors.red[500]!,
    backgroundColorDark: Colors.red[900]!.withOpacity(0.5),
    backgroundColorLight: Colors.red[50]!,
  ),
];