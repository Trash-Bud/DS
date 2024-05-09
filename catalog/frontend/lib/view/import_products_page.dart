import 'dart:convert';

import 'package:frontend/controller/network.dart';
import 'package:frontend/controller/providers/brands_provider.dart';
import 'package:frontend/controller/providers/products_provider.dart';
import 'package:frontend/model/brand.dart';
import 'package:frontend/view/common/base_page.dart';
import 'package:frontend/view/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/common/dropzone_widget.dart';
import 'package:provider/provider.dart';

class ImportPage extends StatefulWidget {
  static const String route = '/variants/import';
  const ImportPage({super.key});

  @override
  ImportProductStage createState() => ImportProductStage();
}

class ImportProductStage extends State<ImportPage> {
  final acceptableMimeTypes = [
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  ];
  final wrongExtensionMessage =
      'Wrong file extension! Please use .xlsx or .xls';
  @override
  Widget build(BuildContext context) {
    final dropzoneWidget =
        DropzoneWidget(acceptableMimeTypes, wrongExtensionMessage);
    return BasePage(
        content: Column(children: [
      _pageTitle(),
      _dropzone(dropzoneWidget),
      _downloadTemplate(),
      _uploadButton(
          dropzoneWidget, context.watch<BrandsProvider>().currentBrand)
    ]));
  }

  Widget _pageTitle() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Import Products",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      );

  Widget _dropzone(DropzoneWidget dropzoneWidget) => Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: SizedBox(height: 150, child: dropzoneWidget));

  Widget _downloadTemplate() => Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: TextButton(
            child: const Text(
                'Download a template .xls file to view an example of the format required'),
            onPressed: () {
              downloadFile('variants/template');
            },
          ))
        ],
      ));

  Widget _uploadButton(DropzoneWidget dropzoneWidget, Brand selectedBrand) {
    return ElevatedButton(
        onPressed: () async {
          if (dropzoneWidget.file == null) {
            showStandardDialog(context, "Information", "No file selected");
            return;
          }
          postBackendMultipart('variants/import', dropzoneWidget.file!.data,
                  dropzoneWidget.file!.name, dropzoneWidget.file!.mime,
                  query: {'brandId': selectedBrand.id.toString()})
              .then((response) => {
                    if (responseIsOk(response))
                      {
                        Provider.of<ProductsProvider>(context, listen: false)
                            .getAllProducts(force: true),
                        showStandardDialog(context, "Information",
                            "Products imported successfully!"),
                      }
                    else
                      {
                        showStandardDialog(
                            context,
                            "Information",
                            response.statusCode == 415
                                ? wrongExtensionMessage
                                : json.decode(response.body)['error'] ??
                                    "Unknown error")
                      },
                    setState(() {
                      dropzoneWidget.file = null;
                      dropzoneWidget.highlight = false;
                    })
                  });
        },
        child: const Text('Submit'));
  }
}
