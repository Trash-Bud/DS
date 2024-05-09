import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/table_pagination_controller.dart';
import 'package:design_system/design_system.dart';

class TableFooter extends StatefulWidget {
  final PaginationInfo paginationInfo;

  const TableFooter({required this.paginationInfo, super.key});

  @override
  TableFooterState createState() => TableFooterState();
}

class TableFooterState extends State<TableFooter> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.only(top: 5),
        height: 50,
        child: Pager(
            buttonSize: 40,
            totalPages: widget.paginationInfo.getTotalPages(),
            onPageChanged: (int page) {
              widget.paginationInfo.fetchPage(page);
            }),
      );
  }
}
