import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? title;
  final String? hintText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? onChanged;
  final Function? onEditingComplete;
  final int? maxLines;
  final Function()? onSuffixIconPressed;
  final Function()? onPrefixIconPressed;
  final AutovalidateMode validateMode;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int? maxLength;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final String? tooltipMessage;
  final bool showToolTipMessage;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final bool? autofocus;

  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.maxLines,
    this.keyboardType,
    this.onChanged,
    this.onSuffixIconPressed,
    this.validateMode = AutovalidateMode.onUserInteraction,
    this.title,
    this.focusNode,
    this.maxLength,
    this.nextFocusNode,
    this.tooltipMessage,
    this.contentPadding,
    this.onEditingComplete,
    this.prefixIcon,
    this.onPrefixIconPressed,
    this.textInputAction,
    this.readOnly,
    this.onTap,
    this.showToolTipMessage = false,
    this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox()
            : showToolTipMessage
                ? Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: tooltipMessage ?? "----",
                    child: Row(
                      children: [
                        Text(title ?? "----"),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.info, color: Colors.grey, size: 12)
                      ],
                    ))
                : Text(title ?? "----"),
        title == null
            ? const SizedBox()
            : const SizedBox(
                height: 5,
              ),
        TextFormField(
          autovalidateMode: validateMode,
          controller: controller,
          obscureText: obscureText ?? false,
          validator: validator,
          readOnly: readOnly ?? false,
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          textInputAction: textInputAction,
          keyboardType: keyboardType ?? TextInputType.text,
          onTap: onTap,
          autofocus: autofocus ?? false,
          focusNode: focusNode,
          onEditingComplete: () async {
            if (onEditingComplete != null) {
              onEditingComplete!();
            }
            if (focusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w100,
            ),
            contentPadding: contentPadding,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 227, 195, 195),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 227, 195, 195),
              ),
            ),
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 148, 145, 145),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 227, 195, 195),
              ),
            ),
            prefixIcon: prefixIcon == null
                ? null
                : IconButton(
                    onPressed: onPrefixIconPressed,
                    icon: Icon(prefixIcon),
                    color: Colors.grey,
                    iconSize: 18,
                  ),
            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
                    onPressed: onSuffixIconPressed,
                    icon: Icon(suffixIcon),
                    color: Colors.grey,
                    iconSize: 18,
                  ),
          ),
        ),
      ],
    );
  }
}
