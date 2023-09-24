import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.hintStyle,
    this.obscureText = false,
  });

  final String label;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            height: 22 / 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              counterStyle: const TextStyle(height: double.minPositive),
              contentPadding: EdgeInsets.zero,
              counterText: '',
              isDense: true,
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: hintStyle ??
                  const TextStyle(
                    fontSize: 17,
                    height: 22 / 17,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
