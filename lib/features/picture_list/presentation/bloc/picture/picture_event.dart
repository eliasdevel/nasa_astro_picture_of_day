abstract class PicturesEvent {
  const PicturesEvent();
}

class GetPictures extends PicturesEvent {
  const GetPictures();
}

class ChangeSearch extends PicturesEvent {
  final String search;
  const ChangeSearch(this.search);
}
