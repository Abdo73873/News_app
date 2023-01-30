// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/search_screen/search_screen.dart';
import 'package:news_app/shared/components/components.dart';


class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => NewsStates,
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        String country=cubit.country;
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText( 'News in',),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
                SizedBox(width: 5.0,),
                Text(cubit.title[cubit.currentIndex],
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context,SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                icon: Icon(
                  cubit.isDark?Icons.sunny:Icons.dark_mode,
                color: cubit.isDark?Colors.orange:Colors.deepOrange[500],
                ),
                onPressed: () {
                  NewsCubit.get(context).changeMode();

                },

              ),
              PopupMenuButton(
                icon: Text(country.toUpperCase()),
                color:Theme.of(context).scaffoldBackgroundColor,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemBuilder: (context)=>[
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='ar';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('Argentina',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.labelMedium?.color,
                        ),
                      ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='au';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('Australia',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.labelMedium?.color,
                        ),
                      ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='cn';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('China',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.labelMedium?.color,
                        ),
                      ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='eg';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('Egypt',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                  ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='fr';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('Frances',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                  ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='fr';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('Germany',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                  ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='ru';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('Russia',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                  ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='ru';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('Saudi Arabia',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                  ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='se';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('Sweden',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                  ),
                    ),),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: (){
                        country='us';
                        Navigator.of(context).pop();
                        cubit.changeCountry(country);
                      },
                      child: Text('United State',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium?.color,
                      ),
                  ),
                    ),),

                ],
              ),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNavigationBar(index);
            },
          ),
        );
      },
    );
  }
}
