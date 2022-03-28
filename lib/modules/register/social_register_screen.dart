import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/layout/social_layout.dart';
import '../../shared/component/components.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class SocialRegisterScreen extends StatelessWidget {

  var namecontroller =TextEditingController();
  var emailcontroller =TextEditingController();
  var passwordcontroller =TextEditingController();
  var phonecontroller =TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener:(context,state){
          if(state is SocialCreateUserSuccessState)
            {
              toast(message: 'Successfly Registered', toaststate: Toaststate.success);
              nevigateAndFinish(context,SocialLayout());
            }
        },
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register',style:Theme.of(context).textTheme.headline4!.copyWith(color:Colors.black,),),
                        Text('Register now to communicate with your friends',style:Theme.of(context).textTheme.bodyText1!.copyWith(color:Colors.grey),),
                        SizedBox(height:30 ,),
                        buildlogintextfield(
                            circle:0 ,
                            controller:namecontroller ,
                            lable:'name' ,
                            prefix:Icons.person ,
                            type:TextInputType.name,
                            validator: (value){

                              if (value!.isEmpty)
                              {
                                return 'name Must Not Be Empty';
                              }
                              return null;
                            }),
                        SizedBox(height: 15,),
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
                            suffix:SocialRegisterCubit.get(context).suffix ,
                            type:TextInputType.visiblePassword,
                            ispassword:SocialRegisterCubit.get(context).ispassword ,
                            onsuffixpress:(){SocialRegisterCubit.get(context).changePasswordVisibility();},
                            onsubmit: (value){

                            },
                            validator: (value){

                              if (value!.isEmpty)
                              {
                                return 'password Must Not Be Short';
                              }
                              return null;
                            }),
                        SizedBox(height: 15,),
                        buildlogintextfield(
                            circle:0 ,
                            controller:phonecontroller ,
                            lable:'phone' ,
                            prefix:Icons.phone ,
                            type:TextInputType.phone,
                            validator: (value){

                              if (value!.isEmpty)
                              {
                                return 'phone Must Not Be Empty';
                              }
                              return null;
                            }),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition:state is !SocialRegisterLoadingState,
                          builder:(context)=>defultbutton(function:(){
                            if(formkey.currentState!.validate()) {
                              SocialRegisterCubit.get(context).userRegister(
                                name:namecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                phone: phonecontroller.text,
                              );
                            }
                          } , text: 'Register'),
                          fallback:(context)=>CircularProgressIndicator() ,
                        ),

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
