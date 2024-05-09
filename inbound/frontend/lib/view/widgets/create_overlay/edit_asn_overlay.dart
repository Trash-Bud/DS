import 'package:flutter/material.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/view/widgets/create_overlay/edit_asn_form.dart';
import 'package:frontend/view/widgets/create_overlay/page_header.dart';

class EditAsnOverlay extends StatelessWidget {
  const EditAsnOverlay({super.key, required this.asn});

  final Asn asn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [EditAsnHeader(asn: asn), EditAsnForm(asn: asn)],
          )),
    );
  }
}