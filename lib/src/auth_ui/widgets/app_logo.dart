import 'package:flutter/material.dart';
import 'package:tf_responsive/tf_responsive.dart';
import '../resources/resources.dart' as rsc;

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "TfAuth App",
                style: rsc.textTheme(context).headline3?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: rsc.primaryColor(context),
                    ),
              ),
              SizedBox(height: tfHeight(0.3)),
              Text(
                "One Place Auth for Tenfins",
                style: TextStyle(
                  color: rsc.primaryColor(context),
                  fontSize: tfText(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
