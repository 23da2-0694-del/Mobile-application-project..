import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'RISNI';
  String _email = 'risni@gmail.com';
  String _phone = '+1 234 567 890';
  String _gender = 'Male';
  String _profileImage = 'https://api.dicebear.com/7.x/adventurer/png?seed=Felix';

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get gender => _gender;
  String get profileImage => _profileImage;

  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? profileImage,
  }) {
    if (name != null) _name = name;
    if (email != null) _email = email;
    if (phone != null) _phone = phone;
    if (gender != null) _gender = gender;
    if (profileImage != null) _profileImage = profileImage;
    notifyListeners();
  }
}
