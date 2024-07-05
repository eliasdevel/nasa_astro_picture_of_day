import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_astro_picture_of_day/core/rescources/data_state.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/entities/search_params.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/usecases/get_pictures.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/domain/usecases/search_pictures.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_event.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_state.dart';

class PicturesBloc extends Bloc<PicturesEvent, PictureState> {
  final GetPicturesUsecase _getPicturesUsecase;
  final SearchPicturesUsecase _searchPicturesUsecase;
  PicturesBloc(this._getPicturesUsecase, this._searchPicturesUsecase)
      : super(const PicturesLoading()) {
    on<GetPictures>(
      (event, emit) async {
        await _loadAllData(event, emit);
      },
    );
    //When search changes
    on<ChangeSearch>((event, emit) async {
      emit(const PicturesLoading());

      if (event.search.isEmpty) {
        await _loadAllData(event, emit);
        return;
      }

      int? number = int.tryParse(event.search.substring(0, 1));
      //Date Search
      if (number != null) {
        final response = await _searchPicturesUsecase(
            params: SearchParamsEntity(
                date: DateTime.parse("${event.search} 00:00:00"), name: null));

        emit(PicturesSearchedByDate(response.data!, event.search));
      } else {
        //Name Search
        final response = await _searchPicturesUsecase(
            params: SearchParamsEntity(date: null, name: "%${event.search}%"));
        emit(PicturesSearchedByName(response.data!));
      }
    });
  }

  Future<void> _loadAllData(
      PicturesEvent event, Emitter<PictureState> emit) async {
    final dataState = await _getPicturesUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(PicturesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(PicturesError(dataState.error!));
    }
  }
}
