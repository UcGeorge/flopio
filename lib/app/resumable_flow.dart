import 'package:flutter/material.dart';

abstract class ResumableFlow {
  String get flowName;
  void resume(BuildContext context);
}
