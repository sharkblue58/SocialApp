import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/social_layout.dart';
import '../../shared/component/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/social_register_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailcontroller =TextEditingController();
  var passwordcontroller =TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>SocialLoginCubit() ,
       child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
         listener:(context,state){

           if(state is SocialLoginErrorState)
             {
               toast(message: state.error.toString(), toaststate:Toaststate.error);
             }else if(state is SocialLoginSuccessState){
             toast(message: 'you are Successfuly Login', toaststate:Toaststate.success);
             CacheHelper.saveData(key: 'uId', value:state.uId).then((value) {
                   nevigateAndFinish(context,SocialLayout());
             });

           }

         } ,
         builder: (context,state){
           return Scaffold(

             appBar: AppBar(),
             body: Center(
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Form(
                     key: formkey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('LOGIN',style:Theme.of(context).textTheme.headline4!.copyWith(color:Colors.black,),),
                         Text('Login now to communicate with your friends',style:Theme.of(context).textTheme.bodyText1!.copyWith(color:Colors.grey),),
                         SizedBox(height:30 ,),
                         buildlogintextfield(
                             circle:0 ,
                             controller:emailcontroller ,
                             lable:'Email Address' ,
                             prefix:Icons.email_outlined ,
                             type:TextInputType.emailAddress,
                             validator: (value){

                               if (value!.isEmpty)
                               {
                                 return 'Email Must Not Be Empty';
                               }
                               return null;
                             }),
                         SizedBox(height: 15,)
                         ,
                         buildlogintextfield(
                             circle:0 ,
                             controller:passwordcontroller ,
                             lable:'Password' ,
                             prefix:Icons.lock_outlined ,
                             suffix:SocialLoginCubit.get(context).suffix ,
                             type:TextInputType.visiblePassword,
                             ispassword:SocialLoginCubit.get(context).ispassword ,
                             onsuffixpress:(){SocialLoginCubit.get(context).changePasswordVisibility();},
                             onsubmit: (value){
                                         if(formkey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                             },
                             validator: (value){

                               if (value!.isEmpty)
                               {
                                 return 'password Must Not Be Short';
                               }
                               return null;
                             }),
                         SizedBox(height: 30,),
                         ConditionalBuilder(
                           condition: state is! SocialLoginLoadingState,
                           builder:(context)=>defultbutton(function:()
                           {
                      if(formkey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                                email: emailcontroller.text,
                                password: passwordcontroller.text);
                          }
                           } , text: 'login'),
                           fallback:(context)=>CircularProgressIndicator() ,
                         ),
                         SizedBox(height: 15,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('Don\'t have an account ?'),
                             SizedBox(width:5,),
                             defulttextbutton(text:'Register now',function:()
                             {
                               nevigateTo(context,SocialRegisterScreen());
                             }
                             ),
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           );
         },

       ),

    );
  }
}
