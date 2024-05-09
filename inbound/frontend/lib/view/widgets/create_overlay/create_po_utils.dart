import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/model/page_state.dart';

Future<void> createPo(body, context) async {
  final model = Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
  await model.createPurchaseOrder(body, const {
    'Content-Type': 'application/json',
  });

  SnackBar snackBar = CustomSnackBarLoaded(context, "Successfully created purchase order");
  
  if (model.mainPageRequestSate == PageState.error) {
    snackBar = CustomSnackBarError(context, "Failed to created purchase order: ${model.errorMessage}");
  }

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class FormTextField extends StatelessWidget {
  final String textDescription;
  final String name;
  final String label;
  final String hint;
  final dynamic validators;
  final Icon icon;
  final String textfieldKey;

  const FormTextField(this.textDescription, this.name, this.textfieldKey,
      this.label, this.hint, this.validators, this.icon,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.start,
            textDescription,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        FormBuilderTextField(
          name: name,
          key: Key(textfieldKey),
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            labelText: label,
            filled: true,
            fillColor: const Color(0xffF1F3F5),
            hintText: hint,
            prefixIcon: icon,
          ),
          validator: (validators != null) ? FormBuilderValidators.compose(validators) : null,
        ),
      ],
    );
  }
}
