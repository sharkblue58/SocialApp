import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/layout/cubit/cubit.dart';
import 'package:my_social_app/layout/cubit/states.dart';
import '../modules/new_post/new_post_screen.dart';
import '../shared/component/components.dart';


class SocialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){

        if(state is SocialNewPostState)
          {
            nevigateTo(context,NewPostScreen() );
          }

      },
      builder:(context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar:AppBar(
            title: Text(cubit.titles[cubit.currentindex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
              onTap:(index){
                cubit.changeBottomNav(index);
              },
            currentIndex:cubit.currentindex ,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(Icons.upload),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(Icons.location_on),label: 'Location'),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
            ],
              ),

        );
      },
    );
  }
}
