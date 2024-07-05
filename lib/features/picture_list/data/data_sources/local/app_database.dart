import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/data_sources/local/DAO/picture_dao.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/models/picture.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [PictureModel])
abstract class AppDatabase extends FloorDatabase {
  PictureDao get pictureDAO;
}
