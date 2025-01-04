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
import '../../models/on_boarding_model.dart';
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

  List<File> passportImage = [];
  Future<void> getPassportImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    passportImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removePassportImage() {
    passportImage.clear();
    emit(RemoveImageSuccess());
  }

  String? profileImageUrl;
  Future uploadProfileImage() async {
    emit(UploadImagesLoading());
    final request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}api/upload-image"));
    request.fields['lang'] = CacheHelper.getLang();

    for (var image in passportImage) {
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
}
