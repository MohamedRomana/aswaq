import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aswaq/core/service/model/client_home_model.dart';
import 'package:aswaq/core/service/model/fav_list_model.dart';
import 'package:aswaq/core/service/model/show_provider_model.dart';
import 'package:aswaq/screens/users/home_layout/favorites/favorites.dart';
import 'package:aswaq/screens/users/home_layout/markets/markets.dart';
import 'package:aswaq/screens/users/home_layout/shopping_carts/shopping_carts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../screens/users/home_layout/home/home.dart';
import '../../../screens/users/home_layout/more/more.dart';
import '../../cache/cache_helper.dart';
import '../../constants/contsants.dart';
import '../model/all_providers_model.dart';
import '../model/cities_model.dart';
import '../model/data_model.dart';
import '../model/notifications_model.dart';
import '../model/on_boarding_model.dart';
import '../model/chat_messages_model.dart';
import '../model/question_model.dart';
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

  ClientHomeModel? clientHomeModel;
  Future clientHome() async {
    emit(ClientHomeLoading());
    try {
      http.Response response =
          await http.post(Uri.parse("${baseUrl}api/client_home"), body: {
        "lang": CacheHelper.getLang(),
        'user_id': CacheHelper.getUserId(),
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
  }) async {
    emit(GetSectionsLoading());
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
          "has_certificate": requestIndex == 1 ? "1" : "0",
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
}
