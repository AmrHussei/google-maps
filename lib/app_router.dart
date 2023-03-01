import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps/presentation/screens/map_screen.dart';
import 'package:maps/presentation/screens/otp_screen.dart';
import 'package:maps/presentation/screens/register_screen.dart';
import 'package:maps/utils/strings.dart';

class AppRouter {
  final PhoneAuthCubit _phoneAuthCubit = PhoneAuthCubit();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case registerScreen:
        return MaterialPageRoute(
          builder: ((_) => BlocProvider<PhoneAuthCubit>.value(
                value: _phoneAuthCubit,
                child: RegisterScreen(),
              )),
        );
      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: ((_) => BlocProvider<PhoneAuthCubit>.value(
                value: _phoneAuthCubit,
                child: OtpScreen(phonNumber: phoneNumber.toString()),
              )),
        );
      case mapScreen:
        return MaterialPageRoute(
          builder: ((context) => const MapScreen()),
        );
    }
  }
}
