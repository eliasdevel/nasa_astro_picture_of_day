import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_astro_picture_of_day/config/theme/app_themes.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_bloc.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_event.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/pages/picture_details.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/pages/picture_list.dart';
import 'package:nasa_astro_picture_of_day/injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PicturesBloc>(
      create: (context) => sl()..add(const GetPictures()),
      child: MaterialApp(
        theme: theme(),
        routes: {
          '/': (context) => const PictureListPage(),
          '/details': (context) => PictureDetails()
        },
      ),
    );
  }
}
