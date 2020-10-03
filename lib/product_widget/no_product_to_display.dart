
import 'package:flutter/material.dart';

class NoProductWidget extends StatelessWidget {
  const NoProductWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/empty_product.png',height: 200,width: 200,),
            Text(
              'Empty Product Category',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff83CB81),
                  fontSize: 20,),
            ),
          ],
        ),
      ),
    );
  }
}