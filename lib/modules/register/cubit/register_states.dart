

abstract class SocialRegisterStates {}
class SocialRegisterIntialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterErrorState({required this.error});
}
class SocialCreateUserSuccessState extends SocialRegisterStates{}
class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState({required this.error});
}
class SocialRegisterChangePasswordVisibiliyState extends SocialRegisterStates{}