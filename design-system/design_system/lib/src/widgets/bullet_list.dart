import 'package:design_system/src/widgets/bullet_item.dart';
import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  final List<BulletItem> _items;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final EdgeInsets? bulletPadding;
  final EdgeInsets? itemPadding;

  BulletList({
    super.key,
    List<Text> items = const [],
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.itemPadding,
    this.bulletPadding,
  }) : _items = items
            .map((e) => BulletItem(
                  content: e,
                  padding: itemPadding,
                  bulletPadding: bulletPadding,
                ))
            .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: _items,
    );
  }
}
