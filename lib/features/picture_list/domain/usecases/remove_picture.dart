import 'package:nasa_astro_picture_of_day/core/usecase/usecase.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/repository/picture_repository.dart';

class RemovePictureUseCase implements UseCase<void, PictureEntity> {
  final PictureRepository _pictureRepository;
  RemovePictureUseCase(this._pictureRepository);

  @override
  Future<void> call({PictureEntity? params}) {
    return _pictureRepository.removePicture(params!);
  }
}
