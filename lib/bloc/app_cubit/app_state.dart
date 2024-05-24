part of 'app_cubit.dart';

class AppState extends Equatable {
  final int indexSideMenu;
  final String page;
  const AppState({this.indexSideMenu = 0, this.page = ""});

  AppState copyWith({
    final String? page,
    final int? indexSideMenu,
  }) =>
      AppState(
        indexSideMenu: indexSideMenu ?? this.indexSideMenu,
          page: page ?? this.page,
      );

  @override
  List<Object> get props => [indexSideMenu,page];
}
