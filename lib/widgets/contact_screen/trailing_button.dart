import 'package:flutter/material.dart';
import 'package:sprout_contact/widgets/shared/featurenotready.dart';

class TrailingButton extends StatelessWidget {
  final Widget icon;
  TrailingButton(this.icon);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: () {
        return showDialog(context: context, child: NotReady());
      },
    );
  }
}
