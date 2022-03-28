import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:my_social_app/models/user_model/user_model.dart';
import 'package:my_social_app/modules/register/cubit/register_states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterIntialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);
  IconData suffix =Icons.visibility_outlined;
  bool ispassword=true;

void userRegister({required String name,required String email,required String password,required String phone}){
  emit(SocialRegisterLoadingState());
 FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: email,
     password: password
 ).then((value) {
   print(value.user?.email);
   createUser(email:email ,name:name ,phone:phone ,uId:value.user!.uid );

 }).catchError((error){print(error.toString());emit(SocialRegisterErrorState(error: error.toString()));});
 
}


  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  })
  {
    SocialUserModel model=new SocialUserModel(
      email: email,
      name: name,
      phone:phone,
      uId: uId,
      isEmailVerified:false,
      image: 'https://img.freepik.com/free-photo/cheerful-young-sports-man-posing-showing-thumbs-up-gesture_171337-8194.jpg?t=st=1647380696~exp=1647381296~hmac=f00257eab59a6f4ce45e69144f86cd426de99ebe17501166eb7f56c8e23c2d7e&w=1060',
      bio: 'write your bio ...',
      cover: 'https://img.freepik.com/free-vector/characters-people-holding-positive-emoticons-illustration_53876-26818.jpg?t=st=1647564429~exp=1647565029~hmac=9c21384f802171af08beba0015346a4941c1e2fe3daef30d403a80b860eb4ec3&w=996',
    );
     FirebaseFirestore.instance
         .collection('users')
         .doc(uId)
         .set(model.toMap())
         .then((value) {
       emit(SocialCreateUserSuccessState());
     }).catchError((error){emit(SocialCreateUserErrorState(error: error.toString()));});
  }

void changePasswordVisibility(){

  ispassword=!ispassword;
  suffix=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(SocialRegisterChangePasswordVisibiliyState());
}

}