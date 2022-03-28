import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/layout/cubit/cubit.dart';
import 'package:my_social_app/layout/cubit/states.dart';
import 'package:my_social_app/models/post_model/post_model.dart';
import '../../shared/style/colors.dart';

class FeedsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder: (context,state){
        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.length>0 ,
          builder: (context)=> SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      Image(
                        image:NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?w=1060') ,
                        fit:BoxFit.cover ,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Communicate With Friends',style: Theme.of(context).textTheme.subtitle1?.copyWith(color:Colors.white),),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap:true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder:(context, index) =>SizedBox(height:8,) ,
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(height:8,)
              ],
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  Widget buildPostItem(PostModel model,context,index)=>Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal:8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(width:15,),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row( children: [
                          Text('${model.name}',style: TextStyle(height:1.4),),
                          SizedBox(width:5,),
                          Icon(Icons.check_circle,color:defaultColor,size:16,),
                        ]),
                        Text('${model.dateTime}',style: Theme.of(context).textTheme.caption?.copyWith(height:1.4),),
                      ],
                    )
                ),
                SizedBox(width:15,),
                IconButton(onPressed: (){}, icon:Icon(Icons.more_horiz,size:20,))

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text('${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:10,top: 5),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: Container(
                        height:25,
                        child: MaterialButton(
                          onPressed: (){},
                          child: Text('#software',style:Theme.of(context).textTheme.caption?.copyWith(color:defaultColor),),height:25.0,padding:EdgeInsets.zero,minWidth:1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: Container(
                        height:25,
                        child: MaterialButton(
                          onPressed: (){},
                          child: Text('#flutter',style:Theme.of(context).textTheme.caption?.copyWith(color:defaultColor),),height:25.0,padding:EdgeInsets.zero,minWidth:1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(model.postImage!='')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15),
              child: Container(
                height: 140,
                width: double.infinity,
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(4),
                    image:DecorationImage(
                      image:NetworkImage('${model.postImage}') ,
                      fit:BoxFit.cover ,
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:5),
                        child: Row(
                          children: [
                            Icon(Icons.favorite_outline,size:16,color:Colors.red,),
                            SizedBox(width:5,),
                            Text(/*'${SocialCubit.get(context).likes[index]}'*/'',style:Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                      onTap:(){} ,
                    ),
                  ),
                  Expanded(
                    child: InkWell(

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:5),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            Icon(Icons.mode_comment_outlined,size:16,color:Colors.grey,),
                            SizedBox(width:5,),
                            Text('0 comment',style:Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                      onTap:(){} ,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}'),
                        ),
                        SizedBox(width:15,),
                        Text('write a comment ...',style: Theme.of(context).textTheme.caption,),

                      ],
                    ),
                    onTap:(){},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.favorite_outline,size:16,color:Colors.red,),
                      SizedBox(width:5,),
                      Text('like',style:Theme.of(context).textTheme.caption,),
                    ],
                  ),
                  onTap:(){
                SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  } ,
                ),

              ],
            )

          ],
        ),
      )
  );

}
