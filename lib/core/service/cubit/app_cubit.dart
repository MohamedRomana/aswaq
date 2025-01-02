import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../cache/cache_helper.dart';
import '../../constants/contsants.dart';
import '../../models/on_boarding_model.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int bottomNavIndex = 0;
  List<Widget> bottomNavScreens = [
    // const Home(),
    // const Orders(),
    // const Requirements(),
    // const More(),
  ];

  int paymentIndex = -1;
  void changePaymentIndex({required int index}) {
    paymentIndex = index;
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

  List<File> lastVisaImage = [];
  Future<void> getLastVisaImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    lastVisaImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeLastVisaImage() {
    lastVisaImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> originalPassportImage = [];
  Future<void> getoriginalPassportImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    originalPassportImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeoriginalPassportImage() {
    originalPassportImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> personalImage = [];
  Future<void> getpersonalImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    personalImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removepersonalImage() {
    personalImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> personalImage2 = [];
  Future<void> getpersonalImage2() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    personalImage2 = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removepersonalImage2() {
    personalImage2.clear();
    emit(RemoveImageSuccess());
  }

  List<File> cashImage = [];
  Future<void> getcashImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    cashImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removecashImage() {
    cashImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> originalSalaryImage = [];
  Future<void> getoriginalSalaryImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    originalSalaryImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeoriginalSalaryImage() {
    originalSalaryImage.clear();
    emit(RemoveImageSuccess());
  }

  List<File> identityImage = [];
  Future<void> getIdentityImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    identityImage = pickedImages
        .map((pickedImage) => File(pickedImage.path))
        .take(1)
        .toList();
    emit(ChooseImageSuccess());
  }

  void removeIdentityImage() {
    identityImage.clear();
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
