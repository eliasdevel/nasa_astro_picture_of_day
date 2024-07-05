import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:flutter/material.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/widgets/video_player.dart';

class PictureDetails extends StatelessWidget {
  const PictureDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final picture = ModalRoute.of(context)!.settings.arguments as PictureEntity;
    String url = picture.hdurl.isNotEmpty ? picture.hdurl : picture.url;

    bool isImage = url.split('.').last.length < 5;

    return Scaffold(
      appBar: AppBar(
        title: Text(picture.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isImage
                ? DisposableCachedImage.network(imageUrl: url)
                : VideoPlayerWidget(url: url),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(picture.explanation),
            ),
            Text(picture.date),
            picture.copyright.isNotEmpty
                ? Text('Copyright: ${picture.copyright}')
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
