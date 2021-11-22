import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class SuggestionRealEstateList extends StatelessWidget {
  final String query;

  SuggestionRealEstateList({
    Key key,
    this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBloc.searchBloc.add(OnSearch(query));
    return SafeArea(
      top: false,
      bottom: false,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is Success && state.list is List<ProductRealEstateModel>) {
            if (state.list.length == 0) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.sentiment_satisfied),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        Translate.of(context).translate('category_not_found'),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final item = state.list[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: AppProductRealEstateItem(
                    onPressed: (item) {
                      Navigator.pushNamed(
                        context,
                        Routes.productDetail,
                        arguments: item,
                      );
                    },
                    item: item,
                    type: ProductViewType.small,
                  ),
                );
              },
            );
          }

          if (state is Searching) {
            return Center(
              child: SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
