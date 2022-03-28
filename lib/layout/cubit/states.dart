

abstract class SocialStates {}
class SocialIntialState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{

  final String error;
  SocialGetUserErrorState({required this.error});
}
class SocialChangeBottomNavState extends SocialStates{}
class SocialNewPostState extends SocialStates{}
class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}
class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}
class SocialUserUpdateErrorState extends SocialStates{}
class SocialUserUpdateLoadingState extends SocialStates{}

//post states
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}

class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;
  SocialGetPostsErrorState({required this.error});
}


class SocialLikePostsSuccessState extends SocialStates{}
class SocialLikePostsErrorState extends SocialStates{
  final String error;
  SocialLikePostsErrorState({required this.error});
}

class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{

  final String error;
  SocialGetAllUsersErrorState({required this.error});
}
//chat
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessagesSuccessState extends SocialStates{}
