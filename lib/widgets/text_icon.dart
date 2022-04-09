import 'package:flutter/material.dart';
import 'package:weather_app/widgets/small_text.dart';

class textIcon extends StatelessWidget {
  IconData icon;
  String iconLabel;
  String text;
  int size;
  textIcon(
      {Key? key,
      required this.icon,
      required this.iconLabel,
      required this.text,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24.0 + 1.5 * size,
        ),
        SizedBox(
          height: 10,
        ),
        SmallText(
          text: text,
          color: Colors.white,
          size: 8.0 + size,
        ),
        SmallText(
          text: iconLabel,
          size: 8.0 + size,
          color: Colors.white,
        ),
      ],
    );
  }
}
