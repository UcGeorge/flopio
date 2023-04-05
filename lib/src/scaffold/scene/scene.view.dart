import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../data/models/book.dart';
import '../../../state/book.state.dart';
import '../../../util/screen.util.dart';
import '../../book/book.flow.dart';
import '../../book/book.view.dart';
import '../../drawer/drawer.view.dart';

class SceneView extends StatelessWidget {
  const SceneView({
    super.key,
    required this.startExpanded,
    required this.body,
  });

  final Widget body;
  final bool? startExpanded;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Book?>(
      stream: BookState.state.stream,
      initialData: BookState.state.value,
      builder: (context, state) {
        return Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  WindowTitleBarBox(child: MoveWindow()),
                  Expanded(
                    child: Hero(
                      tag: 'app-drawer',
                      child: AppDrawer(
                        startExpanded: startExpanded,
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: state.data != null
                    ? ScreenUtil.screenSize(context).width >= 1360
                    : true,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.thisWhite.withOpacity(.3),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: state.data != null
                            ? const Radius.circular(10)
                            : Radius.zero,
                      ),
                    ),
                    child: body,
                  ),
                ),
              ),
              if (state.data != null &&
                  ScreenUtil.screenSize(context).width < 1360)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.thisWhite.withOpacity(.15),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: BookDetailsView(
                      flow: BookFlow(),
                    ),
                  ),
                ),
              AnimatedContainer(
                width: (state.data != null &&
                        !(ScreenUtil.screenSize(context).width < 1360))
                    ? 600
                    : 0,
                padding: const EdgeInsets.all(24),
                margin: state.data != null
                    ? const EdgeInsets.only(left: 10)
                    : EdgeInsets.zero,
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  color: AppColors.thisWhite.withOpacity(.15),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: state.data != null
                    ? BookDetailsView(
                        flow: BookFlow(),
                      )
                    : const SizedBox.expand(),
              ),
            ],
          ),
        );
      },
    );
  }
}
