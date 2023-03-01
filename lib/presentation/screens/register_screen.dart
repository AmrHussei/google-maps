import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps/utils/my_colors.dart';

import '../../utils/strings.dart';

import '../widgets/register_screen_widget/top_screen_text.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  late String phoneNumber;
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _phoneFormKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
            child: ListView(
              children: [
                const TopScreenText(),
                SizedBox(height: 60.h),
                Row(
                  children: [
                    countryCodeWidget(),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 12.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColor.blue),
                          borderRadius: BorderRadius.circular(6.sp),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontSize: 14.sp,
                              letterSpacing: 2.0,
                              color: Colors.black),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 11) {
                              return 'Please enter a correct phone number';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            phoneNumber = newValue!;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                nextButton(context),
                _buildPhoneNumberSubmitedBloc()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget countryCodeWidget() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.h),
        decoration: BoxDecoration(
          border: Border.all(color: MyColor.lightGreey),
          borderRadius: BorderRadius.circular(6.sp),
        ),
        child: Text(
          generateCountryFlag() + '  +20',
          style: TextStyle(
            fontSize: 14.sp,
            letterSpacing: 1,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  Widget nextButton(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            showProgressIndicator(context);
            _register(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(80.w, 40.h),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.sp)),
          ),
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ));
  }

  Future<void> _register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
    } else {
      print('_register');
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: ((context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          Navigator.pushNamed(context, otpScreen, arguments: phoneNumber);
        }
        if (state is ErrorOccurred) {
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
}
