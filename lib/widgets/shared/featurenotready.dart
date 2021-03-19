import 'package:flutter/material.dart';

class NotReady extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('This feature is not available now'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('okay'))
      ],
    );
  }
}
