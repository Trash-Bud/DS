import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/table_pagination_controller.dart';
import 'package:frontend/view/widgets/table_and_lists/table_footer.dart';

class CustomListSmall extends StatelessWidget {
  final Widget colorCaption;
  final Function card;
  final PaginationInfo paginationInfo;
  final int itemCount;

  const CustomListSmall({
    super.key,
    required this.colorCaption,
    required this.card,
    required this.paginationInfo,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: buildList(context)),
          Container(
              // align to the bottom of the column
              alignment: Alignment.bottomCenter,
              height: 60,
              child: TableFooter(paginationInfo: paginationInfo))
        ]);
  }

  Widget buildList(BuildContext context) {
    // list with color caption and list of cards
    return Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05),
        child: ListView.builder(
            itemCount: itemCount + 1,
            itemBuilder: (context, index) {
              if (index == 0) return colorCaption;
              return card(index - 1, context);
            }));
  }
}
