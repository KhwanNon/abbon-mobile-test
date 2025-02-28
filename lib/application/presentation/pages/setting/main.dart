import 'package:abbon_mobile_test/application/presentation/widget/layouts/scaffold.dart';
import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String lang = currentLocale.languageCode == "th" ? "ไทย" : "English";
    return ScaffoldApp(
      title: "setting.setting".tr(),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              if (currentLocale.languageCode == "th") {
                EasyLocalization.of(context)?.setLocale(Locale('en', 'US'));
              } else {
                EasyLocalization.of(context)?.setLocale(Locale('th', 'TH'));
              }
            },
            leading: Text(
              '${"setting.lang".tr()} ($lang)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Icon(CupertinoIcons.arrow_right_arrow_left, size: 18),
          ),
          ListTile(
            onTap: () {
              AppSettings.openAppSettings();
            },
            title: Text("setting.notification".tr(), style: Theme.of(context).textTheme.bodyLarge),
            trailing: Icon(CupertinoIcons.chevron_right, size: 18),
          ),
        ],
      ),
    );
  }
}
