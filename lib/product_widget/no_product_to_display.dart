
import 'package:flutter/material.dart';

class NoProductWidget extends StatelessWidget {
  const NoProductWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/images/empty_product.png'),
          Text(
            'Empty Product Category',
            style: TextStyle(
                color: Color(0xff83CB81),
                fontSize: 20,),
          ),
        ],
      ),
    );
  }
}