import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proplus/constants/constants.dart';
import 'package:proplus/customwidgets/textformfield.dart';
import 'package:proplus/service.dart';
import 'package:proplus/view/productkistscreen.dart';
import 'package:proplus/viewmodel/loginviewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final signInPage = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _passwordVisibleSignIn = true;
  bool validateForm() {
    if (signInPage.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [headerSection(), loginForm(), footerSection()],
      ),
    );
  }

  Widget headerSection() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60.sp,
            backgroundImage: const AssetImage("assets/images/nouser.png"),
            backgroundColor: Colors.transparent,
          ),
          Text(
            "Welcome Back",
            style:
                GoogleFonts.lato(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            "Sign to continue",
            style: GoogleFonts.lato(fontSize: 12.sp, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: signInPage,
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          InputTextField(
              getIcon: Icon(
                Icons.email_outlined,
                color: ColorConstants.loginButtonColor,
              ),
              textEditingController: email,
              letterSize: 18.sp,
              cursorColor: ColorConstants.loginButtonColor,
              obscureText: false,
              validators: [
                RequiredValidator(errorText: "Email Required"),
              ],
              hintText: "Email",
              inputType: TextInputType.text),
          InputTextField(
              getIcon: Icon(
                Icons.lock_outline,
                color: ColorConstants.loginButtonColor,
              ),
              getPasswordIcon: IconButton(
                onPressed: () {
                  setState(() {
                    if (_passwordVisibleSignIn == true) {
                      _passwordVisibleSignIn = false;
                    } else {
                      _passwordVisibleSignIn = true;
                    }
                  });
                },
                icon: Icon(
                  _passwordVisibleSignIn == true
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: ColorConstants.loginButtonColor,
                ),
              ),
              textEditingController: password,
              letterSize: 18.sp,
              cursorColor: ColorConstants.loginButtonColor,
              obscureText: _passwordVisibleSignIn,
              validators: [
                RequiredValidator(errorText: "Password Required"),
              ],
              hintText: "Password",
              inputType: TextInputType.text),
          Padding(
            padding: EdgeInsets.only(right: 13.sp),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forget Password?",
                  style: TextStyle(color: ColorConstants.loginButtonColor),
                )),
          ),
        ],
      ),
    );
  }

  Widget footerSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: InkWell(
            onTap: () async {
              var provider =
                  Provider.of<LoginViewModel>(context, listen: false);
              if (validateForm() == true) {
                var result =
                    await provider.getLoginURl(email.text, password.text);
                if (result == "SUCCESS") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductListScreen()),
                  );
                } else {
                  null;
                }
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 40.h,
              decoration: BoxDecoration(
                  color: ColorConstants.loginButtonColor,
                  borderRadius: BorderRadius.circular(5.sp)),
              child: Center(
                child: Text("Get Started",
                    style: GoogleFonts.lato(
                      fontSize: 16.sp,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
        SizedBox(height: 25.h),
        RichText(
          text: TextSpan(children: [
            const TextSpan(
              text: "Don't have account?",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextSpan(
                text: 'Create a new account',
                style: TextStyle(
                  color: ColorConstants.loginButtonColor,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {}),
          ]),
        ),
      ],
    );
  }
}
