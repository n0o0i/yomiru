import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class TagPrivacy extends StatefulWidget {
  @override
  _TagPrivacyState createState() => _TagPrivacyState();
}

class _TagPrivacyState extends State<TagPrivacy> {
  String? _selectedValue = AppStrings.TagPrivacySelectionFriends;
  final List<String> _item = [
    AppStrings.TagPrivacySelectionUsers,
    AppStrings.TagPrivacySelectionFriends, 
    AppStrings.TagPrivacySelectionNoUsers,
  ];
  
  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      value: _selectedValue,
      items: _item.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item)
      )).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      }
    );
  }
}