// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/web_view/desktop.dart';
import '../../layout/news_app/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';

class SearchScreen extends StatelessWidget {
   TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    NewsCubit.get(context).itemSelected=0;

    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state)=>NewsCubit() ,
      builder: (context,state){
        var list=NewsCubit.get(context).search;
        String? url;
        if(list.isNotEmpty) {
           url=list[NewsCubit.get(context).itemSelected]['url'];
        }
        return Scaffold(
          appBar: AppBar(),
          body: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultFromField(
                          context: context,
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if(value!.isEmpty) return 'search must be not empty';
                            return null;
                          },
                          labelText: 'Search',
                          prefix: Icons.search,
                          onChange: (value){
                            NewsCubit.get(context).getSearch(value);
                          }
                      ),
                    ),
                    Expanded(child: articleBuilder(list,isSearch: true)),
                  ],
                ),
              ),
              if(url!=null&&NewsCubit.get(context).isDesktop)
                Expanded(
                  child:WebViewDesktop(url),
                ),

            ],
          ),
        );
      },
    );
  }
}
