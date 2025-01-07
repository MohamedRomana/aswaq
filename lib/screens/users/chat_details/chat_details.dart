import 'dart:async';

import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/custom_chat_with_container.dart';
import 'widgets/custom_send_messages.dart';
import 'widgets/chat_message.dart';

final _replayMessageController = TextEditingController();

class ChatDetails extends StatefulWidget {
  const ChatDetails({
    super.key,
  });

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // AppCubit.get(context).getChatMessages(salerId: widget.salerId);

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      AppCubit.get(context).getChatMessages(
        salerId: 'widget.salerId',
        isloading: false,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: LocaleKeys.chat.tr(),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const CustomChatWithContainer(),
                Container(
                  height: 415.h,
                  width: 343.w,
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.only(bottom: 30.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.r,
                        spreadRadius: 1.r,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    itemCount: 10,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 5.h),
                    itemBuilder: (context, index) => ChatMessage(
                      index: index,
                      chatMessage: 'gfdg',
                    ),
                  ),
                ),
                CustomSendMessage(
                  replayMessageController: _replayMessageController,
                ),
                SizedBox(height: 140.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
