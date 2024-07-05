import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:flutter/material.dart';
import 'package:nasa_astro_picture_of_day/injection_container.dart';
import 'package:nasa_astro_picture_of_day/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DisposableImages.init();

  await initializeDependencies();

  runApp(const DisposableImages(App()));
}
