import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/create_overlay/page_header.dart';
import 'package:frontend/view/widgets/create_overlay/create_po_form.dart';

class CreatePoOverlay extends StatelessWidget {
  const CreatePoOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // Container the height of the screen and the
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [CreatePoHeader(), PoForm()],
          )),
    );
  }
}
