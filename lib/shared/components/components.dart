
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../modules/web_view/web_view_screen.dart';

Widget defaultFromField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType keyboardType,
  Function? onSubmit,
  Function(String)? onChange,
  required String? Function(String?) validator,
  required String labelText,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixOnPressed,
  bool isPassword=false,
})=> TextFormField(
  controller: controller,
  keyboardType: keyboardType,
  onFieldSubmitted: (v){
    onSubmit!(v);
  },
  onChanged: onChange,
  validator:validator ,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: labelText,
    labelStyle: Theme.of(context).textTheme.labelMedium,
    border: OutlineInputBorder(),
    prefixIcon: prefix!=null?Icon(
        prefix,
      color: Theme.of(context).iconTheme.color,
    ):null,
    suffixIcon:suffix!=null?IconButton(
      icon: Icon(
        suffix
      ),
      onPressed: suffixOnPressed,

    ):null,
  ),
  style:TextStyle(
      color:Theme.of(context).iconTheme.color,
  ),
  textDirection:TextDirection.ltr,
);

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
   navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(

              image: NetworkImage('${(article["urlToImage"])??'https://t3.ftcdn.net/jpg/02/44/17/82/360_F_244178265_NP4S8WdlZRGYVSkVkxhtiDonSfQPAbyO.jpg' }'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(width: 20.0,),

        Expanded(

          child: SizedBox(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text('${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt'].substring(0,10)}  ${article['publishedAt'].substring(11,16)}',

                  style: TextStyle(

                    fontSize: 16.0,

                    color: Colors.grey,

                  ),

                ),





              ],

            ),

          ),

        ),

      ],

    ),

  ),
);
Widget divider()=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: Container(
    height: 1,
    color: Colors.grey,
  ),
);
Widget articleBuilder(List<dynamic> list,{bool isSearch =false,})=>ConditionalBuilder(
  condition: list.isNotEmpty,
  builder:(context)=> ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder:(context,index)=>buildArticleItem(list[index],context),
    separatorBuilder:(context,index)=>divider(),
    itemCount:list.length ,
  ),
  fallback:(context)=> Center(child:isSearch?Container():CircularProgressIndicator()),
);
void navigateTo(context,Widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>Widget
    ),
);