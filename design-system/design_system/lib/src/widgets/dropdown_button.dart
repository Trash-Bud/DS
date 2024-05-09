import 'package:design_system/src/colors.dart';
import 'package:flutter/material.dart';

class AppDropdownButton<T> extends StatefulWidget {
  final T? value;
  final String hintText;
  final Function(T?)? onChanged;
  final List<T>? items;
  final Icon? icon;
  final bool required;
  final bool withNull;
  final double? width;
  final double height;

  const AppDropdownButton(
      {super.key,
      this.value,
      this.hintText = '',
      this.icon,
      this.onChanged,
      this.items,
      this.required = false,
      this.withNull = false,
      this.width = double.infinity,
      this.height = 50});

  @override
  State<AppDropdownButton<T>> createState() => _AppDropdownButtonState<T>();
}

class _AppDropdownButtonState<T> extends State<AppDropdownButton<T>> {
  late T? _selectedValue;

  @override
  Widget build(BuildContext context) {
    var items = [if (widget.withNull) null, ...?widget.items];
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonFormField<dynamic>(
        icon: widget.icon,
        value: _selectedValue,
        decoration: InputDecoration(
            hintText:
                widget.required ? '${widget.hintText} *' : widget.hintText),
        validator: (value) {
          if (widget.required && value == null) {
            return '${widget.hintText} is required';
          }
          return null;
        },
        onChanged: (newValue) {
          _selectedValue = newValue;
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        items: items.map<DropdownMenuItem<dynamic>>((dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(value == null
                ? widget.required
                    ? '${widget.hintText} *'
                    : widget.hintText
                : value.toString()),
          );
        }).toList(),
        iconEnabledColor: appPrimaryColor,
        iconDisabledColor: appDisableGrey,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }
}
