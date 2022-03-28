import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/layout/cubit/states.dart';
import 'package:my_social_app/shared/component/components.dart';
import '../../layout/cubit/cubit.dart';

class EditProfileScreen extends StatelessWidget {
var nameController=TextEditingController();
var bioController=TextEditingController();
var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener:(context,state){} ,
      builder:(context,state){
      var userModel=SocialCubit.get(context).userModel;
      var profileImage=SocialCubit.get(context).profileImage;
      var coverImage=SocialCubit.get(context).coverImage;
      dynamic imo=NetworkImage('${userModel.image}');
      if(profileImage==null){imo= NetworkImage('${userModel.image}');}else{imo=FileImage(profileImage);}
      dynamic imo2=NetworkImage('${userModel.cover}');
      if(coverImage==null){imo2= NetworkImage('${userModel.cover}');}else{imo2=FileImage(coverImage);}
      nameController.text=userModel.name;
      bioController.text=userModel.bio;
      phoneController.text=userModel.phone;
      return Scaffold(
        appBar:defaultAppBar(context: context,title: 'Edit Profile',actions:[defulttextbutton(function:(){SocialCubit.get(context).updateUser(name:nameController.text , phone: phoneController.text, bio: bioController.text);} ,text: 'Update'),SizedBox(width:15,)]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(state is SocialUserUpdateLoadingState)
               LinearProgressIndicator(),
                SizedBox(height: 10,),
                Container(
                  height:190,
                  child: Stack(
                    alignment:AlignmentDirectional.bottomCenter ,
                    children: [
                      Align(
                        alignment:AlignmentDirectional.topCenter ,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.only(topLeft:Radius.circular(4),topRight:Radius.circular(4)),
                                  image:DecorationImage(
                                    image:imo2 ,
                                    fit:BoxFit.cover ,
                                  )
                              ),
                            ),
                            IconButton(onPressed: (){SocialCubit.get(context).getCoverImage();}, icon:CircleAvatar(child: Icon(Icons.camera_alt_outlined,size:16,),radius:20,)),
                          ],
                        ),
                      ),
                      Stack(
                        alignment:AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:imo,
                            ),
                          ),
                          IconButton(onPressed: (){SocialCubit.get(context).getProfileImage();}, icon:CircleAvatar(child: Icon(Icons.camera_alt_outlined,size:16,),radius:20,))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                if(profileImage!=null||coverImage!=null)
                Row(
                  children: [
                  if(profileImage!=null)
                    Expanded(
                        child: Column(
                          children: [
                            defultbutton(function:(){
                              SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                            } ,text: 'upload profile '),
                            SizedBox(height:5 ,),
                            // LinearProgressIndicator(),
                          ],
                        )
                    ),
                    SizedBox(width:5,),
                  if(coverImage!=null)
                    Expanded(child:Column(
                      children: [
                        defultbutton(function:(){SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);} ,text: 'upload cover '),
                        SizedBox(height:5 ,),
                        // LinearProgressIndicator(),
                      ],
                    ) ),
                  ],
                ),
                if(profileImage!=null||coverImage!=null)
                SizedBox(height: 20,),
                buildlogintextfield(
                    controller:nameController ,
                    type:TextInputType.name,
                    validator:(value){
                      if(value.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                      return null;
                    } ,
                    lable:'New Name' ,
                    prefix:Icons.supervised_user_circle_outlined,
                    circle:0
                ),
                SizedBox(height: 10,),
                buildlogintextfield(
                    controller:bioController ,
                    type:TextInputType.text,
                    validator:(value){
                      if(value.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    } ,
                    lable:' Bio here' ,
                    prefix:Icons.info_outline,
                    circle:0
                ),
                SizedBox(height: 10,),
                buildlogintextfield(
                    controller:phoneController ,
                    type:TextInputType.phone,
                    validator:(value){
                      if(value.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    } ,
                    lable:'phone' ,
                    prefix:Icons.phone,
                    circle:0
                ),


              ],
            ),
          ),
        ),
      );
      },
    );
  }
}
