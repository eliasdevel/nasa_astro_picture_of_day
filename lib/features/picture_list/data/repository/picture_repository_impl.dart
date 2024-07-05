import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nasa_astro_picture_of_day/core/constants/constants.dart';
import 'package:nasa_astro_picture_of_day/core/rescources/data_state.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/data_sources/local/app_database.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/data_sources/remote/picture_nasa_api_service.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/models/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/search_params.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/repository/picture_repository.dart';
import 'package:intl/intl.dart';

class PictureRepositoryImpl implements PictureRepository {
  final PictureNasaApiService _pictureNasaApiService;
  final AppDatabase _appDatabase;
  PictureRepositoryImpl(this._pictureNasaApiService, this._appDatabase);
  @override
  Future<DataState<List<PictureEntity>>> getPictures(
      {SearchParamsEntity? search}) async {
    try {
      //Get By Date
      if (search?.date != null) {
        List<PictureEntity> picsByDate = [];
        final result = await getPictureByDate(
            DateFormat(dateFormat).format(search!.date!));

        picsByDate.add(result.data!);

        return DataSuccess(picsByDate);
      }

      String today = DateFormat(dateFormat).format(DateTime.now());
      String sevenDaysBefore = DateFormat(dateFormat)
          .format(DateTime.now().subtract(const Duration(days: 7)));

      List<PictureEntity> databasePictures =
          await _appDatabase.pictureDAO.getPictures();

      //Verify if the picture from today is in database
      if (databasePictures.where((e) => e.date == today).isNotEmpty &&
          search?.date == null) {
        debugPrint('Local Files!');
        //Name Search
        if (search?.name != null) {
          List<PictureEntity> databasePictureSearch =
              await _appDatabase.pictureDAO.getPicturesByName(search!.name!);
          return DataSuccess(databasePictureSearch);
        }

        return DataSuccess(databasePictures);
      }

      final response = await _pictureNasaApiService.getPictures(
        apiKey: apiKey,
        endDate: today,
        startDate: sevenDaysBefore,
      );

      //Save localy
      for (final pic in response) {
        removePicture(pic).then((a) => savePicture(pic));
      }

      return DataSuccess(response);
      // verify exception
    } on DioException catch (e) {
      return DataFailed(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PictureEntity>> getSavedPictures() {
    return _appDatabase.pictureDAO.getPictures();
  }

  @override
  Future<void> removePicture(PictureEntity picture) {
    return _appDatabase.pictureDAO
        .deletePicture(PictureModel.fromEntity(picture));
  }

  @override
  Future<void> savePicture(PictureEntity picture) {
    return _appDatabase.pictureDAO
        .insertPicture(PictureModel.fromEntity(picture));
  }

  @override
  Future<DataState<PictureEntity>> getPictureByDate(String date) async {
    try {
      //verify if is local
      final dbPictures = await _appDatabase.pictureDAO.getPicturesByDate(date);
      if (dbPictures.isNotEmpty) {
        return DataSuccess(dbPictures.first);
      }

      //Geting remote
      final data = await _pictureNasaApiService.getPictureByDay(
        date: date,
        apiKey: apiKey,
      );

      removePicture(data).then((a) => savePicture(data));

      return DataSuccess(data);
    } on DioException catch (e) {
      return DataFailed(e);
    } catch (e) {
      rethrow;
    }
  }
}
