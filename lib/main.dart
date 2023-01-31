// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/theme.dart';


void main() async {
  //بيتاكد ان كل حاجه هنا في المبثود خلصت بعدين بيرن الابلكيشن
   WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
 DioHelper.init();
  await CacheHelper.init();
   bool? isDark= CacheHelper.getBoolData(key: 'isDark',);

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness()..getSports()..getScience()..changeMode(fromCache:isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){},
        builder: (context,state){

          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode:(NewsCubit.get(context).isDark)?ThemeMode.dark:ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );

  }

}