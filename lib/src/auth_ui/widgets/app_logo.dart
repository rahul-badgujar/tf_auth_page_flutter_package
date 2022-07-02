import 'package:flutter/material.dart';
import 'package:tf_responsive/tf_responsive.dart';
import '../resources/resources.dart' as rsc;

class AppTitleAndTagline extends StatelessWidget {
  const AppTitleAndTagline({
    Key? key,
    required this.appTitle,
    this.appTagline,
  }) : super(key: key);

  final String appTitle;
  final String? appTagline;

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
                appTitle,
                style: rsc.textTheme(context).headline3?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: rsc.primaryColor(context),
                    ),
              ),
              SizedBox(height: tfHeight(0.3)),
              if (appTagline != null)
                Text(
                  "$appTagline",
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
