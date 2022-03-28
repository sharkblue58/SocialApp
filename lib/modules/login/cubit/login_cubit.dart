import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'login_states.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialLoginIntialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);
  IconData suffix =Icons.visibility_outlined;
  bool ispassword=true;

void userLogin({required String email,required String password}){
  emit(SocialLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
  ).then((value){
    emit(SocialLoginSuccessState(uId: value.user!.uid));
  }).catchError((error){emit(SocialLoginErrorState(error: error.toString()));});
}

void changePasswordVisibility(){

  ispassword=!ispassword;
  suffix=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(SocialChangePasswordVisibiliyState());
}

}