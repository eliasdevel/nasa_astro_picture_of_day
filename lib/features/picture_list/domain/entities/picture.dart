import 'package:equatable/equatable.dart';

class PictureEntity extends Equatable {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  const PictureEntity({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  @override
  List<Object?> get props => [
        copyright,
        date,
        explanation,
        hdurl,
        mediaType,
        serviceVersion,
        title,
        url,
      ];
}
