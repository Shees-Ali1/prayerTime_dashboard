import 'package:flutter/material.dart';

class PrayersField extends StatelessWidget {

  final String hintText;
  final IconData prefixicon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? enabled; // New parameter for enabling/disabling the text field
  final String? text;

  const PrayersField({super.key, required this.hintText, required this.prefixicon,  this.controller, this.onTap, this.enabled, this.text});

  @override
  Widget build(BuildContext context) {
    return     Column(
      children: [
        Text(text??''),
        SizedBox(height: 10,),
        Container(
          width: 200,
          child: TextFormField(
            onTap: onTap,
            controller: controller,
            enabled: enabled,


            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(prefixicon),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),),
        ),
      ],
    );
  }
}
