import 'package:flutter/material.dart';

EdgeInsetsGeometry edgeInsetsGeometryOfScreens({required BuildContext context}) {
  return EdgeInsets.symmetric(
    horizontal: MediaQuery.of(context).size.width / 30,
    vertical: MediaQuery.of(context).size.height / 40,
  );
}
