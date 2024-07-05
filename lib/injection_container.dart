import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/data_sources/local/app_database.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/data_sources/remote/picture_nasa_api_service.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/repository/picture_repository_impl.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/repository/picture_repository.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/usecases/get_pictures.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/usecases/get_saved_pictures.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/usecases/remove_picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/usecases/save_picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/usecases/search_pictures.dart';

import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_pictures.db').build();
  //Database
  sl.registerSingleton(database);
  //Dio
  sl.registerSingleton<Dio>(Dio());
  //Api
  sl.registerSingleton<PictureNasaApiService>(PictureNasaApiService(sl()));
  //Repository
  sl.registerSingleton<PictureRepository>(PictureRepositoryImpl(sl(), sl()));
  //Usecases
  sl.registerSingleton<GetPicturesUsecase>(GetPicturesUsecase(sl()));

  sl.registerSingleton<GetSavedPicturesUseCase>(GetSavedPicturesUseCase(sl()));

  sl.registerSingleton<SavePictureUseCase>(SavePictureUseCase(sl()));

  sl.registerSingleton<RemovePictureUseCase>(RemovePictureUseCase(sl()));

  sl.registerSingleton<SearchPicturesUsecase>(SearchPicturesUsecase(sl()));

  //Blocs
  sl.registerFactory<PicturesBloc>(() => PicturesBloc(sl(), sl()));
}
