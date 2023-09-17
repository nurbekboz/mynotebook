import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/info/info_controller.dart';

class InfoPage extends GetWidget<InfoController> {
  const InfoPage({Key? key}) : super(key: key);

  static const String routeName = '/views/info/info_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(infoAppBarText),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Bu uygulama Tokat Gaziosmanpaşa Üniversitesi Çocuk Sağlığı ve Hastalıkları Ana Billim Dalı altında Yüksek Lisans  tezi için geliştirilmiştir. amacımız ilaçların hazırlanma ve kullanma biçimlerini, bazı ilaçların hastada yapabileceği değişiklikleri, hekim tavsiyesi dışında ilaç kullanmanın tehlikelerini, hastaneden çıktıktan sonra, evde ilaç kullanılacaksa bu ilaçların nasıl kullanılacağı konusunda bilgilendirilmelidir. Bu doğrultuda bu uygulama tasarlanmıştır. Gerekli bütün izinler kurumlardan alınmıştır.',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
