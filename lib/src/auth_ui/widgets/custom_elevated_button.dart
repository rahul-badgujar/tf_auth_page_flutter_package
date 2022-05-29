import 'package:flutter/material.dart';
import 'package:tf_responsive/tf_responsive.dart';

import '../resources/resources.dart' as rsc;

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.lable,
  }) : super(key: key);

  final void Function() onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        lable,
      ),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(rsc.primaryColor(context)),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          rsc.actionButtonsTextStyle(context),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(tfImage(1)),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(
            tfWidth(50),
            tfHeight(7),
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
