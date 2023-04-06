import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/assets.dart';
import '../../app/colors.dart';
import '../../app/resumable_flow.dart';
import '../../state/navigation.state.dart';
import '../components/logo.dart';
import 'components/drawer_tile.dart';
import 'services/drawer.service.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, this.startExpanded}) : super(key: key);

  final bool? startExpanded;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late bool expanded;
  String hovered = 'null';

  @override
  void initState() {
    super.initState();
    expanded = widget.startExpanded ?? false;
  }

  void _setHovered(String hover) {
    setState(() {
      hovered = hover;
    });
  }

  AnimatedCrossFade _buildLogo() {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 100),
      firstChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            const ShenKuLogo(18),
            const SizedBox(width: 10),
            SvgPicture.asset(
              AppSVG.shenKuSvg,
              height: 22,
              color: AppColors.thisWhite,
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_backspace_rounded,
              color: AppColors.lessWhite,
            ),
          ],
        ),
      ),
      secondChild: const ShenKuLogo(18),
      crossFadeState:
          expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  Padding _buildDivider() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Divider(
        color: AppColors.white.withOpacity(.15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MouseRegion(
        // cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() {
          expanded = true;
        }),
        onExit: (e) => setState(() {
          expanded = false;
        }),
        child: AnimatedContainer(
          height: double.infinity,
          width: expanded ? 260.0 : 92,
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: AppColors.dark,
          ),
          child: StreamBuilder<ResumableFlow>(
            stream: NavigationState.state.stream,
            initialData: NavigationState.state.value,
            builder: (_, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(),
                  _buildDivider(),
                  Center(
                    child: AppDrawerTile(
                      title: "home",
                      expanded: expanded,
                      onTap: state.data!.flowName == "home"
                          ? () {}
                          : () => DrawerService.goToHome(context),
                      selected: state.data!.flowName == "home",
                      hovered: hovered == "home",
                      setHoverState: (value) => _setHovered(value),
                      iconPath: AppSVG.homeSvg,
                      selectedIconPath: AppSVG.homeBoldSvg,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: AppDrawerTile(
                      title: "explore",
                      expanded: expanded,
                      onTap: state.data!.flowName == "explore"
                          ? () {}
                          : () => DrawerService.goToExplore(context),
                      selected: state.data!.flowName == "explore",
                      hovered: hovered == "explore",
                      setHoverState: (value) => _setHovered(value),
                      iconPath: AppSVG.searchSvg,
                      selectedIconPath: AppSVG.searchBoldSvg,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: AppDrawerTile(
                      title: "library",
                      expanded: expanded,
                      onTap: state.data!.flowName == "library"
                          ? () {}
                          : () => DrawerService.goToLibrary(context),
                      selected: state.data!.flowName == "library",
                      hovered: hovered == "library",
                      setHoverState: (value) => _setHovered(value),
                      iconPath: AppSVG.bookmarkSvg,
                      selectedIconPath: AppSVG.bookmarkBoldSvg,
                    ),
                  ),
                  _buildDivider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
