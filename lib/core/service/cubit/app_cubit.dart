import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aswaq/screens/users/home_layout/favorites/favorites.dart';
import 'package:aswaq/screens/users/home_layout/markets/markets.dart';
import 'package:aswaq/screens/users/home_layout/shopping_carts/shopping_carts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../screens/users/home_layout/home/home.dart';
import '../../../screens/users/home_layout/more/more.dart';
import '../../cache/cache_helper.dart';
import '../../constants/contsants.dart';
import '../model/cities_model.dart';
import '../model/notifications_model.dart';
import '../model/on_boarding_model.dart';
import '../model/chat_messages_model.dart';
import '../model/question_model.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int bottomNavIndex = 2;
  List<Widget> bottomNavScreens = [
    const Markets(),
    const Favorites(),
    const Home(),
    const ShoppingCarts(),
    const More(),
  ];

  double? lat = 0;
  double? lng = 0;
  String? address;
  void changeAddress({required String newAddress}) {
    address = newAddress;
    emit(ChangeIndex());
  }

  int paymentIndex = -1;
  void changePaymentIndex({required int index}) {
    paymentIndex = index;
    emit(ChangeIndex());
  }

  int paymentlocatIndex = -1;
  void changePaymentlocatIndex({required int index}) {
    paymentlocatIndex = index;
    emit(ChangeIndex());
  }

  int shipIndex = -1;
  void changeShipIndex({required int index}) {
    shipIndex = index;
    emit(ChangeIndex());
  }

  int count = 1;
  void increseCount() {
    count++;
    emit(ChangeCount());
  }

  void decreseCount() {
    if (count > 0) {
      count--;
    }
    emit(ChangeCount());
  }

  int requestIndex = -1;
  void changerequestIndex({required int index}) {
    requestIndex = index;
    emit(ChangeIndex());
  }

  bool isSecureLogIn = true;
  isSecureLogInIcon(isSecuree) {
    isSecureLogIn = isSecuree;
    emit(IsSecureIcon());
  }

  int isTab = -1;
  changeIsTab({required int index}) {
    isTab = index;
    emit(IsSecureIcon());
  }

  void changebottomNavIndex(index) async {
    bottomNavIndex = index;
    emit(ChangeBottomNav());
  }

  int changeLangIndex = 0;
  void changeLangIndexs({required int index}) {
    changeLangIndex = index;
    emit(ChangeIndex());
  }

  int changeTypeIndex = 0;
  void changeTypeIndexs({required int index}) {
    changeTypeIndex = index;
    emit(ChangeIndex());
  }

  int changeIndex = 0;
  void changeIndexs({required int index}) {
    changeIndex = index;
    emit(ChangeIndex());
  }

  int changeTermsIndex = -1;
  void changeTermsIndexs({required int index}) {
    changeTermsIndex = index;

    emit(ChangeIndex());
  }

  List<OnBoardingModel> onBoardingList = [];
  Future intro() async {
    emit(GetIntroLoading());
    http.Response response = await http.post(
      Uri.parse("${baseUrl}api/intro"),
      body: {"lang": CacheHelper.getLang()},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data["data"].toString());
    onBoardingList = List<OnBoardingModel>.from(
      (data["data"] ?? []).map((e) => OnBoardingModel.fromJson(e)),
    );

    if (data["key"] == 1) {
      emit(GetIntroSuccess());
    } else {
      emit(GetIntroFailure(error: data["msg"]));
    }
  }

  // Get Images

  List<File> profileImage = [];
  Future<void> getProfileImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    profileImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeProfileImage() {
    profileImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> orderImage = [];
  Future<void> getOrderImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    orderImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeOrderImage() {
    orderImage.clear();
    emit(RemoveImageSuccess());
  }

  String? profileImageUrl;
  Future uploadProfileImage() async {
    emit(UploadImagesLoading());
    final request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}api/upload-image"));
    request.fields['lang'] = CacheHelper.getLang();

    for (var image in profileImage) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
    }
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    Map<String, dynamic> data = jsonDecode(responseBody);
    profileImageUrl = data["app_url"];
    debugPrint("imageUrl is $profileImageUrl");

    if (data["key"] == 1) {
      emit(UploadImagesSuccess());
    } else {
      emit(UploadImagesFailure());
    }
  }

  String aboutUsTitle = '';
  Future aboutUs() async {
    emit(AboutUsLoading());
    http.Response response =
        await http.post(Uri.parse("${baseUrl}api/page"), body: {
      "lang": CacheHelper.getLang(),
      'user_id': CacheHelper.getUserId(),
      "title": "about",
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    aboutUsTitle = data["data"]['desc'];
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(AboutUsSuccess());
    } else {
      emit(AboutUsFailure(error: data["msg"]));
    }
  }

  String privacyPolicyTitle = '';
  Future privacyPolicy() async {
    emit(PrivacyPolicyLoading());
    http.Response response =
        await http.post(Uri.parse("${baseUrl}api/page"), body: {
      "lang": CacheHelper.getLang(),
      'user_id': CacheHelper.getUserId(),
      "title": "condition",
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    privacyPolicyTitle = data["data"]['desc'];
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(PrivacyPolicySuccess());
    } else {
      emit(PrivacyPolicyFailure(error: data["msg"]));
    }
  }

  Future contactUs({
    required String name,
    required String phone,
    required String message,
  }) async {
    emit(ContactUsLoading());
    http.Response response =
        await http.post(Uri.parse("${baseUrl}api/contact-us"), body: {
      "lang": CacheHelper.getLang(),
      'user_id': CacheHelper.getUserId(),
      "name": name,
      "phone": phone,
      "message": message,
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      emit(ContactUsSuccess(message: data["msg"]));
    } else {
      emit(ContactUsFailure(error: data["msg"]));
    }
  }

  List<ChatMessagesModel> chatMessages = [];
  Map chatDetails = {};
  Future getChatMessages({
    required String salerId,
    String roomId = "",
    bool isloading = true,
  }) async {
    if (isloading) {
      emit(GetChatMessagesLoading());
    }
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/all-chats"), body: {
        "lang": CacheHelper.getLang(),
        "user_id": CacheHelper.getUserId(),
        "saler_id": salerId,
        "room_id": roomId,
      }).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data["key"] == 1) {
          chatDetails = data;
          debugPrint(chatDetails.toString());
          chatMessages = List<ChatMessagesModel>.from(
            (data["data"] ?? [])
                .map((e) => ChatMessagesModel.fromJson(e))
                .toList()
                .reversed,
          );

          emit(GetChatMessagesSuccess());
        } else {
          debugPrint(data["msg"]);
          emit(GetChatMessagesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(GetChatMessagesFailure(error: error.toString()));
      }
    }
  }

  Future sendMessage({required String message}) async {
    emit(SendMessageLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/store-chat"), body: {
        "lang": CacheHelper.getLang(),
        "from_id": CacheHelper.getUserId(),
        "to_id": CacheHelper.getUserType() == "saler"
            ? chatDetails["user_id"].toString()
            : chatDetails["saler_id"].toString(),
        "type": "text",
        "message": message,
      }).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data["key"] == 1) {
          debugPrint(data["data"].toString());
          emit(SendMessageSuccess());
          getChatMessages(
            salerId: chatDetails["saler_id"].toString(),
            roomId: chatDetails["room_id"].toString(),
            isloading: false,
          );
        } else {
          debugPrint(data["msg"]);
          emit(SendMessageFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(SendMessageFailure(error: error.toString()));
      }
    }
  }

  int buttonIndex = 0;
  void chanebuttonIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeIndex());
  }

  List<CitiesModel> citiesList = [];
  Future getSections() async {
    emit(GetSectionsLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/sections"), body: {
        "lang": CacheHelper.getLang(),
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          citiesList = List<CitiesModel>.from(
            (data["data"]["cities"] ?? []).map((e) => CitiesModel.fromJson(e)),
          );
          emit(GetSectionsSuccess());
        } else {
          emit(GetSectionsFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(GetSectionsFailure(error: error.toString()));
      }
    }
  }

  List<QuestionsModel> questionsList = [];
  Future getQuestions() async {
    emit(GetQuestionsLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/questions"), body: {
        "lang": CacheHelper.getLang(),
        "user_id": CacheHelper.getUserId(),
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          questionsList = List<QuestionsModel>.from(
            (data["data"] ?? []).map((e) => QuestionsModel.fromJson(e)),
          );
          emit(GetQuestionsSuccess());
        } else {
          emit(GetQuestionsFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(GetQuestionsFailure(error: error.toString()));
      }
    }
  }

  Map showUserMap = {};
  Future showUser() async {
    emit(ShowUserLoading());
    http.Response response =
        await http.post(Uri.parse("${baseUrl}api/show-user"), body: {
      "lang": CacheHelper.getLang(),
      "user_id": CacheHelper.getUserId(),
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    debugPrint(data.toString());

    if (data["key"] == 1) {
      showUserMap = data["data"];
      emit(ShowUserSuccess());
    } else {
      emit(ShowUserFailure(error: data["msg"]));
    }
  }

Future updateUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
  }) async {
    if (profileImage.isNotEmpty) {
      await uploadProfileImage();
    }
    emit(UpdateUserLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/update-user"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "password": password,
        if (profileImage.isNotEmpty) "avatar": profileImageUrl,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(UpdateUserSuccess(message: data["msg"]));
          profileImage.clear();
          profileImageUrl = null;
          showUser();
        } else {
          emit(UpdateUserFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(UpdateProfileFailure(error: error.toString()));
      }
    }
  }

List<NotificationsModel> notificationsModel = [];
  Future showNotifications() async {
    emit(ShowNotificationsLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/show-notification"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          notificationsModel = List<NotificationsModel>.from(
            (data["data"] ?? []).map((e) => NotificationsModel.fromJson(e)),
          );

          emit(ShowNotificationsSuccess(message: data["msg"]));
        } else {
          emit(ShowNotificationsFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(ShowNotificationsFailure(error: error.toString()));
      }
    }
  }

  Future deleteNotification({
    required String notificationId,
    required int index,
  }) async {
    emit(DeleteNotificationLoading());
    try {
      http.Response response = await http
          .post(Uri.parse("${baseUrl}api/delete-notification"), body: {
        "lang": CacheHelper.getLang(),
        'notification_id': notificationId,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          notificationsModel.removeAt(index);
          emit(DeleteNotificationSuccess(message: data["msg"]));
          // showNotifications();
        } else {
          emit(DeleteNotificationFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(DeleteNotificationFailure(error: error.toString()));
      }
    }
  }
}
