import 'package:nasa_astro_picture_of_day/core/constants/constants.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/data/models/picture.dart';
// ignore: depend_on_referenced_packages
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'picture_nasa_api_service.g.dart';

@RestApi(baseUrl: baseUrlNasaApi)
abstract class PictureNasaApiService {
  factory PictureNasaApiService(Dio dio) = _PictureNasaApiService;
  @GET('/apod')
  Future<List<PictureModel>> getPictures({
    @Query('api_key') String? apiKey,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
  });

  @GET('/apod')
  Future<PictureModel> getPictureByDay({
    @Query('api_key') String? apiKey,
    @Query('date') String? date,
  });
}
