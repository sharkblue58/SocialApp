
abstract class SocialLoginStates {}
class SocialLoginIntialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{
  final String uId;
  SocialLoginSuccessState({required this.uId});
}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState({required this.error});
}
class SocialChangePasswordVisibiliyState extends SocialLoginStates{}