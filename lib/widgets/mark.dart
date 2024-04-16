import 'package:flutter/material.dart';

class MarkWidget extends StatelessWidget {
  final String code, subject;
  final String mark;
  const MarkWidget(
      {super.key,
      required this.code,
      required this.subject,
      required this.mark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              code,
              textAlign: TextAlign.start,
              style: TextStyle(),
            ),
            flex: 2,
          ),
          Expanded(
            child: Text(
              subject,
              textAlign: TextAlign.start,
              style: TextStyle(),
            ),
          ),
          Expanded(
            child: Text(
              mark.toString(),
              textAlign: TextAlign.start,
              style: TextStyle(),
            ),
          )
        ],
      ),
    );
  }
}
