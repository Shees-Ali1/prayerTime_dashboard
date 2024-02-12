import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/controllers/registration_controller.dart';
import 'package:prayertime_dashboard/widgets/reuse_textfields.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final RegisterController registerController = Get.put(RegisterController());
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
    String? validateEmail(String? formEmail) {
      if (formEmail == null || formEmail.isEmpty)
        return 'E-mail address is required.';

      String pattern = r'\w+@\w+\.\w+';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

      return null;
    }
    String? validatePassword(String? formPassword) {
      if (formPassword == null || formPassword.isEmpty)
        return 'Password is required.';

      String pattern =
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formPassword))
        return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';

      return null;
    }
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(child: Text(
              'Welcome To iPray', style: TextStyle(fontSize: 30),)),
            Center(child: Text(
              'Login to Continue', style: TextStyle(fontSize: 18),)),

            SizedBox(height: 20.h,),

            ReuseTextFields(
                validator: validateEmail,
                text: "Enter Email",
                hintText: "abc@gmail.com",
                prefixicon: Icons.email,
                controller: emailController),
            SizedBox(height: 10.h,),

            ReuseTextFields(
                validator: validatePassword,
                text: "Enter Password",
                hintText: "1341523",
                prefixicon: Icons.password,
                controller: passwordController),

            SizedBox(height: 20.h,),
            //         Center(
            //           child: ElevatedButton(
            //
            //             style: ElevatedButton.styleFrom(
            //                 fixedSize: Size(100.w, 50.h),
            //                 backgroundColor: Colors.black54
            //
            //             ),
            //             onPressed: () {
            // if (_key.currentState!.validate()) {
            //   registerController.register(emailController, passwordController);
            // }
            //             },
            //             child: Text("Register",style: TextStyle(color: Colors.white),),
            //           ),
            //         ),
            //         SizedBox(height: 10.h,),

            Center(
              child: Obx(() {
                return ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(100.w, 50.h),
                      backgroundColor: Colors.black54

                  ),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      registerController.signin(
                          emailController, passwordController);
                    }
                  },
                  child: registerController.isLoading.value
                      ? CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text("Login", style: TextStyle(color: Colors.white),),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
