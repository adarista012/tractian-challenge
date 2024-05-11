import 'package:flutter/material.dart';

Widget customProgressIndicator() {
  return const Padding(
    padding: EdgeInsets.all(64.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
