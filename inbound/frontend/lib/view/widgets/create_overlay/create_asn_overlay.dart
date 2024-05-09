import 'package:design_system/design_system.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/model/page_state.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/utils/theme.dart';
import 'package:provider/provider.dart';

class CreateAsnOverlay extends StatelessWidget {
  final Function() notifyParent;
  final PurchaseOrder? purchaseOrder;

  const CreateAsnOverlay(
      {super.key, this.purchaseOrder, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    // Container the height of the screen and the
    return Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Upload a file to create a new ASN entry",
                        style:
                            bodyLargeStyle),
                  ),
                  const SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, foregroundColor: appPrimaryColor),
                        onPressed: () => onPressedDownload(context),
                        child: const Text(
                            "Download a Template .xlsx file to view an example of the format required.",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ))),
                  ),
                  const SizedBox(height: 10,),
                  Center(child: AsnForm(purchaseOrder: purchaseOrder, notifyParent: notifyParent))
                ],
              );
  }

  Future<void> onPressedDownload(context) async {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
    _downloadAsnTemplate(context);
  }

  Widget getPageHeader(BuildContext context) {
    // row with columns one with CreatePurchaseOrder the other with close icon
    return Container(
      // margin bottom
      margin: const EdgeInsets.only(bottom: 40),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: Color(0xffF1F3F5)),
        ),
      ),
      // align the text to the left
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Text(
              "Create ASN",
              style: (isSmallScreen(context))
                  ? Theme.of(context).textTheme.headline6
                  : Theme.of(context).textTheme.headline5,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class AsnForm extends StatefulWidget {
  const AsnForm(
      {super.key = const Key('asnForm'),
      this.purchaseOrder,
      required this.notifyParent});

  final Function() notifyParent;
  final PurchaseOrder? purchaseOrder;

  @override
  AsnFormState createState() => AsnFormState();
}

class AsnFormState extends State<AsnForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  get formKey => _formKey;

  Future<FilePickerCross> fileRetriever() {
    return FilePickerCross.importFromStorage(
        type: FileTypeCross.any, fileExtension: '.xlsx');
  }

  Future<PageState> uploadFile(
      AsnChangeNotifier model, Future<FilePickerCross> file) async {
    await file.then((value) async =>
    {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context)),
      await model.uploadAsnFile(
          value.toUint8List(),
          widget.purchaseOrder == null
              ? null
              : widget.purchaseOrder!.id.toString())});
    return model.mainPageRequestSate;
  }

  void _pickFile() async {
    final model = Provider.of<AsnChangeNotifier>(context, listen: false);
    Future<FilePickerCross> file = fileRetriever();

    await uploadFile(model, file).then((state) {
      SnackBar snackBar = CustomSnackBarLoading(context);
      if (state == PageState.error) {
        snackBar = CustomSnackBarError(context, model.errorMessage);

      } else if (state == PageState.loaded) {
        snackBar = CustomSnackBarLoaded(context, "Successfully uploaded file");

      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    widget.notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
        onPressed: () => onPressedPickFile(),
        title: "Select file from device");
  }

  Future<void> onPressedPickFile() async {
    _pickFile();
  }
}

Future<void> _downloadAsnTemplate(context) async {
  final model =
  Provider.of<AsnChangeNotifier>(context, listen: false);
  await model.downloadAsnTemplate();

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  if (model.mainPageRequestSate == PageState.error) {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarError(
        context, "Failed to download ASN template: ${model.errorMessage}"));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoaded(
      context, "Successfully downloaded ASN template"));
  }
}
