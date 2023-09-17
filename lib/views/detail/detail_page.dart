import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:my_note_book/data/src/colors.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:my_note_book/views/detail/video_player.dart';

import '../../data/src/strings.dart';
import '../home/home_controller.dart';

class DetailPage extends GetWidget<HomeController> {
  const DetailPage({Key? key, this.data, this.index}) : super(key: key);

  //static const String routeName = '/views/detail/detail_page';
  final String? data;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(homeAppBarText),
        backgroundColor: mainColor,
      ),
      body: _buildCardColumn(data ?? ""),
    );
  }

  Widget _buildCardColumn(
    String description,
  ) {
    if (index == 13) {
      return VideoPlayerDetail();
    } else {
      if (description == "YÜKLENİYOR") {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: HtmlWidget(
               description,
            ),
          ),
        );
      }
    }
  }
}
