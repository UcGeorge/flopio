import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:scaled_app/scaled_app.dart';

import 'app/cache_manager.dart';
import 'app/remote_methods.dart';
// import 'firebase_options.dart';
import 'src/alert/alert.dart';
import 'src/splash/splash.flow.dart';
import 'src/splash/splash.view.dart';
import 'util/log.util.dart';

void main() async {
  if (Platform.isAndroid || Platform.isIOS) {
    ScaledWidgetsFlutterBinding.ensureInitialized(
      scaleFactor: (deviceSize) {
        // screen width used in your UI design
        const double widthOfDesign = 375;
        return deviceSize.width / widthOfDesign;
      },
    );
    //? Then, use MediaQueryData.scale to scale size, viewInsets, viewPadding, etc.
    //* class PageRoute extends StatelessWidget {
    //*   const PageRoute({Key? key}) : super(key: key);

    //*   @override
    //*   Widget build(BuildContext context) {
    //*     return MediaQuery(
    //*       data: MediaQuery.of(context).scale(),
    //*       child: const Scaffold(...),
    //*     );
    //*   }
    //* }
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }

  Animate.restartOnHotReload =
      true; //? This makes all animations from flutter_animate restart on hot reload

  LogUtil.init();

  LogUtil.devLog("main", message: "Initializing Cache manager");
  await CacheManager.init();

  // LogUtil.devLog("main", message: "Initializing database manager");
  // await DatabaseManager.init();

  //TODO: Initialize firebase in app
  // LogUtil.devLog("main", message: "Initializing Firebase app");
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  LogUtil.devLog("main", message: "Initializing Remote methods");
  RemoteMethods.init();

  if (Platform.isAndroid || Platform.isIOS) {
    LogUtil.devLog("main", message: "Presetting allowed orientations");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  LogUtil.devLog("main", message: "Running app");
  runApp(const MyApp());

  doWhenWindowReady(() {
    var initialSize = const Size(700, 516);
    appWindow.minSize = initialSize;
    appWindow.title = 'Flopio';
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        }
      },
      child: AlertWrapper(
        app: MaterialApp(
          title: 'Flopio',
          debugShowCheckedModeBanner: false,
          home: Builder(builder: (context) {
            return SplashView(flow: SplashFlow()..init(context));
          }),
        ),
      ),
    );
  }
}
