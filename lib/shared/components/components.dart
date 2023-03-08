// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names, non_constant_identifier_names

import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/web_view/desktop.dart';
import '../../modules/web_view/web_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: (v) {
        onSubmit!(v);
      },
      onChanged: onChange,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        border: OutlineInputBorder(),
        prefixIcon: prefix != null
            ? Icon(
                prefix,
                color: Theme.of(context).iconTheme.color,
              )
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixOnPressed,
              )
            : null,
      ),
      style: TextStyle(
        color: Theme.of(context).iconTheme.color,
      ),
      textDirection: TextDirection.ltr,
    );


Widget articleBuilder(
    List<dynamic> list, {
      bool isSearch = false,
    }) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context,index),
      separatorBuilder: (context, index) => divider(),
      itemCount: list.length,
    ),
    fallback: (context) =>
        Center(child: isSearch ? Container() : CircularProgressIndicator()),
    );


Widget buildArticleItem(article, context,index) =>
    BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          return  InkWell(

            onTap: () {
              if(!NewsCubit.get(context).isDesktop&&!Platform.isWindows) {
                navigateTo(context, WebViewScreen(article['url']));
              }
              else{
                NewsCubit.get(context).changeSelected(index);
                if(!NewsCubit.get(context).isDesktop){
                  navigateTo(context, WebViewDesktop(article['url']));
                }
              }
            },
            child: Container(
              color:NewsCubit.get(context).itemSelected==index
              &&NewsCubit.get(context).isDesktop
                  ?Colors.deepOrange.withOpacity(0.3):null,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    SizedBox(
                        width: 120.0,
                        height: 100.0,
                        child: article['urlToImage'] != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loadingOrange.gif',
                            ),
                            imageUrl: '${article["urlToImage"]}',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/notAvailable.jpg',
                            ),
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset('assets/images/notAvailable.jpg'),
                        )),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${article['title']}',
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${article['publishedAt'].substring(0, 10)}  ${article['publishedAt'].substring(11, 16)}',
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
            ),
          );
        },
    );

Widget divider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );
