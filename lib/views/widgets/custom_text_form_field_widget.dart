import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final double? hPadding;
  final String? errorText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
      required this.hint,
      required this.obscureText,
      this.hPadding,
      this.validator,
      this.errorText,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: hPadding == null ? 15 : hPadding!),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          key: key,
          validator: validator,
          obscureText: obscureText,
          controller: controller,
          style: TextStyle(color: Color.fromARGB(255, 59, 59, 59)),
          decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 182, 88, 88))),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 182, 88, 88))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorText: errorText,
              border: InputBorder.none,
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hint,
              hintStyle: TextStyle(color: Color.fromARGB(255, 150, 150, 150))),
        ),
      ),
    );
  }
}
