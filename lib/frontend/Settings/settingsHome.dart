import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/strings.dart';
import 'package:yomiru/frontend/Settings/accoutSettings.dart';
import 'package:yomiru/services/api_client.dart';

class SettingsHome extends StatefulWidget {
  const SettingsHome({super.key});

  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  int _selectedIndex = 0;
  bool _isThemeLight = true;
  bool _notificationEnable = true;
  bool _isLoading = false;
  final ApiClient _apiClient = ApiClient();

  void _switchBosy() {
    setState(() {
      _selectedIndex = _selectedIndex == 0 ? 1 : 0;
    });
  }

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

  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);
    try {
      await _apiClient.logout();
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ログアウト失敗：${e.toString()}'))
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bodies = [
      settingsHome(),
      AccountSettings(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.Settings,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
        ),
        leading: _selectedIndex == 1
        ? IconButton(
          onPressed: _switchBosy, 
          icon: Icon(Icons.arrow_back_ios_new_outlined)
        ) 
        : null,
        centerTitle: true,
      ),
      body:  bodies[_selectedIndex],
    );
  }

  Widget settingsHome() {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text(AppStrings.SettingsAccountSetting),
              trailing: Icon(Icons.arrow_forward_ios, size: 16,),
              onTap: _switchBosy,
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
                  _handleLogout();
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