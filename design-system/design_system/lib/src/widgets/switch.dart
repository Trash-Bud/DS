import 'package:design_system/src/colors.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {
  final bool value;
  final bool disabled;
  final Function(bool) onChanged;
  final double width;
  final double height;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Color? unselectedTrackColor;
  final Color? selectedTrackColor;
  final Color? ballColor;
  final Color? disabledTrackColor;
  final Color? disabledBallColor;
  final Color? borderColor;

  const SwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
    this.disabled = false,
    this.width = 35,
    this.height = 20,
    this.padding = const EdgeInsets.all(1),
    this.borderRadius = const BorderRadius.all(Radius.circular(90)),
    this.unselectedTrackColor,
    this.selectedTrackColor,
    this.ballColor,
    this.disabledBallColor,
    this.disabledTrackColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    double borderSize = 2;
    double ballHeight =
        height - padding.top - padding.bottom - (borderSize * 2);

    return GestureDetector(
      onTap: () {
        if (!disabled) {
          onChanged(!value);
        }
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: height,
          maxWidth: width,
          minHeight: height,
          minWidth: width,
        ),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: disabled
              ? (disabledTrackColor ?? appDisableGrey)
              : (value
                  ? (selectedTrackColor ?? appPrimaryColor)
                  : (unselectedTrackColor ?? appMediumToLightGreyColor)),
          border: Border.all(
            color: disabled
                ? (borderColor ?? appMediumToLightGreyColor)
                : (value
                    ? (selectedTrackColor ?? appPrimaryColor)
                    : (borderColor ?? appMediumToLightGreyColor)),
            width: borderSize,
          ),
          borderRadius: borderRadius,
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: padding,
            child: Container(
              constraints: BoxConstraints(
                minWidth: ballHeight,
                maxWidth: ballHeight,
              ),
              decoration: BoxDecoration(
                color: disabled
                    ? (disabledBallColor ?? appMediumToLightGreyColor)
                    : (ballColor ?? appDialogBackgroundColor),
                borderRadius: const BorderRadius.all(Radius.circular(90)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
