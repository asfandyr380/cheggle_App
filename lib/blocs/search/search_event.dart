abstract class SearchEvent {}

class OnSearch extends SearchEvent {
  final String keyword;
  OnSearch(this.keyword);
}
