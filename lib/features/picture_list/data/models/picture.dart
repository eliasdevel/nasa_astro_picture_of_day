import 'package:floor/floor.dart';
import 'package:nasa_astro_picture_of_day/core/rescources/model_exception.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';

@Entity(tableName: 'picture', primaryKeys: ['url'])
class PictureModel extends PictureEntity {
  const PictureModel(
      {required super.copyright,
      required super.date,
      required super.explanation,
      required super.hdurl,
      required super.mediaType,
      required super.serviceVersion,
      required super.title,
      required super.url});

  factory PictureModel.fromEntity(PictureEntity entity) {
    return PictureModel(
      copyright: entity.copyright,
      date: entity.date,
      explanation: entity.explanation,
      hdurl: entity.hdurl,
      mediaType: entity.mediaType,
      serviceVersion: entity.serviceVersion,
      title: entity.title,
      url: entity.url,
    );
  }

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'date': String date,
          'explanation': String explanation,
          'media_type': String mediaType,
          'service_version': String serviceVersion,
          'title': String title,
          'url': String url,
        }) {
      return PictureModel(
          copyright:
              json.containsKey('copyright') ? json['copyright'].toString() : '',
          date: date,
          explanation: explanation,
          hdurl: json.containsKey('hdurl') ? json['hdurl'].toString() : '',
          mediaType: mediaType,
          serviceVersion: serviceVersion,
          title: title,
          url: url);
    } else {
      throw ModelExceptionInvalidData();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'copyright': copyright,
      'date': date,
      'explanation': explanation,
      'hdurl': hdurl,
      'mediaType': mediaType,
      'serviceVersion': serviceVersion,
      'title': title,
      'url': url,
    };
  }
}
