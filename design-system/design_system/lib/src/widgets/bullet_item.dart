import 'package:flutter/cupertino.dart';

class BulletItem extends StatelessWidget {
  final Text content;
  final EdgeInsets _bulletPadding;
  final EdgeInsets _padding;

  const BulletItem({
    super.key,
    required this.content,
    EdgeInsets? bulletPadding,
    EdgeInsets? padding,
  })  : _bulletPadding =
            bulletPadding ?? const EdgeInsets.only(left: 12, right: 10),
        _padding = padding ?? const EdgeInsets.all(0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: _bulletPadding,
            child: const Text("\u2022"),
          ),
          content,
        ],
      ),
    );
  }
}
