import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/view/widgets/create_overlay/create_po_utils.dart';

class PoForm extends StatefulWidget {
  const PoForm({super.key = const Key('poForm')});

  @override
  PoFormState createState() => PoFormState();
}

class PoFormState extends State<PoForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  get formKey => _formKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormTextField(
                    '',
                    'Name',
                    'createPo-name',
                    'Name*',
                    'e.g. Azelland_2',
                    [
                      FormBuilderValidators.required(
                          errorText: 'Please enter a name'),
                      FormBuilderValidators.minLength(1,
                          errorText:
                              'Please enter a non-empty name'),
                      FormBuilderValidators.maxLength(256,
                          errorText:
                              'Please enter a name with at most 256 characters'),
                    ],
                    const Icon(Icons.edit)),
                FormTextField(
                    '',
                    'Supplier',
                    'createPo-supplier',
                    'Supplier*',
                    'e.g. Azelland',
                    [
                      FormBuilderValidators.required(
                          errorText: 'Please enter a supplier'),
                      FormBuilderValidators.minLength(1,
                          errorText:
                              'YPlease enter a non-empty supplier'),
                      FormBuilderValidators.maxLength(256,
                          errorText:
                              'Please enter a name with at most 256 characters'),
                    ],
                    const Icon(Icons.factory_sharp)),
                FormTextField(
                    '',
                    'TotalItems',
                    'createPo-total-items',
                    'Items*',
                    'e.g. 10',
                    [
                      FormBuilderValidators.integer(
                          errorText: 'Please enter a whole number'),
                      FormBuilderValidators.required(
                          errorText: 'Please enter a number'),
                      FormBuilderValidators.min(1,
                          errorText: 'Please enter a positive whole number'),
                    ],
                    const Icon(Icons.inventory_sharp)),
                const FormTextField(
                    '',
                    'Identification',
                    'createPo-id',
                    'Identification. Defaults to the name',
                    'e.g. PO#2020-1234',
                    null,
                    Icon(Icons.tag)),
                const SizedBox(height: 50),
                formButtons(context)
              ])),
    );
  }

  submitFunction(context) {
    if (_formKey.currentState!.saveAndValidate()) {
      Navigator.of(context).pop();
      Map<String, dynamic> po = {
        'Name': _formKey.currentState!.value['Name'].trim(),
        'Supplier': _formKey.currentState!.value['Supplier'].trim(),
        'TotalItems': _formKey.currentState!.value['TotalItems'],
        'PoIdentification':
            _formKey.currentState!.value['Identification']?.trim() ??
                _formKey.currentState!.value['Name'].trim(),
      };
      createPo(po, context);
    }
  }

  formButtons(context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isSmallScreen(context))
              ? GhostIconButton(
                  icon: Icons.cancel_outlined,
                  key: const Key('resetPoButton'),
                  onPressed: () => _formKey.currentState?.reset(),
                )
              : GhostButton(
                  width: 200,
                  title: 'Discard',
                  key: const Key('resetPoButton'),
                  onPressed: () => _formKey.currentState?.reset()),
          (isSmallScreen(context))
              ? SecondaryIconButton(
                  icon: Icons.check,
                  key: const Key('createPoButton'),
                  onPressed: () => submitFunction(context),
                )
              : SecondaryButton(
                  width: 200,
                  title: 'Create',
                  key: const Key('createPoButton'),
                  onPressed: () => submitFunction(context)),
        ]);
  }

  void onPressedCreatePO(context) {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
    submitFunction(context);
  }
}

class TextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.trim());
  }
}
