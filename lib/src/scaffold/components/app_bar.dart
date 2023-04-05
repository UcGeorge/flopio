import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../app/resumable_flow.dart';
import '../../../state/navigation.state.dart';
import '../../../util/screen.util.dart';
import 'nav_buttons.dart';

class ShenAppBar extends StatefulWidget {
  const ShenAppBar({Key? key}) : super(key: key);

  @override
  State<ShenAppBar> createState() => _ShenAppBarState();
}

class _ShenAppBarState extends State<ShenAppBar> {
  bool isConnected = false;

  @override
  void initState() {
    initConnection();
    super.initState();
  }

  initConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        isConnected = true;
      });
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          if (result == ConnectivityResult.none) {
            isConnected = false;
          } else {
            isConnected = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appWindow.titleBarHeight,
      width: ScreenUtil.screenSize(context).width < 1200
          ? 400
          : ScreenUtil.screenSize(context).width / 3,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.blueGrey.withOpacity(.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            const NavButtons(),
            const Spacer(),
            StreamBuilder<ResumableFlow>(
              stream: NavigationState.state.stream,
              initialData: NavigationState.state.value,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data!.flowName,
                  style: AppFonts.nunito.copyWith(
                    color: AppColors.white,
                  ),
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: 44,
              child: !isConnected
                  ? Icon(
                      Icons.wifi_off_rounded,
                      size: 20,
                      color: AppColors.red,
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
