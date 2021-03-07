import 'package:flutter/material.dart';

class BuildFormField extends StatelessWidget {
  const BuildFormField({
    Key? key,
    this.validator,
    this.label,
    this.controller,
    this.secure,
    this.formKey,
  }) : super(key: key);

  final formKey;
  final validator;
  final label;
  final controller;
  final secure;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        obscureText: secure,
        validator: (value) => validator(value),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
