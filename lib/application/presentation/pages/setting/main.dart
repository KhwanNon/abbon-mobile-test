import 'package:abbon_mobile_test/application/presentation/widget/layouts/scaffold.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      title: "Setting",
      body: Column(
        children: [
          ListTile(
            onTap: () {},
            leading: Text(
              'Language (Thai)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Icon(CupertinoIcons.arrow_right_arrow_left, size: 18),
          ),
          ListTile(
            onTap: () {
              AppSettings.openAppSettings();
            },
            title: Text(
              'Notification',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Icon(CupertinoIcons.chevron_right, size: 18),
          ),
        ],
      ),
    );
  }
}
