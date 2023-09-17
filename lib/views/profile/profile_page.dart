import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/profile/profile_controller.dart';

class ProfilePage extends GetWidget<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  static const String routeName = '/views/profile/profile_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profileAppBarText),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          '> 2015/2019 Gazi Üniversitesi Sağlık Bilimleri Hemşirelik Bölümü \n\n> 2020/Halen Tokat Gaziosmanpaşa Üniversitesi Çocuk Sağlığı ve Hastalıkları Ana Billim Dalı Yüksek Lisans',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
