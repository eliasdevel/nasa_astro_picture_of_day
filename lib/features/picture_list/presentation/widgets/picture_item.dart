import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:flutter/material.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/widgets/video_player.dart';

class PictureItem extends StatelessWidget {
  final PictureEntity picture;
  const PictureItem({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    String url = picture.hdurl.isNotEmpty ? picture.hdurl : picture.url;

    bool isImage = url.split('.').last.length < 5;
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed('/details', arguments: picture),
      child: Card(
        child: Column(
          children: [
            Text(picture.title),
            isImage
                ? DisposableCachedImage.network(imageUrl: url)
                : VideoPlayerWidget(url: url),
            Text(picture.date)
          ],
        ),
      ),
    );
  }
}
