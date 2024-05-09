import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/view/widgets/create_overlay/edit_po_utils.dart';

class EditPoForm extends StatefulWidget {
  const EditPoForm(
      {super.key = const Key('editPoForm'), required this.purchaseOrder});

  final PurchaseOrder purchaseOrder;

  @override
  EditPoFormState createState() => EditPoFormState();
}

class EditPoFormState extends State<EditPoForm> {
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
                EditFormTextField(
                    widget.purchaseOrder.name,
                    '',
                    'Name',
                    'editPo-name',
                    'Name*',
                    widget.purchaseOrder.name,
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
                EditFormTextField(
                    widget.purchaseOrder.supplier,
                    '',
                    'Supplier',
                    'editPo-supplier',
                    'Supplier*',
                    widget.purchaseOrder.supplier,
                    [
                      FormBuilderValidators.required(
                          errorText: 'Please enter a supplier'),
                      FormBuilderValidators.minLength(1,
                          errorText:
                              'Please enter a non-empty supplier'),
                      FormBuilderValidators.maxLength(256,
                          errorText:
                              'Please enter a name with at most 256 characters'),
                    ],
                    const Icon(Icons.factory_sharp)),
                EditFormTextField(
                    widget.purchaseOrder.totalItems.toString(),
                    '',
                    'TotalItems',
                    'editPo-total-items',
                    'Items*',
                    widget.purchaseOrder.totalItems.toString(),
                    [
                      FormBuilderValidators.integer(
                          errorText: 'Please enter a whole number'),
                      FormBuilderValidators.required(
                          errorText: 'Please enter a number'),
                      FormBuilderValidators.min(1,
                          errorText: 'Please enter a positive whole number'),
                    ],
                    const Icon(Icons.inventory_sharp)),
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
        'PoIdentification': widget.purchaseOrder.poIdentification
      };
      editPo(widget.purchaseOrder.id, po, context);
    }
  }

  formButtons(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      (!isSmallScreen(context))
          ? GhostButton(
          width: 200,
              title: 'Discard',
              key: const Key('resetPoButton'),
              onPressed: () => _formKey.currentState?.reset())
          : GhostIconButton(
              icon: Icons.cancel_outlined,
              key: const Key('resetPoButton'),
              onPressed: () => _formKey.currentState?.reset()),
      (!isSmallScreen(context))
          ? SecondaryButton(
          width: 200,
              title: 'Edit',
              key: const Key('editPoButton'),
              onPressed: () => submitFunction(context))
          : SecondaryIconButton(
              icon: Icons.check,
              key: const Key('editPoButton'),
              onPressed: () => submitFunction(context)),
    ]);
  }

  void onPressedEditPO(context) {
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
