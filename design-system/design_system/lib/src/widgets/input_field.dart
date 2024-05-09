import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:design_system/design_system.dart';


class FormInputField extends StatelessWidget {
  final String? textDescription;
  final String name;
  final String label;
  final String? hint;
  final String textFieldKey; // testing purposes
  final TextStyle? descriptionStyle;
  final TextStyle? labelStyle;
  final String? initialValue;
  final List<FormFieldValidator>? validators;
  final Icon? icon;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSaved;
  final TextInputType? keyboardType;

  const FormInputField({
    super.key,
    this.validators,
    this.hint,
    this.textFieldKey = "FormInputField",
    this.icon,
    this.descriptionStyle,
    this.labelStyle,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.textDescription,
    required this.name,
    required this.label, this.initialValue, this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (textDescription != null) _getDescription(context),
        _getTextField(),
      ],
    );
  }

  Widget _getTextField() {
    return FormBuilderTextField(
      onTap: () => {if (onTap != null) onTap!()},
      onChanged: (value) => {if (onChanged != null) onChanged!(value!)},
      onSaved: (value) => {if (onSaved != null) onSaved!(value!)},
      initialValue: initialValue,
      name: name,
      keyboardType: keyboardType,
      key: Key(textFieldKey),
      decoration: _getInputDecoration(),
      validator: FormBuilderValidators.compose(validators ?? []),
    );
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      labelText: label,
      filled: true,
      fillColor: formFieldInputFillColor,
      hintText: hint ?? '',
      prefixIcon: icon,
      labelStyle: labelStyle ?? const TextStyle(fontSize: 16),
    );
  }

  Widget _getDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        textAlign: TextAlign.start,
        textDescription!,
        style: descriptionStyle ?? Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
