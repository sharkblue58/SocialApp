import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_social_app/layout/cubit/states.dart';
import 'package:my_social_app/models/message_model/message_model.dart';
import 'package:my_social_app/models/post_model/post_model.dart';
import 'package:my_social_app/models/user_model/user_model.dart';
import 'package:my_social_app/modules/chats/chats_screen.dart';
import 'package:my_social_app/modules/feeds/feeds_screen.dart';
import 'package:my_social_app/modules/settings/settings_screen.dart';
import 'package:my_social_app/modules/maps/map_screen.dart';
import '../../modules/new_post/new_post_screen.dart';
import '../../shared/component/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialIntialState());

  static SocialCubit get(context)=>BlocProvider.of(context);

 SocialUserModel userModel=new SocialUserModel(email:'',name:'',phone:'',uId:'',isEmailVerified:false,image:'',cover:'',bio:'')  ;

void getUserData(){
  emit(SocialGetUserLoadingState());
  FirebaseFirestore
      .instance
      .collection('users')
      .doc(uId)
      .get()
  .then((value) {
    print(value.data());
    userModel=SocialUserModel.fromJson(value.data());
    emit(SocialGetUserSuccessState());
  }).catchError((error){emit(SocialGetUserErrorState(error: error.toString()));});
}

int currentindex=0;
List<Widget>screens=[
FeedsScreen(),
  ChatsScreen(),
  NewPostScreen(),
  MapScreen(),
  SettingsScreen(),
];
  List<String>titles=[
       'Home',
       'Chats',
       'Post',
       'Map',
       'Profile',
  ];
void changeBottomNav(int index)
{

if(index==1)
  getUsers();
if(index==2)
  emit(SocialNewPostState());
else{
  currentindex=index;
  emit(SocialChangeBottomNavState());
   }

}

    File? profileImage;
  var picker =ImagePicker();
  Future<void> getProfileImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null)
    {
      profileImage=  File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('No image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null)
    {
      coverImage=File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print('No image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
      })
  {

         firebase_storage
             .FirebaseStorage
             .instance.ref()
             .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
             .putFile(profileImage!)
             .then((value){
                print(value);
               value.ref.getDownloadURL().then((value){
                 emit(SocialUploadProfileImageSuccessState());
                 print(value);
                 updateUser(phone:phone ,bio:bio ,name:name,profile:value);
               }).catchError((error){emit(SocialUploadProfileImageErrorState());});
         })
             .catchError((error){emit(SocialUploadProfileImageErrorState());});
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
  {

    firebase_storage
        .FirebaseStorage
        .instance.ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      print(value);
      value.ref.getDownloadURL().then((value){
        emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name:name ,bio:bio ,phone:phone ,cover:value);
      }).catchError((error){emit(SocialUploadCoverImageErrorState());});
    })
        .catchError((error){emit(SocialUploadCoverImageErrorState());});
  }



  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? profile,
    String? cover
  })
  {
    SocialUserModel model=new SocialUserModel(
      name:name,
      phone:phone ,
      bio:bio ,
      uId:userModel.uId ,
      cover:cover??userModel.cover ,
      email:userModel.email ,
      image:profile??userModel.image ,
      isEmailVerified:false ,
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){emit(SocialUserUpdateErrorState());});
  }

  File? postImage;
  Future<void> getPostImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null)
    {
      postImage=File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else{
      print('No image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage
        .FirebaseStorage
        .instance.ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      print(value);
      value.ref.getDownloadURL().then((value){
        print(value);
        createPost(dateTime: dateTime, text: text,postImage:value);
      }).catchError((error){emit(SocialCreatePostErrorState());});
    })
        .catchError((error){emit(SocialCreatePostErrorState());});
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  })
  {
    emit(SocialCreatePostLoadingState());
    PostModel model=new PostModel(name:userModel.name ,image:userModel.image ,uId: userModel.uId,dateTime:dateTime,text:text,postImage:postImage??'');
    FirebaseFirestore
        .instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
         emit(SocialCreatePostSuccessState());
    })
        .catchError((error){emit(SocialCreatePostErrorState());});
  }

  List<PostModel>posts=[];
  List<String>postsId=[];
  List<int>likes=[];
  void getPosts()
  {
    emit(SocialGetPostsLoadingState());
     FirebaseFirestore
         .instance
         .collection('posts')
         .get()
         .then((value){

           value.docs.forEach((element) {
/*              element
                 .reference
                 .collection('likes')
                 .get()
                 .then((value){
               likes.add(value.docs.length);*/
               posts.add(PostModel.fromJson(element.data()));
               postsId.add(element.id);
       /*    }).catchError((){});
*/
           });


           emit(SocialGetPostsSuccessState());
     })
         .catchError((error){emit(SocialGetPostsErrorState(error: error.toString()));});
  }


  void likePost(String postId)
  {
     FirebaseFirestore
         .instance
         .collection('posts')
         .doc(postId)
         .collection('likes')
         .doc(userModel.uId)
         .set({'like':true})
         .then((value){
           emit(SocialLikePostsSuccessState());
     })
         .catchError((error){emit(SocialLikePostsErrorState(error: error));});
  }
  List<SocialUserModel>users=[];
  void getUsers(){
    emit(SocialGetAllUsersLoadingState());
    if(users.length==0)
    FirebaseFirestore
        .instance
        .collection('users')
        .get()
        .then((value){

      value.docs.forEach((element) {

        if(element.data()['uId']!=userModel.uId)
        users.add(SocialUserModel.fromJson(element.data()));

      });
      emit(SocialGetAllUsersSuccessState());
    })
        .catchError((error){emit(SocialGetAllUsersErrorState(error: error.toString()));});
  }

  void sendMessage({
  required String reciverId,
    required String dateTime,
    required String text,
}){
      MessageModel model = MessageModel(
        text:text ,
        dateTime:dateTime ,
        reciverId:reciverId,
        senderId: userModel.uId,
      );
      //set my chat
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uId)
          .collection('chats')
          .doc(reciverId)
          .collection('messages')
          .add(model.toMap())
      .then((value) {emit(SocialSendMessageSuccessState());})
          .catchError((error){emit(SocialSendMessageErrorState());});
        //set his chat
      FirebaseFirestore.instance
          .collection('users')
          .doc(reciverId)
          .collection('chats')
          .doc(userModel.uId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {emit(SocialSendMessageSuccessState());})
          .catchError((error){emit(SocialSendMessageErrorState());});
  }

  List<MessageModel>messages=[];
  void getMessages({required String reciverId,}){
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
           messages=[];
          event.docs.forEach(
                  (element) {
                  messages.add(MessageModel.fromJson(element.data()));
                  });
          emit(SocialGetMessagesSuccessState());
    });


  }

}