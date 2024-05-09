import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class SmallCard extends StatelessWidget {
  final Color barColor;
  final Function? onTap;
  final bool isStrikeThrough;
  final List<String> textContent; // [title, ... other texts]
  final List<Widget> widgetContent;
  final int textFlexParam;
  final int widgetFlexParam;

  TextDecoration strikethroughText() {
    return (isStrikeThrough) ? TextDecoration.lineThrough : TextDecoration.none;
  }

  const SmallCard(
      {super.key,
      this.onTap,
      required this.barColor,
      required this.textContent,
      required this.widgetContent,
      this.textFlexParam = 3,
      this.widgetFlexParam = 1,
      this.isStrikeThrough = false});

  @override
  Widget build(BuildContext context) {
    return getCard(context);
  }

  Widget getCard(context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => {if (onTap != null) onTap!()},
        child: _getClipArtCard(context),
      ),
    );
  }

  Widget _getClipArtCard(context) {
    return ClipPath(
        clipper: _getShapeBorderClipper(),
        child: Container(
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: barColor, width: 10))),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: _getCardContent(context)));
  }

  Widget _getCardContent(context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          (textContent.isEmpty) ? Container()
              : Flexible(
            flex: textFlexParam,
            child: FittedBox(
                fit: BoxFit.fill,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _getTextContent(context))),
          ),
          (widgetContent.isEmpty) ? Container()
              : Flexible(
            flex: widgetFlexParam,
            child: Column(children: _getWidgetContent(context)),
          )
        ]);
  }

  List<Widget> _getWidgetContent(context) {
    return widgetContent;
  }

  List<Widget> _getTextContent(BuildContext context) {
    return [
      _getTextRow(textContent[0], context, true),
      ...textContent.sublist(1).map((text) => _getTextRow(text, context, false))
    ];
  }

  Row _getTextRow(text, context, isBold) {
    TextStyle style = (isBold) ? labelLargeStyle : labelMediumStyle;

    return Row(children: [
      Text(
        text,
        overflow: TextOverflow.fade,
        style: style.copyWith(
          decoration: strikethroughText(),
          color: (isBold) ? appDarkColor : appMediumGreyColor,
          fontWeight: (isBold) ? FontWeight.bold : FontWeight.normal,
        ),
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.left,
      )
    ]);
  }

  ShapeBorderClipper _getShapeBorderClipper() {
    return ShapeBorderClipper(
        textDirection: TextDirection.ltr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
  }
}
