import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';

abstract class PictureState extends Equatable {
  final List<PictureEntity>? pictures;
  final DioException? error;
  final String? date;
  const PictureState({this.error, this.pictures, this.date});

  @override
  List<Object?> get props => [pictures!, error];
}

class PicturesLoading extends PictureState {
  const PicturesLoading();
}

class PicturesDone extends PictureState {
  const PicturesDone(List<PictureEntity> pictures) : super(pictures: pictures);
}

class PicturesError extends PictureState {
  const PicturesError(DioException error) : super(error: error);
}

class PicturesSearchingByName extends PictureState {
  const PicturesSearchingByName(List<PictureEntity> pictures)
      : super(pictures: pictures);
}

class PicturesSearchingByDate extends PictureState {
  const PicturesSearchingByDate(List<PictureEntity> pictures, String date)
      : super(pictures: pictures, date: date);
}
