import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:year_in_pixels/widgets/modals/update_color_palette.dart';

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
        SettingsSection(title: const Text('Customization'), tiles: [
          SettingsTile(
              title: const Text('Color Palette'),
              leading: const Icon(Icons.palette),
              onPressed: (context) => {
                createUpdatePaletteDialog(context)
              },)
        ]),
        SettingsSection(
          title: const Text('App Settings'),
          tiles: [
            SettingsTile(
              title: const Text('Language'),
              description: const Text('English'),
              leading: const Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              title: const Text('Notifications'),
              leading: const Icon(Icons.notifications),
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
  
  createUpdatePaletteDialog(BuildContext context) {
    pageBuilder(BuildContext context, _, __) {
      return const ModalUpdateColorPalette();
    }
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: pageBuilder));
  }
}
