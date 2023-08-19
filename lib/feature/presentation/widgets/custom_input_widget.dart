import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hinText;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final String labelText;
  final bool? isMoreText;

  const CustomInputWidget({
    super.key,
    this.controller,
    this.hinText,
    this.validator,
    this.inputType,
    required this.labelText,
    this.isMoreText = false,
  });

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.inputType,
          cursorColor: Colors.black,
          validator: widget.validator,
          minLines: widget.isMoreText! ? 3 : 1,
          maxLines: widget.isMoreText! ? 12 : 1,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            contentPadding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            filled: true,
            fillColor: Colors.transparent,
            hintText: widget.hinText,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
