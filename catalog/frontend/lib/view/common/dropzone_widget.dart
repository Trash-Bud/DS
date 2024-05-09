import 'package:frontend/model/uploaded_file.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:frontend/view/common/utils.dart';

// ignore: must_be_immutable
class DropzoneWidget extends StatefulWidget {
  List<String> acceptableMimeTypes;
  String wrongExtensionMessage;

  DropzoneWidget(this.acceptableMimeTypes, this.wrongExtensionMessage, {super.key});
  
  UploadedFile? file;
  bool highlight = false;

  @override
  DropzoneWidgetState createState() => DropzoneWidgetState();
}

class DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    Widget dropzoneContent = widget.file == null ? emptyDropzone() : filledDropzone();

    return buildDecoration(
      child: Stack(
        children: [
          DropzoneView(
              onCreated: (controller) => this.controller = controller,
              onDrop: acceptFile),
          GestureDetector(
            onTap: () async {
              final events = await controller.pickFiles();
              if (events.isEmpty) return;

              acceptFile(events.first);
            },
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Center(
                  child: dropzoneContent,
                ))),
        ],
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final name = await controller.getFilename(event);
    final mime = await controller.getFileMIME(event);
    final data = await controller.getFileData(event);
    if (!widget.acceptableMimeTypes.contains(mime)) {
      // ignore: use_build_context_synchronously
      showStandardDialog(context, "Information", widget.wrongExtensionMessage);
      return;
    }

    setState(() {
      widget.file = UploadedFile(name, mime, data);
      widget.highlight = true;
    });
  }

  Widget buildDecoration({required Widget child}) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Container(
            padding: const EdgeInsets.all(15),
            color: widget.highlight
                ? const Color.fromARGB(255, 219, 237, 251)
                : Colors.white,
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: Colors.grey,
              strokeWidth: 1,
              dashPattern: const [5, 5],
              radius: const Radius.circular(0),
              padding: EdgeInsets.zero,
              child: child,
            )));
  }

  Widget filledDropzone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.blue),
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.file!.name)),
      ],
    );
  }

  Widget emptyDropzone() {
    String message = 'Drag & drop files here or choose file';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.cloud_upload,
          size: 20,
          color: Colors.black,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            )),
      ],
    );
  }
}
