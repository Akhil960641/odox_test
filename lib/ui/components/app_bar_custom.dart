
import 'package:flutter/material.dart';
import 'package:odox_test/ui/components/app_text.dart';

import '../../utils/colors.dart';
import '../../utils/shared/page_navigator.dart';

class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppbar(
      {super.key,
      this.isHomePage = false,
      this.elevetion,
      this.title,
      this.backgroundColor,
      this.ontap,
      this.isBackBtn = false,
      this.actions});

  final bool isHomePage, isBackBtn;
  final String? title;
  final List<Widget>? actions;
  final double? elevetion;
  final Color? backgroundColor;
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: elevetion ?? 2,
        backgroundColor: backgroundColor ?? colorWhite,
        titleSpacing: isBackBtn ? 0 : 5,
        automaticallyImplyLeading: false,
        shadowColor: Colors.black38,
        leading: isHomePage
            ? Padding(
                padding: const EdgeInsets.only(left: 14, bottom: 18, top: 8),
                child: IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                )
                // AppSvg(
                //   assetName: "Mask group",
                // ),
                )
            : Padding(
                padding: const EdgeInsets.only(left: 14, bottom: 10, top: 18),
                child: GestureDetector(
                    onTap: () {
                      Screen.close(context);
                    },
                    child: const Icon(Icons.arrow_back)),
              ),
        //  const AppSvg(
        //   assetName: "arrow-left",
        // ),

        // : null,
        title: AppText(
          title,
          maxLines: 2,
          color: Colors.black,
          weight: FontWeight.w600,
          size: 15,
        ),
        // centerTitle: isBackBtn,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
