import 'package:nasa_astro_picture_of_day/core/rescources/data_state.dart';
import 'package:nasa_astro_picture_of_day/core/usecase/usecase.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/repository/picture_repository.dart';

class GetSavedPicturesUseCase
    implements UseCase<DataState<List<PictureEntity>>, void> {
  final PictureRepository _pictureRepository;
  GetSavedPicturesUseCase(this._pictureRepository);

  @override
  Future<DataState<List<PictureEntity>>> call({void params}) {
    return _pictureRepository.getPictures();
  }
}
