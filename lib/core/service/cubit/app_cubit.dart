import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aswaq/core/service/model/all_certificate_model.dart';
import 'package:aswaq/core/service/model/client_home_model.dart';
import 'package:aswaq/core/service/model/fav_list_model.dart';
import 'package:aswaq/core/service/model/show_cart_model.dart';
import 'package:aswaq/core/service/model/show_certificate_model.dart';
import 'package:aswaq/core/service/model/show_provider_model.dart';
import 'package:aswaq/screens/users/home_layout/favorites/favorites.dart';
import 'package:aswaq/screens/users/home_layout/markets/markets.dart';
import 'package:aswaq/screens/users/home_layout/shopping_carts/shopping_carts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../screens/users/home_layout/home/home.dart';
import '../../../screens/users/home_layout/more/more.dart';
import '../../cache/cache_helper.dart';
import '../../constants/contsants.dart';
import '../model/all_providers_model.dart';
import '../model/certificates_model.dart';
import '../model/data_model.dart';
import '../model/notifications_model.dart';
import '../model/on_boarding_model.dart';
import '../model/chat_messages_model.dart';
import '../model/question_model.dart';
import '../model/show_cart_items_model.dart';
import '../model/show_service_model.dart';
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

  bool hasCertificate = false;
  void changeCertificate() {
    hasCertificate = !hasCertificate;
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

  int changeFavIndex = 0;
  void changeFavIndexs({required int index}) {
    changeFavIndex = index;
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
  Future<void> getProfileImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      profileImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeProfileImage() {
    profileImage.clear();
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

  List citiesList = [];
  Future getCities() async {
    emit(GetSectionsLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/cities"), body: {
        "lang": CacheHelper.getLang(),
        "user_id": CacheHelper.getUserId(),
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          citiesList = data['data'];

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

  String cityId = '';
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
        if (cityId != "") "city_id": cityId,
        if (profileImage.isNotEmpty) "avatar": profileImageUrl,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(UpdateUserSuccess(message: data["msg"]));
          cityId = "";
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

  int changeFaqIndex = -1;

  void changeFaqIndexs({required int index}) {
    changeFaqIndex = index;

    emit(ChangeIndex());
  }

  ClientHomeModel? clientHomeModel;
  Future clientHome() async {
    emit(ClientHomeLoading());
    // Position? myPosition;
    // myPosition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // lat = myPosition.latitude;
    // lng = myPosition.longitude;
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/client_home"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        // "lat": lat.toString(),
        // "lng": lng.toString(),
      });
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          clientHomeModel = ClientHomeModel.fromJson(data["data"]);
          emit(ClientHomeSuccess());
        } else {
          emit(ClientHomeFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(ClientHomeFailure(error: error.toString()));
      }
    }
  }

  ShowProviderModel? showProviderModel;
  List subSections = [];
  Future showProvider({required String providerId}) async {
    emit(ShowProviderLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/show-provider"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "provider_id": providerId,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          showProviderModel = ShowProviderModel.fromJson(data["data"]);
          allServiceList = showProviderModel!.services;
          if (data["data"]["sub_sections"].length == 1) {
            subSections = data["data"]["sub_sections"];
          } else {
            subSections = [
              {"id": 0, "title": "الكل"}
            ];
            subSections.addAll(data["data"]["sub_sections"]);
          }
          emit(ShowProviderSuccess());
        } else {
          emit(ShowProviderFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(ShowProviderFailure(error: error.toString()));
      }
    }
  }

  List<AllServiceModel> allServiceList = [];

  Future allServices({required String subsectionId}) async {
    emit(AllServicesLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/services"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "sub_section_id": subsectionId,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          allServiceList = List<AllServiceModel>.from(
            (data["data"] ?? []).map((e) => AllServiceModel.fromJson(e)),
          );
          emit(AllServicesSuccess());
        } else {
          emit(AllServicesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(AllServicesFailure(error: error.toString()));
      }
    }
  }

  List<AllServiceModel> searchList = [];

  Future getSearch({required String title}) async {
    emit(GetSerachLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/services"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "title": title,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          searchList = List<AllServiceModel>.from(
            (data["data"] ?? []).map((e) => AllServiceModel.fromJson(e)),
          );
          emit(GetSearchSuccess(message: data["msg"]));
        } else {
          emit(GetSearchFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(GetSearchFailure(error: error.toString()));
      }
    }
  }

  ShowServiceModel? showServiceModel;
  List<ImagesList> serviceImages = [];

  Future showService({required String serviceId}) async {
    emit(ShowServiceLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/show-service"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "service_id": serviceId,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());
        if (data["key"] == 1) {
          serviceImages = List<ImagesList>.from(
            (data["data"]["images"] ?? []).map((e) => ImagesList.fromJson(e)),
          );
          showServiceModel = ShowServiceModel.fromJson(data["data"]);
          emit(ShowServiceSuccess());
        } else {
          emit(ShowServiceFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(ShowServiceFailure(error: error.toString()));
      }
    }
  }

  List<AllProvidersModel> allProvidersList = [];

  Future allProviders() async {
    emit(AllProvidersLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/providers"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          allProvidersList = List<AllProvidersModel>.from(
            (data["data"] ?? []).map((e) => AllProvidersModel.fromJson(e)),
          );
          emit(AllProvidersSuccess());
        } else {
          emit(AllProvidersFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(AllProvidersFailure(error: error.toString()));
      }
    }
  }

  List<Sections> sections = [];
  Future getData() async {
    emit(GetDataLoading());
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
          sections = List<Sections>.from(
            (data["data"]['sections'] ?? []).map((e) => Sections.fromJson(e)),
          );
          emit(GetDataSuccess());
        } else {
          emit(GetDataFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(GetDataFailure(error: error.toString()));
      }
    }
  }

  List serviceList = [];
  Future subSection({required String salerId}) async {
    emit(SubSectionsLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/sub_sections"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "saler_id": salerId,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          serviceList = data["data"]['services'];
          emit(SubSectionsSuccess());
        } else {
          emit(SubSectionsFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(SubSectionsFailure(error: error.toString()));
      }
    }
  }

  int marketIndex = 0;
  void changeMarketIndex({required int index}) {
    marketIndex = index;
    emit(ChangeIndex());
  }

  List sectionsProvidersList = [];
  Future allSections({
    required String sectionId,
    String? filter = "",
    bool isDistance = false,
    bool isFav = false,
  }) async {
    if (!isFav) {
      emit(GetSectionsLoading());
    } else {
      emit(AddFavoriteLoading());
    }

    if (isDistance) {
      Position? myPosition;
      myPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = myPosition.latitude;
      lng = myPosition.longitude;
    }

    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/sections"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "section_id": sectionId,
        if (isDistance) "lat": lat.toString(),
        if (isDistance) "lng": lng.toString(),
        "filter": filter,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());
        if (data["key"] == 1) {
          sectionsProvidersList = data["data"]['providers'];
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
        debugPrint(error.toString());
        emit(GetSectionsFailure(error: error.toString()));
      }
    }
  }

  Future addFavorite({required String providerId}) async {
    emit(AddFavoriteLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/add-to-favourite"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "provider_id": providerId,
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(AddFavoriteSuccess(message: data["msg"]));
          clientHome();
          allSections(
              sectionId: sections[marketIndex].id.toString(), isFav: true);
        } else {
          emit(AddFavoriteFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(AddFavoriteFailure(error: error.toString()));
      }
    }
  }

  List<Provicers> provicersList = [];
  Future showFavorite() async {
    emit(ShowFavoriteLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/show-favourites"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          provicersList = List<Provicers>.from(
            (data["data"]['provicers'] ?? []).map((e) => Provicers.fromJson(e)),
          );
          emit(ShowFavoriteSuccess());
        } else {
          emit(ShowFavoriteFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(ShowFavoriteFailure(error: error.toString()));
      }
    }
  }

  int removeFavIndex = 0;
  void changeRemoveFavIndex({required int index}) {
    removeFavIndex = index;
    emit(ChangeIndex());
  }

  Future removeFav({required String providerId, required int index}) async {
    emit(RemoveFavLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/add-to-favourite"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "provider_id": providerId,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          provicersList.removeAt(index);
          emit(RemoveFavSuccess());
        } else {
          debugPrint(data["msg"]);
          emit(RemoveFavFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(RemoveFavFailure(error: error.toString()));
      }
    }
  }

  Future addToCart({
    required String serviceId,
  }) async {
    emit(AddToCartLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/add-to-cart"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "service_id": serviceId,
          "count": count.toString(),
          "has_certificate": hasCertificate ? "1" : "0",
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(AddToCartSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(AddToCartFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(AddToCartFailure(error: error.toString()));
      }
    }
  }

  List<ShowCartModel> cartList = [];
  Future showCart() async {
    emit(ShowCartLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/show-cart"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          cartList = List<ShowCartModel>.from(
            (data["data"] ?? []).map((e) => ShowCartModel.fromJson(e)),
          );

          emit(ShowCartSuccess());
        } else {
          debugPrint(data["msg"]);
          emit(ShowCartFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(ShowCartFailure(error: error.toString()));
      }
    }
  }

  Future deleteCart({required String cartId}) async {
    emit(DeleteCartLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/delete-cart"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "cart_id": cartId,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(DeleteCartSuccess(message: data["msg"]));
          showCart();
        } else {
          debugPrint(data["msg"]);
          emit(DeleteCartFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(DeleteCartFailure(error: error.toString()));
      }
    }
  }

  ShowCartItemsModel? cartItemsModel;
  Future cartItems({required String cartItemId}) async {
    emit(CartItemsLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/show-cart-items"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "cart_id": cartItemId,
        },
      ).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          cartItemsModel = ShowCartItemsModel.fromJson(data["data"]);
          emit(CartItemsSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(CartItemsFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(CartItemsFailure(error: error.toString()));
      }
    }
  }

  int cartIndex = 0;
  void updateCartIndex({required int index}) {
    cartIndex = index;
    emit(ChangeIndexSuccess());
  }

  Future updateCart({
    required String cartItemId,
    required String cartId,
    required String count,
  }) async {
    emit(UpdateCartLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/update-to-cart"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "cart_item_id": cartItemId,
          "count": count,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(UpdateCartSuccess(message: data["msg"]));
          cartItems(cartItemId: cartId);
        } else {
          debugPrint(data["msg"]);
          emit(UpdateCartFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(UpdateCartFailure(error: error.toString()));
      }
    }
  }

  Future storeOrder({required String cartId}) async {
    emit(StoreOrderLoading());
    if (shipIndex == 0) {
      Position? myPosition;
      myPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final placeMarks = await placemarkFromCoordinates(
          myPosition.latitude, myPosition.longitude);
      lat = myPosition.latitude;
      lng = myPosition.longitude;
      address = placeMarks[0].street ?? "";
    }
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/store-order"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "cart_id": cartId,
          "payment_method": paymentIndex == 0 ? "online" : "cash",
          "has_delivery": paymentlocatIndex == 0 ? "1" : "0",
          if (shipIndex != -1) "my_address": shipIndex == 0 ? "1" : "0",
          if (shipIndex != -1) "address": address ?? "",
          if (shipIndex != -1) "lat": lat.toString(),
          if (shipIndex != -1) "lng": lng.toString(),
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(StoreOrderSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(StoreOrderFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(StoreOrderFailure(error: error.toString()));
      }
    }
  }

  List ordersList = [];
  Future allOrders() async {
    emit(AllOrdersLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/show-all-orders"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          ordersList = data["data"];
          // ordersList = List<AllOrdersModel>.from(
          //   (data["data"] ?? []).map((e) => AllOrdersModel.fromJson(e)),
          // );
          emit(AllOrdersSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(AllOrdersFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(AllOrdersFailure(error: error.toString()));
      }
    }
  }

  Map showOrdersModel = {};
  List showitems = [];
  Future showOrders({required String orderId}) async {
    emit(ShowOrdersLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/show-order"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "order_id": orderId,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          showOrdersModel = data['data'];
          showitems = data['data']['items'];
          emit(ShowOrdersSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(ShowOrdersFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(ShowOrdersFailure(error: error.toString()));
      }
    }
  }

  // Future deleteOrders({required String orderId, required int index}) async {
  //   emit(DeleteOrdersLoading());
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse("${baseUrl}api/show-order"),
  //       body: {
  //         "lang": CacheHelper.getLang(),
  //         "user_id": CacheHelper.getUserId(),
  //         "order_id": orderId,
  //       },
  //     ).timeout(const Duration(milliseconds: 8000));

  //     if (response.statusCode == 500) {
  //       emit(ServerError());
  //     } else {
  //       Map<String, dynamic> data = jsonDecode(response.body);
  //       debugPrint(data.toString());

  //       if (data["key"] == 1) {
  //         showOrdersModel?.items.removeAt(index);

  //         emit(DeleteOrdersSuccess(message: data["msg"]));
  //       } else {
  //         debugPrint(data["msg"]);
  //         emit(DeleteOrdersFailure(error: data["msg"]));
  //       }
  //     }
  //   } catch (error) {
  //     if (error is TimeoutException) {
  //       debugPrint("Request timed out");
  //       emit(Timeoutt());
  //     } else {
  //       emit(DeleteOrdersFailure(error: error.toString()));
  //     }
  //   }
  // }

  List<File> orderImage = [];
  Future<void> getOrderImage(BuildContext context) async {
    final picker = ImagePicker();
    final int? pickedOption = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.select_image_source.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption == null) return;

    XFile? pickedImage;

    if (pickedOption == 1) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (pickedOption == 2) {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        pickedImage = pickedImages.first;
      }
    }

    if (pickedImage != null) {
      orderImage = [File(pickedImage.path)];
      emit(ChooseImageSuccess());
    }
  }

  void removeOrderImage() {
    orderImage.clear();
    emit(RemoveImageSuccess());
  }

  Future restoreOrder({
    required String orderId,
    required String message,
  }) async {
    emit(RestoreOrderLoading());
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse("${baseUrl}api/contact-us"));
      request.fields['lang'] = CacheHelper.getLang();
      request.fields['user_id'] = CacheHelper.getUserId();
      request.fields['order_id'] = orderId;
      request.fields['message'] = message;
      request.fields['type'] = 'restore';

      var stream = http.ByteStream(orderImage.first.openRead());
      var length = await orderImage.first.length();
      var multipartFile = http.MultipartFile(
        'photo',
        stream,
        length,
        filename: orderImage.first.path.split('/').last,
      );
      request.files.add(multipartFile);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 500) {
        emit(ServerError());
        debugPrint("Response Body: $responseBody");
      } else {
        Map<String, dynamic> data = jsonDecode(responseBody);
        if (data["key"] == 1) {
          emit(RestoreOrderSuccess(message: data["msg"]));
        } else {
          emit(RestoreOrderFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(RestoreOrderFailure(error: error.toString()));
      }
    }
  }

  Future storeCertificatesSections({required String title}) async {
    emit(StoreCertificatesLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/store-certificate-section"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "title": title,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(StoreCertificatesSuccess(message: data["msg"]));
          certificatesSections();
        } else {
          debugPrint(data["msg"]);
          emit(StoreCertificatesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(StoreCertificatesFailure(error: error.toString()));
      }
    }
  }

  List<CertificatesModel> certificatesList = [];
  Future certificatesSections() async {
    emit(CertificatesLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/all-certificate-sections"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          certificatesList = List<CertificatesModel>.from(
            (data["data"] ?? []).map((e) => CertificatesModel.fromJson(e)),
          );
          emit(CertificatesSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(CertificatesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(CertificatesFailure(error: error.toString()));
      }
    }
  }

  Future deleteCertificateSections({
    required String sectionId,
    required int index,
  }) async {
    emit(DeleteCertificatesLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/delete-certificate-section"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "section_id": sectionId,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          certificatesList.removeAt(index);
          emit(DeleteCertificatesSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(DeleteCertificatesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(DeleteCertificatesFailure(error: error.toString()));
      }
    }
  }

  List<AllCertificateModel> allCertificatesList = [];
  Future allCertificate({required String sectionId}) async {
    emit(AllCertificatesLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/all-certificates"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "section_id": sectionId,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          allCertificatesList = List<AllCertificateModel>.from(
            (data["data"] ?? []).map((e) => AllCertificateModel.fromJson(e)),
          );
          emit(AllCertificatesSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(AllCertificatesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(AllCertificatesFailure(error: error.toString()));
      }
    }
  }

  String sectionId = "";

  Future updateCertificate({
    required String certificateId,
  }) async {
    emit(UpdateCertificatesLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/update-certificate"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "section_id": sectionId,
          "certificate_id": certificateId,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(UpdateCertificatesSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(UpdateCertificatesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(UpdateCertificatesFailure(error: error.toString()));
      }
    }
  }

  ShowCertificateModel? showCertificateModel;
  Future showCertificate({required String certificateId}) async {
    emit(ShowCertificatesLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/show-certificate"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "certificate_id": certificateId,
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          showCertificateModel = ShowCertificateModel.fromJson(data['data']);
          emit(ShowCertificatesSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(ShowCertificatesFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(ShowCertificatesFailure(error: error.toString()));
      }
    }
  }

  Future transferCertificate({
    required String certificateId,
    required String name,
    required String phone,
    required String idNumber,
  }) async {
    emit(TransferCertificateLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${baseUrl}api/contact-us"),
        body: {
          "lang": CacheHelper.getLang(),
          "user_id": CacheHelper.getUserId(),
          "certificate_id": certificateId,
          "name": name,
          "phone": phone,
          "id_number": idNumber,
          "type": 'certificate',
        },
      ).timeout(const Duration(milliseconds: 8000));

      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(TransferCertificateSuccess(message: data["msg"]));
        } else {
          debugPrint(data["msg"]);
          emit(TransferCertificateFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        emit(TransferCertificateFailure(error: error.toString()));
      }
    }
  }

  Future userNotification({
    required bool sendNotify,
  }) async {
    emit(UserNotificationLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/update-user"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
        "send_notify": sendNotify == true ? "1" : "0",
      }).timeout(const Duration(milliseconds: 8000));
      if (response.statusCode == 500) {
        emit(ServerError());
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint(data.toString());

        if (data["key"] == 1) {
          emit(UserNotificationSuccess());
        } else {
          emit(UserNotificationFailure(error: data["msg"]));
        }
      }
    } catch (error) {
      if (error is TimeoutException) {
        debugPrint("Request timed out");
        emit(Timeoutt());
      } else {
        debugPrint(error.toString());
        emit(UserNotificationFailure(error: error.toString()));
      }
    }
  }
}
