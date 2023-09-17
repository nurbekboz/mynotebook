import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final void Function()? answerTap;

  Answer(
      {required this.answerText,
      required this.answerColor,
      required this.answerTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 0, top: 8, bottom: 8),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        elevation: 4,
        color: answerColor,
        child: InkWell(
          splashColor: Color(0xfff2a88b7),
          borderRadius: BorderRadius.circular(16.0),
          onTap: answerTap,
          child: Container(
            alignment: Alignment.center,
            height: 64,
            decoration: BoxDecoration(
              color: answerColor,
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              answerText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  void call() {}
}
