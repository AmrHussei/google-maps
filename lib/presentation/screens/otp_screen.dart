import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps/presentation/widgets/otp_widget/build_intro_text.dart';
import 'package:maps/utils/my_colors.dart';
import 'package:maps/utils/strings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../business_logic/cubit/phone_auth/phone_auth_cubit.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.phonNumber});
  final String phonNumber;
  late String otpCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColor.blue,
              MyColor.blue.withOpacity(0.1),
            ],
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
              child: ListView(children: [
                BuildIntoText(phonNumber: phonNumber),
                SizedBox(height: 60.h),
                pinCodeWidget(context),
                SizedBox(height: 50.h),
                _verifyButton(context),
                _buildVirificationBloc()
              ]),
            )),
      ),
    );
  }

  Widget pinCodeWidget(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      textStyle: TextStyle(color: Colors.black, fontSize: 17.sp),
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(6.sp),
          fieldHeight: 45.h,
          fieldWidth: 35.w,
          activeFillColor: MyColor.lightBlue,
          activeColor: MyColor.blue,
          inactiveColor: MyColor.blue,
          inactiveFillColor: Colors.white,
          selectedColor: MyColor.blue,
          selectedFillColor: Colors.white),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (code) {
        otpCode = code;
        print("Completed");
      },
      onChanged: (code) {
        print(code);
      },
    );
  }

  Widget _verifyButton(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            showProgressIndicator(context);
            _login(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(80.w, 40.h),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.sp)),
          ),
          child: Text(
            'Verify',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ));
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
      ),
    );
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return alertDialog;
      }),
    );
  }

  Widget _buildVirificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: ((previous, current) => previous != current),
      listener: ((context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is PhoneOTPVerified) {
          Navigator.pushReplacementNamed(context, mapScreen);
        }
        if (state is ErrorOccurred) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                (state).errorMsg,
              ),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }),
      child: Container(),
    );
  }
}
