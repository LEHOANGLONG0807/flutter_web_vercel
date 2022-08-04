import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownTextFiled<T> extends StatefulWidget {
  final String hintText;
  final List<T> options;
  final T? initValue;
  final bool isLabel;
  final String Function(T) getLabel;
  final void Function(T?)? onChanged;
  final FormFieldValidator<T>? validator;
  final String? helpText;
  final String? errorText;

  const DropdownTextFiled({
    Key? key,
    this.hintText = 'Please select an Option',
    this.options = const [],
    required this.getLabel,
    this.initValue,
    this.isLabel = true,
    this.onChanged,
    this.helpText,
    this.validator,
    this.errorText,
  }) : super(key: key);

  @override
  _DropdownTextFiledState<T> createState() => _DropdownTextFiledState<T>();
}

class _DropdownTextFiledState<T> extends State<DropdownTextFiled<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initValue;
  }

  @override
  void didUpdateWidget(covariant DropdownTextFiled<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: widget.validator,
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            helperText: widget.helpText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            labelText: widget.isLabel ? widget.hintText : null,
            hintText: widget.isLabel ? null : widget.hintText,
            errorText: widget.errorText,
          ),
          isEmpty: _value == null || _value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: _value,
              isDense: true,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 16),
              onChanged: (val) {
                widget.onChanged?.call(val);
                setState(() {
                  _value = val;
                });
              },
              selectedItemBuilder: (_) {
                return widget.options.map((T value) {
                  return Text(
                    widget.getLabel(value),
                    maxLines: 1,
                    style: Get.textTheme.subtitle1,
                  );
                }).toList();
              },
              items: widget.options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(
                    widget.getLabel(value),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
