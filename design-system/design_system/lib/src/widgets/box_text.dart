import 'package:flutter/material.dart';

import '../colors.dart';
import '../styles/styles.dart';

class BoxText extends StatelessWidget {
  final String text;
  final TextStyle style;

  BoxText.displayLarge(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style = displayLargeStyle.copyWith(
            color: color, decoration: textDecoration);

  BoxText.displayMedium(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style = displayMediumStyle.copyWith(
            color: color, decoration: textDecoration);

  BoxText.displaySmall(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style = displaySmallStyle.copyWith(
            color: color, decoration: textDecoration);

  BoxText.headlineLarge(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style = headlineLargeStyle.copyWith(
            color: color, decoration: textDecoration);

  BoxText.headlineMedium(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style = headlineMediumStyle.copyWith(
            color: color, decoration: textDecoration);

  BoxText.headlineSmall(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style = headlineSmallStyle.copyWith(
            color: color, decoration: textDecoration);

  BoxText.titleLarge(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            titleLargeStyle.copyWith(color: color, decoration: textDecoration);

  BoxText.titleMedium(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            titleMediumStyle.copyWith(color: color, decoration: textDecoration);

  BoxText.titleSmall(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            titleSmallStyle.copyWith(color: color, decoration: textDecoration);

  BoxText.labelLarge(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            labelLargeStyle.copyWith(color: color, decoration: textDecoration);

  BoxText.labelMedium(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            labelMediumStyle.copyWith(color: color, decoration: textDecoration);

  BoxText.labelSmall(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            labelSmallStyle.copyWith(color: color, decoration: textDecoration);

  BoxText.bodyLarge(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            bodyLargeStyle.copyWith(color: color, decoration: textDecoration);

  BoxText.bodyMedium(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            bodyMediumStyle.copyWith(color: color, decoration: textDecoration);

  BoxText.bodySmall(this.text,
      {Color color = appDarkColor,
      textDecoration = TextDecoration.none,
      super.key})
      : style =
            bodySmallStyle.copyWith(color: color, decoration: textDecoration);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
