import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/layout/cubit/cubit.dart';
import 'package:my_social_app/layout/cubit/states.dart';
import 'package:my_social_app/models/user_model/user_model.dart';
import 'package:my_social_app/modules/chat_details/chat_details_screen.dart';

import '../../shared/component/components.dart';


class ChatsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder:(context,state){
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.length>0 ,
          builder:(context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder:(context,index)=> Container(color: Colors.grey,height:1,width:double.infinity,),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      } ,
    );
  }
  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    onTap:(){
      nevigateTo(context,ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width:15,),
          Text('${model.name}',style: TextStyle(height:1.4),)

        ],
      ),
    ),
  );
}
