import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final TextAlign align;

  FontWeight fontWeight;
  double size;
  TextOverflow overFlow;
  BigText(
      {Key? key,
      required this.text,
      this.color = const Color.fromARGB(255, 0, 0, 0),
      this.size = 20,
      this.align = TextAlign.start,
      this.fontWeight = FontWeight.w400,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
