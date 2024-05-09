import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppTabBar extends PreferredSize {
  AppTabBar({
    super.key,
    required tabs,
    size = 80.0,
  }) : super(
            preferredSize: Size.fromHeight(size),
            child: AppBar(
              backgroundColor: appPrimaryColor,
              foregroundColor: appVeryLightGreyColor,
              surfaceTintColor: appVeryLightGreyColor,
              bottom: TabBar(
                tabs: tabs,
                labelColor: const Color.fromARGB(255, 255, 255, 255),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                    width: 2.0,
                  ),
                ),
              ),
            ));
}
