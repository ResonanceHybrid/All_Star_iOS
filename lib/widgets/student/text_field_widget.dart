import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/custom_methods.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.isReadOnly = false,
    this.keyboardType,
    this.validator,
  });
  final String label;
  final TextEditingController controller;
  final bool isReadOnly;
  final Icon icon;
  final TextInputType? keyboardType;
  final String? Function(dynamic value)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            autofocus: false,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              hintText: label,
              prefixIcon: icon,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            validator: validator ??
                (value) {
                  if (TextInputType.emailAddress == keyboardType) {
                    bool isValidEmail = CustomMethods().isValidEmail(value!);
                    return isValidEmail ? null : "Please enter valid email";
                  }
                  if (value == null || value.isEmpty) {
                    return "Required field *";
                  }
                  return null;
                },
            readOnly: isReadOnly,
            controller: controller,
            cursorColor: Theme.of(context).primaryColor,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class EntryTextAreaField extends StatelessWidget {
  final String? labelText;
  final TextEditingController controller;

  const EntryTextAreaField({
    super.key,
    required this.labelText,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              labelText!,
            ),
          ),
        TextFormField(
          autofocus: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Required field *";
            }
            return null;
          },
          maxLines: 7,
          minLines: 6,
          controller: controller,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class PhoneNumberFieldWidget extends StatelessWidget {
  const PhoneNumberFieldWidget(
      {super.key,
      required this.label,
      required this.controller,
      required this.icon});
  final String label;
  final TextEditingController controller;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(label),
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: icon,
          ),
          autofocus: false,
          validator: (value) {
            RegExp regExp = RegExp(r'^[0-9].*$');
            if (value == null || value.isEmpty) {
              return "Required field *";
            } else if (!regExp.hasMatch(value)) {
              return 'Please Enter Valid Phone Number';
            } else if (value.length > 10 || value.length < 7) {
              return 'Please Enter 10 Digit Phone Number';
            }
            return null;
          },
          controller: controller,
          cursorColor: Colors.black,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textDarkColorGrey,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class PasswordFieldWidget extends StatefulWidget {
  PasswordFieldWidget(
      {super.key,
      required this.label,
      required this.controller,
      required this.isObscure,
      required this.icon});
  final String label;
  final TextEditingController controller;
  bool isObscure = true;
  final Icon icon;

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Required field *";
              }
              return null;
            },
            autofocus: false,
            controller: widget.controller,
            obscureText: !widget.isObscure,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textDarkColorGrey,
            ),
            decoration: InputDecoration(
              prefixIcon: widget.icon,
              hintText: widget.label,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  widget.isObscure ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    widget.isObscure = !widget.isObscure;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///
///
///
class TextFormFieldWidget2 extends StatelessWidget {
  const TextFormFieldWidget2({
    super.key,
    required this.label,
    required this.controller,
    this.isReadOnly = false,
    this.hintText,
  });
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(label),
        ),
        TextFormField(
          autofocus: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Required field *";
            }
            return null;
          },
          readOnly: isReadOnly,
          controller: controller,
          cursorColor: Theme.of(context).primaryColor,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textDarkColorGrey,
          ),
          // style: CustomTextStyle.headingBoldStyleMedium
          //     .copyWith(color: AppColors.mainColor)
        ),
      ],
    );
  }
}
