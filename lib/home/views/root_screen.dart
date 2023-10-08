import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:task_project/home/providers/home_provider.dart';
import 'package:task_project/home/views/home_screen.dart';
import 'package:task_project/home/views/more_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;
  List<Widget> screens = [const HomeScreen(), const MoreScreen()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<HomeProvider>().getAllAudios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'This is App'.tr(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentIndex == 0
                    ? 'assets/icons/Home@1x.svg'
                    : "assets/icons/Home_no selection@1x.svg",
              ),
              label: 'Home'.tr()),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(currentIndex == 1
                  ? 'assets/icons/More@1x.svg'
                  : "assets/icons/More_not selected@1x.svg"),
              label: 'More'.tr())
        ],
      ),
    );
  }
}
