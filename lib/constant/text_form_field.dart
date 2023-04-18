import 'package:flutter/material.dart';

class MainTextFormField extends StatelessWidget {
  final TextEditingController ?controller;
  final String? Function(String ?value)? validator;
  final TextInputType? inputType;
  final String? hintText;
  final bool obscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  const MainTextFormField({
    Key? key,
    this.controller,
    this.validator,
    this.inputType,
    this.obscure=false,
    this.suffixIcon,
    this.hintText,
    this.prefixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width-50,
      child: TextFormField(
        style: TextStyle(
          color: Theme.of(context).primaryColor
        ),
      controller: controller,
      validator: validator,
      obscureText: obscure,
      keyboardType: inputType,
      cursorColor: Theme.of(context).primaryColor,
      textAlignVertical: TextAlignVertical.center,
        decoration:  InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
          prefixIcon:prefixIcon,
        ),),);
  }
}





class NoneBorderTextFormField extends StatelessWidget {
  final TextEditingController ?controller;
  final double size;
  final String? hintText;
  const NoneBorderTextFormField({Key? key, this.controller,  this.size=0,  this.hintText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width - size,
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if(value!.isEmpty)
            {
              return "$hintText required";
            }
            return null;
          },
          cursorColor: Theme.of(context).primaryColor,
          style: const TextStyle(height: 1.1),
          maxLines: null,
          decoration:  InputDecoration(
            hintText: hintText,
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
                borderSide:
                const BorderSide(style: BorderStyle.solid)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                const BorderSide(style: BorderStyle.solid)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                const BorderSide(style: BorderStyle.solid)),
            focusedErrorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                const BorderSide(style: BorderStyle.solid)),
          ),
        ));
  }
}

