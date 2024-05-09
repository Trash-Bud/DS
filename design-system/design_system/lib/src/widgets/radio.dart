import 'package:design_system/src/colors.dart';
import 'package:flutter/material.dart';

class RadioButton<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final bool disabled;
  final Function(T) onChanged;
  final double size;
  final EdgeInsets? padding;
  final BorderRadius borderRadius;
  final Color? unselectedColor;
  final Color? activeColor;
  final Color? ballColor;
  final Color? disabledColor;
  final Color? borderColor;

  const RadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.disabled = false,
    this.size = 20,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(90)),
    this.unselectedColor,
    this.activeColor,
    this.ballColor,
    this.disabledColor,
    this.borderColor,
  });

  @override
  State<RadioButton<T>> createState() => _RadioButtonState<T>();

  bool get selected {
    return value == groupValue;
  }
}

class _RadioButtonState<T> extends State<RadioButton<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<EdgeInsets> _paddingAnimation;
  late EdgeInsets padding;

  @override
  void didUpdateWidget(RadioButton<T> old) {
    super.didUpdateWidget(old);

    if (widget.selected != old.selected) {
      if (widget.selected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void initState() {
    padding = widget.padding ?? EdgeInsets.all(widget.size / 4);

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    _paddingAnimation =
        EdgeInsetsTween(begin: const EdgeInsets.all(0), end: padding).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn),
    );

    if (widget.selected) {
      _controller.animateTo(1, duration: Duration.zero);
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double borderSize = 2;

    return GestureDetector(
      onTap: () {
        if (!widget.disabled) {
          if (!widget.selected) {
            widget.onChanged(widget.value);
          }
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: widget.size,
              maxWidth: widget.size,
              minHeight: widget.size,
              minWidth: widget.size,
            ),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: widget.disabled
                  ? (widget.disabledColor ?? appDisableGrey)
                  : (widget.selected || _controller.isAnimating
                      ? (widget.activeColor ?? appPrimaryColor)
                      : (widget.unselectedColor ?? appDialogBackgroundColor)),
              border: Border.all(
                color: widget.disabled
                    ? (widget.borderColor ?? appMediumToLightGreyColor)
                    : (widget.selected || _controller.isAnimating
                        ? (widget.activeColor ?? appPrimaryColor)
                        : (widget.borderColor ?? appMediumToLightGreyColor)),
                width: borderSize,
              ),
              borderRadius: widget.borderRadius,
            ),
            child: Align(
              alignment: Alignment.center,
              child: widget.selected || _controller.isAnimating
                  ? Padding(
                      padding: _paddingAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.ballColor ?? appDialogBackgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(90)),
                        ),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
