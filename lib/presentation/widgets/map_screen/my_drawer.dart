import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import '../../../utils/my_colors.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            color: Colors.blue[300],
            image: const DecorationImage(
                image: AssetImage('assets/amr.png'), fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        const Text(
          'Amr Hussein',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        BlocProvider<PhoneAuthCubit>(
            create: (context) => phoneAuthCubit,
            child: Text(
              '${phoneAuthCubit.getLoggedInUser().phoneNumber}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? MyColor.blue,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 16.sp),
      ),
      trailing: trailing ??= const Icon(
        Icons.arrow_right,
        color: MyColor.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Widget buildIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Icon(
        icon,
        color: MyColor.blue,
        size: 30.sp,
      ),
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.w),
      child: Row(
        children: [
          buildIcon(
            FontAwesomeIcons.facebook,
            'https://www.facebook.com/profile.php?id=100090445479406',
          ),
          const SizedBox(
            width: 15,
          ),
          buildIcon(
            FontAwesomeIcons.youtube,
            'https://www.youtube.com/channel/UCXmkc4IS9gU43xg9d23LoeA',
          ),
          const SizedBox(
            width: 20,
          ),
          buildIcon(
            FontAwesomeIcons.instagram,
            'https://www.instagram.com/amr_hussein__/',
          ),
        ],
      ),
    );
  }

  Widget buildLogoutBlocProvider(context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => phoneAuthCubit,
      child: buildDrawerListItem(
        leadingIcon: Icons.logout,
        title: 'Logout',
        onTap: () async {
          await phoneAuthCubit.logOut();
          Navigator.of(context).pushReplacementNamed(registerScreen);
        },
        color: Colors.red,
        trailing: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 250.h,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[300]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(
            leadingIcon: Icons.person,
            title: 'My Profile',
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          buildDrawerListItemsDivider(),
          buildLogoutBlocProvider(context),
          SizedBox(
            height: 95.h,
          ),
          ListTile(
            leading: Text(
              'Follow us',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          buildSocialMediaIcons(),
        ],
      ),
    );
  }
}
