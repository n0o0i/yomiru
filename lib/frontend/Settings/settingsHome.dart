import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  bool _isThemeLight = true;
  bool _notificationEnable = true;

  void _switchTheme() {
    setState(() {
      _isThemeLight = !_isThemeLight;
    });
  }
  
  void _switchNotification() {
    setState(() {
      _notificationEnable = !_notificationEnable;
    });
  }

  

  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.Settings,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
          ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text(AppStrings.SettingsAccountSetting),
              trailing: Icon(Icons.arrow_forward_ios, size: 16,),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(AppStrings.SettingsAppInfo),
              trailing: Icon(Icons.arrow_forward_ios, size: 16,),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.light_mode_outlined),
              title: Text(AppStrings.SettingsTheme),
              trailing: Switch(
                value: _isThemeLight, 
                onChanged: (value) {
                  _switchTheme();
                },
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Icon(Icons.light_mode_outlined);
                  }
                  return const Icon(Icons.dark_mode_outlined);
                }),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications_none),
              title: Text(AppStrings.SettingsNotification),
              trailing: Switch(
                value: _notificationEnable, 
                onChanged: (value) {
                  _switchNotification();
                }
              ),
            ),
            Divider(),
            ListTile(
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),                
                ),
                onPressed: (){
                  print('pressed');
                },
                child: Text(
                  AppStrings.SettingsLogout,
                  style: TextStyle(
                  color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}