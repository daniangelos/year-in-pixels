import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:year_in_pixels/widgets/grid.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool allowNotifications = false;

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(title: Text('Customization'), tiles: [
          SettingsTile(
              title: Text('Color Palette'), leading: Icon(Icons.palette))
        ]),
        SettingsSection(
          title: Text('App Settings'),
          tiles: [
            SettingsTile(
              title: Text('Language'),
              description: Text('English'),
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              title: Text('Notifications'),
              leading: Icon(Icons.notifications),
              onToggle: (bool value) {
                setState(() {
                  allowNotifications = value;
                });
              },
              initialValue: allowNotifications,
            ),
          ],
        ),
      ],
    );
  }
}
