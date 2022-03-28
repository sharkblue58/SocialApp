import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/layout/cubit/cubit.dart';
import 'package:my_social_app/layout/cubit/states.dart';
import 'package:my_social_app/models/message_model/message_model.dart';
import 'package:my_social_app/models/user_model/user_model.dart';
import 'package:my_social_app/shared/style/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
 var textController=TextEditingController();
 late SocialUserModel userModel;
ChatDetailsScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(reciverId: userModel.uId);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener:(context,state){} ,
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(width:15,),
                    Text('${userModel.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition:SocialCubit.get(context).messages.length>0 ,
                builder:(context)=>Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                   Expanded(
                     child: ListView.separated(
                       physics: BouncingScrollPhysics(),
                         itemBuilder: (context, index) {
                           var message=SocialCubit.get(context).messages[index];
                           if(SocialCubit.get(context).userModel.uId==message.senderId)
                             return buildMyMessage(message);
                           else
                             return  buildMessage(message);
                         } ,
                         separatorBuilder: (context,index)=>SizedBox(height:15,),
                         itemCount: SocialCubit.get(context).messages.length,
                     ),
                   ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,

                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:textController ,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...',
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(reciverId: userModel.uId, dateTime: DateTime.now().toString(), text: textController.text);
                                },
                                child:Icon(Icons.send,size:16,color: Colors.white,) ,
                                minWidth: 1.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback:(context)=>Center(child: CircularProgressIndicator()) ,
              ),
            );
          },
        );
      },
    );
  }
  Widget buildMessage(MessageModel model)=>Align(
    alignment:AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(bottomEnd:Radius.circular(10) ,topEnd:Radius.circular(10) ,topStart:Radius.circular(10) ),
        ),
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        child: Text('${model.text}')
    ),
  );
 Widget buildMyMessage(MessageModel model)=>Align(
   alignment:AlignmentDirectional.centerEnd,
   child: Container(
       decoration: BoxDecoration(
         color: defaultColor.withOpacity(0.2),
         borderRadius: BorderRadiusDirectional.only(bottomStart:Radius.circular(10) ,topEnd:Radius.circular(10) ,topStart:Radius.circular(10) ),
       ),
       padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
       child: Text('${model.text}')
   ),
 );
}
