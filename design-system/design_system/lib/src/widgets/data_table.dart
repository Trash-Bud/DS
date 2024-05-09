import 'dart:math';

import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class AppDataTable extends StatelessWidget {
  final List<String> columnNames;
  final List<List<Widget>> rows;
  final Color headerColor;
  final Color onHeaderColor;
  final Color rowColor;
  final Color hoveredRowColor;
  final double rowGap;
  final double columnGap;
  final EdgeInsetsGeometry rowPadding;
  final double? headerTextSize;
  final double? headerRowMinHeight;
  final double? dataRowMinHeight;
  final Function(int)? onRowTap;

  const AppDataTable(
      {super.key,
      required this.columnNames,
      required this.rows,
      this.headerColor = appLightGreyColor,
      this.onHeaderColor = appDarkColor,
      this.rowColor = appVeryLightGreyColor,
      this.hoveredRowColor = appLightGreyColor,
      this.rowGap = 10,
      this.columnGap = 10,
      this.rowPadding = const EdgeInsets.fromLTRB(15, 10, 15, 10),
      this.headerTextSize,
      this.headerRowMinHeight,
      this.dataRowMinHeight,
      this.onRowTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headerRowMinHeight == null
            ? _tableHeader(columnNames, context)
            : ConstrainedBox(
                constraints: BoxConstraints(minHeight: headerRowMinHeight!),
                child: _tableHeader(columnNames, context)),
        Padding(
          padding: EdgeInsets.only(bottom: rowGap),
        ),
        _tableRows(context),
      ],
    );
  }

  Widget _tableHeader(List<String> columnNames, context) {
    List<Widget> children = [];
    for (int i = 0; i < columnNames.length; i++) {
      children.add(Expanded(
          child: Text(
        columnNames[i],
        style: titleLargeStyle.copyWith(
            color: onHeaderColor, fontSize: headerTextSize),
      )));
      if (i < columnNames.length - 1) {
        children.add(SizedBox(
          width: columnGap,
        ));
      }
    }

    return Container(
      color: headerColor,
      padding: rowPadding,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: children,
      ),
    );
  }

  Widget _tableRows(context) {
    List<Widget> children = [];
    rows.asMap().forEach((index, row) {
      List<Widget> columns =
          row.sublist(0, min(columnNames.length, row.length));
      while (columns.length < columnNames.length) {
        columns.add(Container());
      }

      Widget tableRow = _AppDataTableRow(
          columns: columns,
          rowColor: rowColor,
          hoveredRowColor: hoveredRowColor,
          rowPadding: rowPadding,
          columnGap: columnGap,
          onRowTap: () {
            if (onRowTap != null) {
              onRowTap!(index);
            }
          });
      children.add(dataRowMinHeight == null
          ? tableRow
          : ConstrainedBox(
              constraints: BoxConstraints(minHeight: dataRowMinHeight!),
              child: tableRow));

      if (index < rows.length - 1) {
        children.add(Padding(padding: EdgeInsets.only(bottom: rowGap)));
      }
    });

    return Expanded(child: ListView(children: children));
  }
}

class _AppDataTableRow extends StatefulWidget {
  final List<Widget> columns;
  final Color rowColor;
  final Color hoveredRowColor;
  final EdgeInsetsGeometry rowPadding;
  final double columnGap;
  final Function onRowTap;

  const _AppDataTableRow(
      {required this.columns,
      required this.rowColor,
      required this.hoveredRowColor,
      required this.rowPadding,
      required this.columnGap,
      required this.onRowTap});

  @override
  _AppDataTableRowState createState() => _AppDataTableRowState();
}

class _AppDataTableRowState extends State<_AppDataTableRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.columns.length; i++) {
      children.add(Expanded(child: widget.columns[i]));
      if (i < widget.columns.length - 1) {
        children.add(SizedBox(
          width: widget.columnGap,
        ));
      }
    }

    return InkWell(
      onTap: () => widget.onRowTap(),
      onHover: (isHovered) => setState(() => _isHovered = isHovered),
      child: Container(
        color: _isHovered ? widget.hoveredRowColor : widget.rowColor,
        padding: widget.rowPadding,
        child: Row(children: children),
      ),
    );
  }
}
