import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/table_pagination_controller.dart';
import 'package:frontend/view/widgets/table_and_lists/table_footer.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final PaginationInfo paginationInfo;
  final Function(int)? onRowTap;

  const CustomDataTable(
      {super.key,
      required this.headers,
      required this.rows,
      required this.paginationInfo,
      required this.onRowTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (buildTable(context)),
                (TableFooter(paginationInfo: paginationInfo))
              ],
            )));
  }

  Widget buildTable(BuildContext context) {
    return SizedBox(
        height: 700,
        child: AppDataTable(
          onRowTap: (int index) {
            if(onRowTap != null) onRowTap!(index);
          },
          columnNames: headers,
          columnGap: 50,
          rowGap: 20,
          dataRowMinHeight: 120,
          rows: rows,
        ));
  }

  List<DataColumn> getColumns(context, List<String> headers) {
    return headers
        .map((header) => DataColumn(
              numeric: false,
              label: Text(
                textAlign: TextAlign.center,
                header,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff6C757D)),
              ),
            ))
        .toList();
  }
}
