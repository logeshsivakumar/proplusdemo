import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proplus/constants/constants.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.textEditingController,
    required this.letterSize,
    required this.cursorColor,
    required this.obscureText,
    required this.validators,
    required this.hintText,
    required this.inputType,
    this.fillColor,
    required this.getIcon,
    this.getPasswordIcon,
    this.onCallBack,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final double letterSize;
  final Color cursorColor;
  final bool obscureText;
  final List<FieldValidator<dynamic>> validators;
  final String hintText;
  final TextInputType inputType;
  final Color? fillColor;
  final Icon getIcon;
  final IconButton? getPasswordIcon;
  final Function(String)? onCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 25.sp,
        left: 25.sp,
      ),
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        textAlign: TextAlign.left,
        cursorColor: cursorColor,
        onChanged: onCallBack,
        validator: MultiValidator(validators),
        keyboardType: inputType,
        style: TextStyle(
            fontSize: letterSize, color: ColorConstants.loginButtonColor),
        decoration: InputDecoration(
          suffixIcon: getPasswordIcon,
          prefixIcon: getIcon,
          prefixIconColor: const Color(0xFF3F3D56),
          errorStyle:
              TextStyle(fontSize: letterSize - 2, color: Colors.redAccent),
          hintText: hintText,
          errorMaxLines: 2,
          counterText: " ",
          hintStyle: GoogleFonts.lato(
            color: Colors.grey,
          ),
          filled: true,
          contentPadding: EdgeInsets.all(12.sp),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
