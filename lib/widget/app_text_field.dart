import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final validator;

  const AppTextFormField(
      {Key? key, required this.hintText, required this.controller, this.validator})
      : super(key: key);

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding: const EdgeInsets.all(5)),
      ),
    );
  }
}
