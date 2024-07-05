import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nasa_astro_picture_of_day/core/constants/constants.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_bloc.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_event.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/bloc/picture/picture_state.dart';
import 'package:nasa_astro_picture_of_day/features/picture_list/presentation/widgets/picture_item.dart';

class PictureListPage extends StatefulWidget {
  const PictureListPage({super.key});

  @override
  State<PictureListPage> createState() => _PictureListPageState();
}

class _PictureListPageState extends State<PictureListPage>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nasa Beautifull pictures'),
      ),
      body:
          BlocConsumer<PicturesBloc, PictureState>(listener: (context, state) {
        if (state is PicturesSearchedByDate) {
          searchController.text = state.date!;
        }
      }, builder: (_, state) {
        if (state is PicturesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is! PicturesLoading && state is! PicturesError) {
          return Stack(
            children: [
              if (state.pictures != null)
                ListView.builder(
                  padding: const EdgeInsets.only(top: 70),
                  cacheExtent: 9999,
                  itemBuilder: (context, index) {
                    return PictureItem(picture: state.pictures![index]);
                  },
                  itemCount: state.pictures!.length,
                ),
              SearchAnchor(
                builder: (context, controller) => SearchBar(
                  controller: searchController,
                  leading: const Icon(Icons.search),
                  onChanged: (value) =>
                      BlocProvider.of<PicturesBloc>(context).add(
                    ChangeSearch(value),
                  ),
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () => showDatePicker(
                              context: context,
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 600),
                              ),
                              lastDate: DateTime.now())
                          .then(
                        (value) => BlocProvider.of<PicturesBloc>(context).add(
                          ChangeSearch(
                            DateFormat(dateFormat)
                                .format(value ?? DateTime.now()),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                suggestionsBuilder: (context, controller) => List.empty(),
              ),
            ],
          );
        }
        if (state is PicturesError) {
          // print(state.error!.response!);
          return const Center(child: Icon(Icons.refresh));
        }

        return const SizedBox();
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
