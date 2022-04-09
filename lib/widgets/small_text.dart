import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final bool underline;
  final TextAlign align;
  double size;
  double height;
  SmallText({
    Key? key,
    required this.text,
    this.color = const Color.fromARGB(255, 0, 0, 0),
    this.underline = false,
    this.align = TextAlign.start,
    this.size = 14,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size,
          height: height,
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none),
    );
  }
}
