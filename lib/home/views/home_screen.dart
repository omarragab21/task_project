import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProviderRead = context.read<HomeProvider>();
    final HomeProviderWatch = context.watch<HomeProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Top Audios'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 1,
                  color: Colors.grey.shade400,
                ),
                Expanded(
                  child: HomeProviderWatch.isAudiosLoaded
                      ? ListView.separated(
                          itemCount: HomeProviderWatch.allAudio.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 1,
                              color: Colors.grey.shade400,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${'Sample Text'.tr()}${index + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 15.sp),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => HomeProviderRead.addAudioFavourite(
                                        HomeProviderRead.allAudio[index]),
                                    child: SvgPicture.asset(HomeProviderWatch.isFavouriteAudio(
                                            HomeProviderWatch.allAudio[index])
                                        ? "assets/icons/Like_FIlled@1x.svg"
                                        : "assets/icons/Like@1x.svg"),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Top Likes'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 1,
                  color: Colors.grey.shade400,
                ),
                Expanded(
                  child: HomeProviderWatch.favouriteAudio.isNotEmpty
                      ? ListView.separated(
                          itemCount: HomeProviderWatch.favouriteAudio.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 1,
                              color: Colors.grey.shade400,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      HomeProviderRead.playAudio(
                                          HomeProviderWatch.favouriteAudio[index].audioUrl!, index);
                                    },
                                    icon: SvgPicture.asset(HomeProviderWatch.player.playing &&
                                            HomeProviderWatch.playAudioIndex == index
                                        ? 'assets/icons/Pause@1x.svg'
                                        : 'assets/icons/icPlay Copy@1x.svg'),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    'Play This'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'No Likes Audios'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15.sp),
                          ),
                        ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
