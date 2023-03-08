// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    NewsCubit.get(context).itemSelected=0;

    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state)=>NewsCubit(),
      builder: (context,state){
         var list =NewsCubit.get(context).lists[1];
         return  articleBuilder(list);
      },
    );
  }
}
