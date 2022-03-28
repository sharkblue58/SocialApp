import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/layout/cubit/cubit.dart';
import 'package:my_social_app/layout/cubit/states.dart';
import '../../shared/component/components.dart';
import '../edit_profile/edit_profile.dart';


class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height:190,
                child: Stack(
                  alignment:AlignmentDirectional.bottomCenter ,
                  children: [
                    Align(
                      alignment:AlignmentDirectional.topCenter ,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.only(topLeft:Radius.circular(4),topRight:Radius.circular(4)),
                            image:DecorationImage(
                              image:NetworkImage('${userModel.cover}') ,
                              fit:BoxFit.cover ,
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Text('${userModel.name}',
                style:Theme.of(context).textTheme.bodyText1,
              ),
              Text('${userModel.bio}',
                style:Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Posts',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('269',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Photos',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100k',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Followers',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('70',
                              style:Theme.of(context).textTheme.subtitle2,
                            ),
                            Text('Followings',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(onPressed: () { }, child:Text('Add Photos'),),
                  ),
                  SizedBox(width: 10,),
                  OutlinedButton(onPressed: () { nevigateTo(context,EditProfileScreen());}, child:Icon(Icons.edit_outlined,size:16,),),
                ],
              ),
              Row(children: [
                OutlinedButton(
                    onPressed: (){
                      FirebaseMessaging.instance.subscribeToTopic('announcements');
                    }, child:Text('Subscribe')),
                SizedBox(width:20 ,),
                OutlinedButton(onPressed: (){
                  FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                }, child:Text('UnSubscribe')),
              ],),
            ],
          ),
        );
      },
    );
  }
}
