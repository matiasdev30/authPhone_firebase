
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'dart:developer' as developer;

class PinsTextField extends StatefulWidget {
  const PinsTextField(
      {Key? key,
      required this.controller,
      required this.focus,
      required this.formater,
      required this.onFieldSubmitted})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focus;
  final Function(String) onFieldSubmitted;
  final List<TextInputFormatter> formater;

  @override
  State<PinsTextField> createState() => _PinsTextFieldState();
}

class _PinsTextFieldState extends State<PinsTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child:  Pinput(
        autofocus: true,
       
        length: 6,
        inputFormatters: widget.formater,
        onCompleted: (pin){
          developer.log(pin);
          widget.onFieldSubmitted(pin);
        },
        focusNode: widget.focus,
        controller: widget.controller,
        
      ),
    );
  }
}
