import 'package:nasa_astro_picture_of_day/core/rescources/data_state.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/search_params.dart';

abstract class PictureRepository {
  //Api
  Future<DataState<List<PictureEntity>>> getPictures(
      {SearchParamsEntity? search});

  //Database
  Future<List<PictureEntity>> getSavedPictures();

  Future<DataState<PictureEntity>> getPictureByDate(String date);

  Future<void> savePicture(PictureEntity picture);

  Future<void> removePicture(PictureEntity picture);
}
