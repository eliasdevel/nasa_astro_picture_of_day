import 'package:nasa_astro_picture_of_day/core/rescources/data_state.dart';
import 'package:nasa_astro_picture_of_day/core/usecase/usecase.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/search_params.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/repository/picture_repository.dart';

class SearchPicturesUsecase
    implements UseCase<DataState<List<PictureEntity>>, SearchParamsEntity> {
  final PictureRepository _pictureRepository;

  SearchPicturesUsecase(this._pictureRepository);
  @override
  Future<DataState<List<PictureEntity>>> call({SearchParamsEntity? params}) {
    print("Elias ${params?.date} ${params?.name}");
    return _pictureRepository.getPictures(search: params);
  }
}
