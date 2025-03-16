import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class ProductDesc extends StatefulWidget {
  const ProductDesc({super.key});

  @override
  State<ProductDesc> createState() => _ProductDescState();
}

class _ProductDescState extends State<ProductDesc> {
  late YoutubePlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = false;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
              AppCubit.get(context).showServiceModel['video']) ??
          "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: true,
        showLiveFullscreenButton: false,
        hideControls: true,
      ),
    )..seekTo(const Duration(seconds: 30));
    _controller.addListener(() {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _toggleControls() {
    setState(() {
      _showControls = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: 343.w,
              child: AppText(
                bottom: 7.h,
                text: LocaleKeys.product_description.tr(),
                size: 16.sp,
              ),
            ),
            SizedBox(
              width: 343.w,
              child: AppText(
                bottom: 16.h,
                text: AppCubit.get(context).showServiceModel['desc'] ?? '',
                color: Colors.grey,
                size: 14.sp,
                lines: 3,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppCubit.get(context).serviceImages.length,
              itemBuilder: (context, index) => AppCachedImage(
                height: 230.h,
                width: double.infinity,
                image: AppCubit.get(context).serviceImages[index].image,
                fit: BoxFit.fill,
              ),
            ),
            AppCubit.get(context).showServiceModel['video'] == ''
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: _toggleControls,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                        ),
                        if (_showControls)
                          Positioned(
                            bottom: 5,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        _isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: _togglePlayPause,
                                    ),
                                    const SizedBox(width: 20),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.fast_forward,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () => _controller.seekTo(
                                        _controller.value.position +
                                            const Duration(seconds: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                AppCubit.get(context)
                                            .showServiceModel['video'] ==
                                        ''
                                    ? const SizedBox.shrink()
                                    : YoutubeProgressBar(
                                        controller: _controller,
                                      ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
            SizedBox(height: 16.h),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }
}

class YoutubeProgressBar extends StatelessWidget {
  final YoutubePlayerController controller;
  const YoutubeProgressBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, YoutubePlayerValue value, child) {
        final double maxDuration = value.metaData.duration.inSeconds.toDouble();
        final double currentPosition = value.position.inSeconds.toDouble();

        return SizedBox(
          width: 300.w,
          child: Slider(
            value:
                (maxDuration > 0) ? currentPosition.clamp(0, maxDuration) : 0,
            max: maxDuration > 0 ? maxDuration : 1,
            onChanged: (newValue) {
              if (maxDuration > 0) {
                controller.seekTo(Duration(seconds: newValue.toInt()));
              }
            },
            activeColor: Colors.red,
            inactiveColor: Colors.white54,
          ),
        );
      },
    );
  }
}
