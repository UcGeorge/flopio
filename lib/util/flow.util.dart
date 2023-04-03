import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlowUtil {
  static Future<T?> moveToAndReplace<T extends Object, TO extends Object>({
    required BuildContext context,
    required Widget page,
    String? name,
    Color? barrierColor,
    bool opaque = true,
    FlowTransition transition = FlowTransition.cupertino,
    Duration? transitionDuration,
  }) {
    return Navigator.of(context).pushReplacement(
      _createRoute<T>(
        transition,
        page: page,
        name: name,
        opaque: opaque,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
      ),
    );
  }

  static Future<T?> moveToAndRemoveAll<T extends Object>({
    required BuildContext context,
    required Widget page,
    String? name,
    Color? barrierColor,
    bool opaque = true,
    FlowTransition transition = FlowTransition.cupertino,
    Duration? transitionDuration,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      _createRoute<T>(
        transition,
        page: page,
        name: name,
        opaque: opaque,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
      ),
      (route) => false,
    );
  }

  static Future<T?> moveTo<T extends Object>({
    required BuildContext context,
    required Widget page,
    String? name,
    Color? barrierColor,
    bool opaque = true,
    FlowTransition transition = FlowTransition.cupertino,
    Duration? transitionDuration,
  }) {
    return Navigator.of(context).push(
      _createRoute<T>(
        transition,
        page: page,
        name: name,
        opaque: opaque,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
      ),
    );
  }

  static void back<T extends Object>({
    required BuildContext context,
    T? result,
  }) {
    Navigator.pop<T>(context, result);
  }

  static void backTo(BuildContext context, RoutePredicate predicate) {
    Navigator.of(context).popUntil(predicate);
  }

  static void moveToAndRemoveUtil(
      BuildContext context, Widget newPage, String pageName) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => newPage),
        ModalRoute.withName(pageName));
  }

  static Route<T> _createRoute<T>(
    FlowTransition transition, {
    required Widget page,
    String? name,
    bool opaque = true,
    Color? barrierColor,
    Duration? transitionDuration,
  }) {
    switch (transition) {
      case FlowTransition.cupertino:
        return _cupertinoRoute<T>(page: page, name: name);
      case FlowTransition.material:
        return _materialRoute<T>(page: page, name: name);
      case FlowTransition.fade:
        return _fadeRoute<T>(
          page: page,
          name: name,
          opaque: opaque,
          barrierColor: barrierColor,
          transitionDuration: transitionDuration,
        );
      case FlowTransition.slide:
        return _slideRoute<T>(
          page: page,
          name: name,
          opaque: opaque,
          barrierColor: barrierColor,
          transitionDuration: transitionDuration,
        );
      case FlowTransition.scale:
        return _scaleRoute<T>(
          page: page,
          name: name,
          opaque: opaque,
          barrierColor: barrierColor,
          transitionDuration: transitionDuration,
        );
    }
  }

  static Route<T> _cupertinoRoute<T>({required Widget page, String? name}) {
    return CupertinoPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => page,
    );
  }

  static Route<T> _materialRoute<T>({required Widget page, String? name}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => page,
    );
  }

  static Route<T> _slideRoute<T>({
    required Widget page,
    String? name,
    Color? barrierColor,
    bool opaque = true,
    Duration? transitionDuration,
  }) {
    return PageRouteBuilder<T>(
      settings: RouteSettings(name: name),
      transitionDuration: transitionDuration ?? 300.ms,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      barrierColor: barrierColor,
      opaque: opaque,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<T> _scaleRoute<T>({
    required Widget page,
    String? name,
    Color? barrierColor,
    bool opaque = true,
    Duration? transitionDuration,
  }) {
    return PageRouteBuilder<T>(
      settings: RouteSettings(name: name),
      transitionDuration: transitionDuration ?? 300.ms,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      barrierColor: barrierColor,
      opaque: opaque,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return ScaleTransition(
          scale: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<T> _fadeRoute<T>({
    required Widget page,
    String? name,
    Color? barrierColor,
    bool opaque = true,
    Duration? transitionDuration,
  }) {
    return PageRouteBuilder<T>(
      settings: RouteSettings(name: name),
      transitionDuration: transitionDuration ?? 300.ms,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      barrierColor: barrierColor,
      opaque: opaque,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.ease;

        final tween = Tween<double>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

enum FlowTransition { cupertino, material, fade, slide, scale }
