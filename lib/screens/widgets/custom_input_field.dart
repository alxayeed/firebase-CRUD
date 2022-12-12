import 'package:flutter/material.dart';

import '../../models/player.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    this.player,
    required this.controller,
    required this.label,
    this.mandatory=false,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool mandatory;
  final Player? player;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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