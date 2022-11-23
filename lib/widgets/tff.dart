import 'package:flutter/material.dart';

class TFF extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final bool? readOnly;
  final bool? obscureText;
  final int? maxLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool? showBorder;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final double? width;
  final double? radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const TFF({
    super.key,
    this.controller,
    this.focusNode,
    this.textAlign,
    this.readOnly,
    this.obscureText,
    this.maxLines,
    this.keyboardType,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.enabled,
    this.showBorder,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.width,
    this.radius,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        focusNode: focusNode,
        keyboardType: keyboardType,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        textAlign: textAlign ?? TextAlign.start,
        readOnly: readOnly ?? false,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        enabled: enabled,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: showBorder == null ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 10.0),
          ) : (!showBorder! ? InputBorder.none : OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 10.0),
          )),
        ),
      ),
    );
  }
}
