import 'package:flutter/material.dart';
import 'package:weather_app/widgets/small_text.dart';

class textIcon extends StatelessWidget {
  IconData icon;
  String iconLabel;
  String text;
  String idImg;
  int size;
  bool isIcon;
  textIcon({
    Key? key,
    required this.iconLabel,
    required this.text,
    this.icon = Icons.error,
    this.size = 0,
    this.isIcon = true,
    this.idImg = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isIcon
            ? Icon(
                icon,
                color: Colors.white,
                size: 24.0 + 1.5 * size,
              )
            : Container(
                height: 40,
                width: 40,
                child: Image.network(
                  'http://openweathermap.org/img/wn/${idImg}@2x.png',
                  fit: BoxFit.fill,
                ),
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
