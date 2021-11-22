abstract class SearchState {}

class SearchEmpty extends SearchState {}

class Searching extends SearchState {}

class Success extends SearchState {
  final List<dynamic> list;
  Success(this.list);
}
