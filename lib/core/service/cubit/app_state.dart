part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ChangeIndex extends AppState {}

final class GetCurrentLocationLoading extends AppState {}

final class GetCurrentLocationSuccess extends AppState {}

final class ServerError extends AppState {}

final class Timeoutt extends AppState {}

final class GetIntroLoading extends AppState {}

final class GetIntroSuccess extends AppState {}

final class ChangeBottomNav extends AppState {}

final class IsSecureIcon extends AppState {}

final class GetIntroFailure extends AppState {
  final String error;

  GetIntroFailure({required this.error});
}

final class AddAddressLoading extends AppState {}

final class AddAddressSuccess extends AppState {
  final String message;
  AddAddressSuccess({required this.message});
}

final class AddAddressFailure extends AppState {
  final String error;

  AddAddressFailure({required this.error});
}

final class DeleteAddressLoading extends AppState {}

final class DeleteAddressSuccess extends AppState {
  final String message;
  DeleteAddressSuccess({required this.message});
}

final class DeleteAddressFailure extends AppState {
  final String error;

  DeleteAddressFailure({required this.error});
}

final class ChooseImageSuccess extends AppState {}

final class RemoveImageSuccess extends AppState {}

final class UpdateProfileLoading extends AppState {}

final class UpdateProfileSuccess extends AppState {
  final String message;
  UpdateProfileSuccess({required this.message});
}

final class UpdateProfileFailure extends AppState {
  final String error;
  UpdateProfileFailure({required this.error});
}

final class UploadImagesLoading extends AppState {}

final class UploadImagesSuccess extends AppState {}

final class UploadImagesFailure extends AppState {}

final class AboutUsLoading extends AppState {}

final class AboutUsSuccess extends AppState {}

final class AboutUsFailure extends AppState {
  final String error;
  AboutUsFailure({required this.error});
}

final class ContactUsLoading extends AppState {}

final class ContactUsSuccess extends AppState {
  final String message;
  ContactUsSuccess({required this.message});
}

final class ContactUsFailure extends AppState {
  final String error;
  ContactUsFailure({required this.error});
}

final class PrivacyPolicyLoading extends AppState {}

final class PrivacyPolicySuccess extends AppState {}

final class PrivacyPolicyFailure extends AppState {
  final String error;
  PrivacyPolicyFailure({required this.error});
}
