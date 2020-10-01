import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
class ProductSubHead extends StatelessWidget {
  const ProductSubHead({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text(
        text,
        style: kProductSubHeadStyle,
      ),
      padding: EdgeInsets.all(10),
    );
  }
}