import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class ChatMessage extends StatelessWidget {
  final int index;
  final String chatMessage;
  const ChatMessage({
    super.key,
    required this.index,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(Assets.svg.profilecircle,
            height: 40.w, width: 40.w, fit: BoxFit.cover),
        SizedBox(width: 7.w),
        AppText(
          text: 'هلا ومسهلا',
          size: 16.sp,
          family: Assets.fonts.norsalLight,
        ),
      ],
    );
  }
}


//  Row(
//               mainAxisAlignment: chatMessage.fromId != int.parse(CacheHelper.getUserId())
//               ? MainAxisAlignment.end
//               : MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 if(chatMessage.fromId == int.parse(CacheHelper.getUserId()))
//                 SvgPicture.asset(Assets.svg.profilecircle, height: 50.w, width: 50.w, fit: BoxFit.cover),
//                 Flexible(child: AppText(text: chatMessage.message, size: 14.sp, color: Colors.black,),),
//                 if(chatMessage.fromId != int.parse(CacheHelper.getUserId()))
//                 SvgPicture.asset(Assets.svg.profilecircle, height: 50.w, width: 50.w, fit: BoxFit.cover),
//                 Flexible(child: AppText(text: chatMessage.message, size: 14.sp, color: Colors.black,),),
//               ],
//             ),