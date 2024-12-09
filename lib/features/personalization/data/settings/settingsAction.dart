import 'package:product_catalogue/common/widgets/personalization/settingItem.dart';

import '../../../../utils/constant/strings.dart';

final List<SettingItem> settingsActionList = [
  SettingItem(
      title: Strings.changeName
  ),
  SettingItem(
      title: Strings.updatePhoneNumber
  ),
  SettingItem(
      title: Strings.changeAddress
  ),
  SettingItem(
      title: Strings.logout,
      isDanger: true,
  ),
];