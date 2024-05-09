import 'dart:math';

import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class Pager extends StatefulWidget {
  final int totalPages;
  final Function(int) onPageChanged;
  final int startPage;
  final int numberOfVisiblePages;
  final double buttonSize;
  final double labelSize;
  final double arrowSize;
  final Color activeButtonColor;
  final Color inactiveButtonColor;
  final Color onActiveButtonColor;
  final Color onInactiveButtonColor;
  final Color arrowColor;

  const Pager({
    Key? key,
    required this.totalPages,
    required this.onPageChanged,
    this.numberOfVisiblePages = 5,
    this.buttonSize = 40,
    this.labelSize = 18,
    this.arrowSize = 25,
    this.activeButtonColor = appPrimaryColor,
    this.inactiveButtonColor = appMediumGreyColor,
    this.onActiveButtonColor = appVeryLightGreyColor,
    this.onInactiveButtonColor = appVeryLightGreyColor,
    this.arrowColor = appMediumGreyColor,
    this.startPage = 1,
  }) : super(key: key);

  @override
  PagerState createState() => PagerState();
}

class PagerState extends State<Pager> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _currentPage =
        (widget.startPage > 0 && widget.startPage <= widget.totalPages)
            ? widget.startPage
            : _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    var firstPage = max(
        1,
        min(_currentPage - (widget.numberOfVisiblePages / 2).floor(),
            widget.totalPages - widget.numberOfVisiblePages + 1));

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildArrow("‹", -1),
      ...List.generate(
        min(widget.numberOfVisiblePages, widget.totalPages - firstPage + 1),
        (index) => _buildPageIndicator(firstPage + index),
      ),
      _buildArrow("›", 1),
    ]);
  }

  Widget _buildPageIndicator(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _currentPage = index;
          });
          widget.onPageChanged(index);
        },
        child: AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: widget.buttonSize,
          width: widget.buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? widget.activeButtonColor
                : widget.inactiveButtonColor,
          ),
          duration: const Duration(milliseconds: 200),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: widget.labelSize,
                  color: _currentPage == index
                      ? widget.onActiveButtonColor
                      : widget.onInactiveButtonColor,
                ),
                index.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  Widget _buildArrow(String arrowString, int onClickDiff) {
    bool displayArrow = (onClickDiff > 0 && _currentPage < widget.totalPages) ||
        (onClickDiff < 0 && _currentPage > 1);
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (_currentPage + onClickDiff < 1 ||
              _currentPage + onClickDiff > widget.totalPages) {
            return;
          }
          setState(() {
            _currentPage += onClickDiff;
          });
          widget.onPageChanged(_currentPage);
        },
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: widget.buttonSize,
            width: widget.buttonSize,
            child: displayArrow
                ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          style: bodyMediumStyle.copyWith(
                              color: widget.arrowColor,
                              fontSize: widget.arrowSize,
                              fontWeight: FontWeight.w900),
                          arrowString,
                          textAlign: TextAlign.center,
                        )))
                : null));
  }
}
