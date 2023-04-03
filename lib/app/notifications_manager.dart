import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../util/log.util.dart';

class NotificationsManager {
  static Map<String, FutureOr Function(Map<String, dynamic>?)> remoteMethods =
      {};

  static Future<void> init({
    Function(Object)? onError,
  }) async {
    LogUtil.devLog(
      "NotificationService",
      message: 'Initializing NotificationsManager',
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      onError?.call("User denied notification permission");
      return Future.error("Unable to get FCM token");
    }

    LogUtil.devLog(
      "NotificationService",
      message: 'Initializing FCM',
    );

    //To retrieve the current registration token for an app instance, call getToken()
    final String? fcmToken = await messaging
        .getToken()
        .onError((error, stackTrace) => onError?.call(error.toString()));

    if (fcmToken == null) {
      onError?.call("Unable to get FCM token");
      return Future.error("Unable to get FCM token");
    }

    _onTokenRefresh(fcmToken, onError);

    LogUtil.devLog(
      "NotificationService",
      message: 'Registering onTokenRefresh handler',
    );

    //To be notified whenever the token is updated, subscribe to the onTokenRefresh stream
    messaging.onTokenRefresh
        .listen(
          (fcmToken_) => _onTokenRefresh(fcmToken_, onError),
        )
        .onError(onError);

    LogUtil.devLog(
      "NotificationService",
      message: 'Registering onOpenedFromTerminated handler',
    );

    // Get any messages which caused the application to open from
    // a terminated state.
    messaging.getInitialMessage().then(
          (value) => value != null ? _onOpenedFromTerminated(value) : () {},
        );

    LogUtil.devLog(
      "NotificationService",
      message: 'Registering onOpenedFromBackground handler',
    );

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _onOpenedFromBackground(message));

    LogUtil.devLog(
      "NotificationService",
      message: 'Registering message handler',
    );

    //To handle messages while your application is in the foreground, listen to the onMessage stream.
    FirebaseMessaging.onMessage
        .listen((message) => _handleForegroundMessages(message));
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    LogUtil.devLog(
      "Notification",
      message: '🔔 Got a message whilst in the background.',
      content: message.toMap().toString(),
    );

    _handleMessage(message);
  }

  static void registerRemoteMethod(
      String method, FutureOr Function(Map<String, dynamic>?) function) {
    LogUtil.devLog(
      "Remote Method Handler",
      message: "Registering remote method [$method]",
    );
    remoteMethods[method] = function;
  }

  static void _onTokenRefresh(
      String fcmToken, Function(Object)? onError) async {
    LogUtil.devLog(
      "FCM",
      message: 'Updating user fcm_token',
      content: fcmToken,
    );

    //TODO: Do something on token refresh
  }

  static void _onOpenedFromTerminated(RemoteMessage message) {
    LogUtil.devLog(
      "Notification",
      message: '🔔 Application opened from terminated state.',
      content: message.toMap().toString(),
    );
    _handleMessage(message);
  }

  static void _onOpenedFromBackground(RemoteMessage message) {
    LogUtil.devLog(
      "Notification",
      message: '🔔 Application opened from background state.',
      content: message.toMap().toString(),
    );

    _handleMessage(message);
  }

  static void _handleForegroundMessages(RemoteMessage message) {
    LogUtil.devLog(
      "Notification",
      message: '🔔 Got a message whilst in the foreground.',
      content: message.toMap().toString(),
    );

    _handleMessage(message);
  }

  static void _handleMessage(RemoteMessage message) async {
    final method = message.data["method"] as String?;

    if (method == null) {
      LogUtil.devLog(
        "Remote Method Handler",
        message: "Notification data is malformed",
      );
      return;
    }

    if (!remoteMethods.containsKey(method)) {
      LogUtil.devLog(
        "Remote Method Handler",
        message: "Remote method [$method] has not been implemented",
      );
      return;
    }

    final methodArgs = message.data["args"] as Map<String, dynamic>?;

    try {
      await Future.value(remoteMethods[method]!.call(methodArgs));
      LogUtil.devLog(
        "Remote Method Handler",
        message: "Remote method successfully invoked",
      );
    } catch (e) {
      LogUtil.devLog(
        "Remote Method Handler",
        message: "Error: $e",
      );
    }
  }
}
