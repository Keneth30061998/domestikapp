import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  String text = '';
  NoDataWidget({this.text = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/no_data_item.png',
            height: 130,
            width: 130,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
