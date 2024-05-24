part of 'home_cubit.dart';

class HomeState extends Equatable {
  final RequestState getHomeDataState;
  final HomeResponse? homeResponse;

  const HomeState({this.getHomeDataState=RequestState.loading, this.homeResponse});

  HomeState copyWith(
          {  final RequestState? getHomeDataState,
  final HomeResponse? homeResponse,}) =>
      HomeState(
        getHomeDataState: getHomeDataState ?? this.getHomeDataState,
           homeResponse: homeResponse ?? this.homeResponse,
      );


  @override
  List<Object?> get props => [
    getHomeDataState,
    homeResponse
  ];
}
