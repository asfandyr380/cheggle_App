import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchEmpty());

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events,
      TransitionFunction<SearchEvent, SearchState> transition) {
    final nonDebounceStream = events.where((event) => event is! OnSearch);
    final debounceStream = events
        .where((event) => event is OnSearch)
        .debounceTime(Duration(milliseconds: 1500));

    return super.transformEvents(
      MergeStream([nonDebounceStream, debounceStream]),
      transition,
    );
  }

  @override
  Stream<SearchState> mapEventToState(event) async* {
    if (event is OnSearch) {
      if (event.keyword.isEmpty) {
        yield SearchEmpty();
      } else {
        yield Searching();
        final ResultApiModel result = await Api.onSearchData();
        if (result.success) {
          switch (AppBloc.businessCubit.state) {
            case BusinessState.realEstate:
              yield Success((result.data as List ?? []).map((item) {
                return ProductRealEstateModel.fromJson(item);
              }).toList());
              break;
            case BusinessState.event:
              yield Success((result.data as List ?? []).map((item) {
                return ProductEventModel.fromJson(item);
              }).toList());
              break;
            case BusinessState.food:
              yield Success((result.data as List ?? []).map((item) {
                return ProductFoodModel.fromJson(item);
              }).toList());
              break;
            default:
              yield Success((result.data as List ?? []).map((item) {
                return ProductModel.fromJson(item);
              }).toList());
          }
        }
      }
    }
  }
}
