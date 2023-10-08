import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_project/home/providers/home_provider.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProviderRead = context.read<HomeProvider>();
    final HomeProviderWatch = context.watch<HomeProvider>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Settings'.tr(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 1,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Dark Mode'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                ),
                CupertinoSwitch(
                    value: HomeProviderWatch.isDark,
                    activeColor: Colors.deepPurpleAccent,
                    onChanged: (darkMode) {
                      HomeProviderRead.isDark = darkMode;
                    })
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 1,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Arabic Language'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                ),
                CupertinoSwitch(
                    value: HomeProviderWatch.isArabic,
                    activeColor: Colors.deepPurpleAccent,
                    onChanged: (arabicMode) {
                      HomeProviderRead.isArabic = arabicMode;
                      if (HomeProviderWatch.isArabic) {
                        context.setLocale(const Locale('ar', 'AR'));
                      } else {
                        context.setLocale(const Locale('en', 'US'));
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
