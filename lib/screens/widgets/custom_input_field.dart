import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.nameController,
    required this.label,
    this.mandatory=false
  }) : super(key: key);

  final String label;
  final TextEditingController nameController;
  final bool mandatory;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red, //this has no effect
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (mandatory && value!.isEmpty) {
          return "$label must be provided";
        }
        return null;
      },
    );
  }
}