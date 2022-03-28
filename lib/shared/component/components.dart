import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/login/social_login_screen.dart';
import '../network/local/cache_helper.dart';



void nevigateTo(context, Widget)=>Navigator.push(context, MaterialPageRoute(builder:(context)=> Widget,));
void nevigateAndFinish(context, Widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder:(context)=> Widget,),
      (route)=>false,
);
Widget buildlogintextfield(
    {
      required TextEditingController controller,
      required TextInputType type ,
      required String lable,
      required IconData prefix,
      IconData? suffix,
      required double circle,
      required var validator,
      var onsubmit ,
      var onchange,
      var onsuffixpress,
      bool ispassword=false,


    }
    )=> TextFormField(

  keyboardType:type,
  controller: controller,
  validator:validator ,
  obscureText: ispassword,
  decoration: InputDecoration(
    labelText: lable,
    prefixIcon:Icon(
      prefix,
    ),
    suffixIcon:IconButton(
      onPressed:onsuffixpress,
      icon:Icon(suffix) ,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(circle),
    ),

  ),
  onFieldSubmitted:onsubmit,
  onChanged:onchange,

);

Widget defultbutton ({
  double width=double.infinity,
  Color background=Colors.blue,
  required var function,
  required String text,
})=>Container(
  width:width,
  height:40,
  color:background,
  child: MaterialButton(
    onPressed:function
    ,
    child:Text(text.toUpperCase(),style:TextStyle(color:Colors.white),) ,

  ),
);

Widget defulttextbutton ({
  required var function,
  required String text,
})=>
    TextButton(onPressed: function, child: Text(text));

Future<bool?> toast({
  required String message,
  required Toaststate toaststate
})=> Fluttertoast.showToast(
    msg:  '$message',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color(toaststate),
    textColor: Colors.black,
    fontSize: 16.0
);
enum Toaststate{success,error,warrning}
Color color(Toaststate state)
{
  switch(state)
  {
    case Toaststate.success:
      return Colors.green;
    case Toaststate.error:
      return Colors.red;
    case Toaststate.warrning:
      return Colors.yellow;
  }

}

void signOut(context){

  CacheHelper.removeData(key: 'token',).then((value) =>
  {
    if(value){
      nevigateAndFinish(context,SocialLoginScreen())
    }

  });
}

dynamic defaultAppBar({ var title,var actions, context})=>AppBar(
  leading:IconButton(onPressed:(){Navigator.pop(context);} ,icon:Icon(Icons.arrow_back_ios_outlined)),
  title: Text(title),
  titleSpacing: 5,
  actions:actions,
);

