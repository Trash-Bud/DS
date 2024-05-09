import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/view/widgets/create_overlay/edit_asn_utils.dart';

class EditAsnForm extends StatefulWidget {
  const EditAsnForm({super.key = const Key('editPoForm'), required this.asn});

  final Asn asn;

  @override
  EditAsnFormState createState() => EditAsnFormState();
}

class EditAsnFormState extends State<EditAsnForm> {
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
                    widget.asn.warehouse != null ? widget.asn.warehouse.toString() : "",
                    '',
                    'Warehouse',
                    'editAsn-warehouse',
                    'Warehouse*',
                    widget.asn.warehouse != null ? widget.asn.warehouse.toString() : "",
                    [
                      FormBuilderValidators.required(
                          errorText: 'Please enter a warehouse name'),
                      FormBuilderValidators.minLength(1,
                          errorText:
                          'Please enter a non-empty warehouse'),
                      FormBuilderValidators.maxLength(256,
                          errorText:
                          'Please enter a warehouse name with at most 256 characters'),
                    ],
                    const Icon(Icons.edit)),
                EditFormTextField(
                    widget.asn.shipperContact != null ? widget.asn.shipperContact.toString() : "",
                    '',
                    'ShipperContact',
                    'editAsn-shipperContact',
                    'Shipper Contact',
                    widget.asn.shipperContact != null ? widget.asn.shipperContact.toString() : "",
                    [
                      FormBuilderValidators.maxLength(256,
                          errorText:
                          'Please enter a contact with at most 256 characters'),
                    ],
                    const Icon(Icons.factory_sharp)),
                EditFormTextField(
                    widget.asn.address != null ? widget.asn.address.toString() : "",
                    '',
                    'Address',
                    'editAsn-address',
                    'Address',
                    widget.asn.address != null ? widget.asn.address.toString() : "",
                    [
                      FormBuilderValidators.maxLength(256,
                          errorText:
                          'Please enter an address with at most 256 characters'),
                    ],
                    const Icon(Icons.factory_sharp)),
                EditFormTextField(
                    widget.asn.carrier != null ? widget.asn.carrier.toString() : "",
                    '',
                    'CarrierName',
                    'editAsn-carrier',
                    'Carrier Name',
                    widget.asn.carrier != null ? widget.asn.carrier.toString() : "",
                    [
                      FormBuilderValidators.maxLength(256,
                          errorText:
                          'Please enter a carrier name with at most 256 characters'),
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
      Map<String, dynamic> asn = {
        'ShipmentReference': widget.asn.shippingReference,
        'ExpectedDeliveryDate': null,
        'Warehouse': _formKey.currentState!.value['Warehouse'].trim(),
        'ShipperContact': _formKey.currentState!.value['ShipperContact'].trim(),
        'Address': _formKey.currentState!.value['Address'],
        'CarrierName': _formKey.currentState!.value['CarrierName'],
        'PoIdentification': widget.asn.poIdentification
      };
      editAsn(widget.asn.id, asn, context);
    }
  }

  formButtons(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      (!isSmallScreen(context))
          ? GhostButton(
          width: 200,
          title: 'Discard',
          key: const Key('resetAsnButton'),
          onPressed: () =>  _formKey.currentState?.reset())
          : GhostIconButton(
          icon: Icons.cancel_outlined,
          key: const Key('resetAsnButton'),
          onPressed: () =>  _formKey.currentState?.reset()),
      (!isSmallScreen(context))
          ? SecondaryButton(
          width: 200,
          title: 'Edit',
          key: const Key('editAsnButton'),
          onPressed: () => submitFunction(context))
          : SecondaryIconButton(
          icon: Icons.check,
          key: const Key('editAsnButton'),
          onPressed: () => submitFunction(context)),
    ]);
  }

  void onPressedEditPO(context){
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