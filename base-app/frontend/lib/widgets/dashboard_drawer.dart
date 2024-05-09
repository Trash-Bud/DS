import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/login_page.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/widgets/collapsible_text_button_icon.dart';
import 'package:frontend/widgets/web_view_page.dart';

import '../dashboard_item.dart';
import 'dashboard_item_button.dart';

class DashboardDrawer extends StatefulWidget {
  final double minWidth;
  final double maxWidth;
  final Duration animationDuration;
  final Future<String>? servicesJson;
  final Widget? emblem;
  final Widget? logo;
  final String loggedUserName;
  final GlobalKey<WebViewXPageState>? webviewKey;
  const DashboardDrawer(
      {super.key,
      this.minWidth = 70,
      this.maxWidth = 250,
      this.animationDuration = const Duration(milliseconds: 300),
      this.servicesJson,
      this.emblem,
      this.logo,
      this.webviewKey,
      required this.loggedUserName});

  @override
  State<DashboardDrawer> createState() => DashboardDrawerState();
}

@visibleForTesting
class DashboardDrawerState extends State<DashboardDrawer>
    with SingleTickerProviderStateMixin {
  @visibleForTesting
  final List<DashboardItem> items = [];
  late final Future<String> _servicesJson;
  late final AnimationController _animationController;
  late final Animation<double> _widthAnimation;
  late String loggedUserName;
  @visibleForTesting
  bool open = false;
  @visibleForTesting
  int selected = 0;

  DashboardDrawerState();

  @override
  void initState() {
    super.initState();
    loggedUserName = widget.loggedUserName;
    _servicesJson = (widget.servicesJson == null
            ? rootBundle.loadString(path("data/services.local.json"))
            : widget.servicesJson!)
        .then((services) {
      final decodedServices = jsonDecode(services);
      final List<DashboardItem> items = [];

      for (var service in decodedServices) {
        items.add(DashboardItem.fromJson(service));
      }

      this.items.addAll(items);

      widget.webviewKey?.currentState!.setUrl(items[0].url);
        setState(() {
          selected = 0;
        });

      return services;
    });

    _animationController =
        AnimationController(vsync: this, duration: widget.animationDuration)
          ..addListener(() {
            setState(() {});
          });
    _widthAnimation = Tween(begin: widget.minWidth, end: widget.maxWidth)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget layout(BuildContext context, List<Widget> children) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          key: const Key("dashboard-drawer"),
          color: Theme.of(context).dialogBackgroundColor,
          width: _widthAnimation.value,
          constraints: BoxConstraints(
              maxWidth: widget.maxWidth, minWidth: widget.minWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MAERSK LOGO
              CollapsibleTextButtonIcon(
                onPressed: () {},
                icon: widget.emblem ?? Image.asset(path("images/maersk_e.png")),
                iconSize: 32,
                overlayColor: Colors.transparent,
                label: widget.logo ??
                    SvgPicture.asset(
                      path("images/maersk_l.svg"),
                      alignment: Alignment.centerLeft,
                      width: widget.maxWidth - 140,
                    ),
                padding: const EdgeInsets.only(left: 20, top: 13, bottom: 8),
                open: open || (!open && !_animationController.isDismissed),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
              ),

              // CHEVRON
              IconButton(
                key: const Key("drawer-chevron"),
                onPressed: () {
                  setState(() {
                    if (open) {
                      _animationController.reverse();
                    } else {
                      _animationController.forward();
                    }

                    open = !open;
                  });
                },
                icon: open
                    ? const Icon(FontAwesomeIcons.chevronLeft)
                    : const Icon(FontAwesomeIcons.chevronRight),
                iconSize: 26,
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.only(left: 22, bottom: 14),
              ),
              const Divider(
                height: 2,
                thickness: 2,
              ),

              // SERVICE BUTTONS
              Expanded(
                child: ListView(children: children),
              ),
              const Divider(
                height: 2,
                thickness: 2,
              ),

              // LOGIN BUTTON
              DashboardItemButton(
                onPressed: () {
                  if (loggedUserName == "") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  } else {
                    setState(() {
                      loggedUserName = "";
                    });
                  }
                },
                dashboardItem: DashboardItem(
                  icon: loggedUserName == ""
                      ? FontAwesomeIcons.solidUser
                      : FontAwesomeIcons.rightFromBracket,
                  name: loggedUserName == "" ? "Log In" : loggedUserName,
                  url: "localhost:3000",
                ),
                open: open || (!open && !_animationController.isDismissed),
                minWidth: widget.minWidth,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return layout(
              context,
              items.asMap().entries.map<Widget>((entry) {
                int idx = entry.key;

                return DashboardItemButton(
                  key: Key("service-$idx-btn"),
                  onPressed: () {
                    widget.webviewKey?.currentState!.setUrl(entry.value.url);
                    setState(() {
                      selected = idx;
                    });
                  },
                  dashboardItem: entry.value,
                  open: open || (!open && !_animationController.isDismissed),
                  minWidth: widget.minWidth,
                  selected: idx == selected,
                );
              }).toList());
        } else {
          return layout(context, [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ]);
        }
      }),
      future: _servicesJson,
    );
  }
}
