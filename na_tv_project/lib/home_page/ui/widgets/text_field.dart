import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.onChanged,
  });

  final Function(String) onChanged;

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      maxLines: 10,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Введите текст',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
