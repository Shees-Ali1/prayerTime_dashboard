import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReuseTextFields extends StatelessWidget {
  final String text;
  final String hintText;
  final IconData prefixicon;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final bool readonly;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;
  final  void Function(String?)? onSaved;


  const ReuseTextFields({super.key,this.readonly=false , required this.text, required this.hintText, required this.prefixicon, required this.controller, this.onTap, this.onChanged, this.validator, this.onFieldSubmitted, this.onEditingComplete, this.onTapOutside, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 18.0.w),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),
            Text(text,style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(

              onSaved: onSaved,
              readOnly: readonly,
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              onFieldSubmitted:onFieldSubmitted ,
              validator: validator,

              onTap: (){
                if(onTap != null){
                onTap!();
                }
                },
              controller: controller,
              onChanged: (value){
                if(onChanged != null){
                  onChanged!(value);
                }

                },
              decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.white,filled: true,
              prefixIcon: Icon(prefixicon),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
            ),),

          ],
        ),
    );
  }
}
