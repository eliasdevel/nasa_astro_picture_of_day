import 'package:floor/floor.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/models/picture.dart';

@dao
abstract class PictureDao {
  @Insert()
  Future<void> insertPicture(PictureModel picture);

  @delete
  Future<void> deletePicture(PictureModel picture);

  @Query('SELECT * FROM picture')
  Future<List<PictureModel>> getPictures();

  @Query('SELECT * FROM picture where title LIKE :title')
  Future<List<PictureModel>> getPicturesByName(String title);

  @Query('SELECT * FROM picture where date = :date')
  Future<List<PictureModel>> getPicturesByDate(String date);
}
