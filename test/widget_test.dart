// ignore: depend_on_referenced_packages
import 'package:nasa_astro_picture_of_day/features/picture_list/data/models/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/picture.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_event.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_bloc.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_state.dart';
import 'package:nasa_astro_picture_of_day/injection_container.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'mock_path.dart';

void main() {
  group('PicturesBloc', () {
    late PicturesBloc picturesBloc;

    setUpAll(() async {
      PathProviderPlatform.instance = FakePathProviderPlatform();
      await initializeDependencies();
      picturesBloc = PicturesBloc(sl(), sl());
    });

    test('initial state is Loading', () {
      expect(picturesBloc.state, equals(const PicturesLoading()));
    });

    blocTest(
      'Get Pictures',
      build: () => picturesBloc,
      act: (bloc) => bloc.add(const GetPictures()),
    );

    blocTest(
      'Change Search',
      build: () => PicturesBloc(sl(), sl()),
      act: (bloc) => bloc.add(const ChangeSearch('Picture')),
      expect: () => [const PicturesLoading()],
    );

    blocTest('Change Search Date',
        build: () => PicturesBloc(sl(), sl()),
        act: (bloc) => bloc.add(const ChangeSearch('2024-07-05')),
        wait: const Duration(seconds: 2),
        expect: () => [
              const PicturesLoading(),
              const PicturesSearchedByDate([
                PictureModel(
                    copyright: 'Gianni Tumino',
                    date: '2024-07-05',
                    explanation:
                        "A glow from the summit of Mount Etna, famous active stratovolcano of planet Earth, stands out along the horizon in this mountain and night skyscape. Bands of diffuse light from congeries of innumerable stars along the Milky Way galaxy stretch across the sky above. In silhouette, the Milky Way's massive dust clouds are clumped along the galactic plane. But also familiar to northern skygazers are bright stars Deneb, Vega, and Altair, the Summer Triangle straddling dark nebulae and luminous star clouds poised over the volcanic peak. The deep combined exposures also reveal the light of active star forming regions along the Milky Way, echoing Etna's ruddy hue in the northern hemisphere summer's night.",
                    hdurl:
                        'https://apod.nasa.gov/apod/image/2407/GianniTumino_Etna&MW_14mm_JPG_LOGO__2048pix.jpg',
                    mediaType: 'image',
                    serviceVersion: 'v1',
                    title: 'Mount Etna Milky Way',
                    url:
                        'https://apod.nasa.gov/apod/image/2407/GianniTumino_Etna&MW_14mm_JPG_LOGO__1024pix.jpg')
              ], '2024-07-05')
            ]);
  });
}
