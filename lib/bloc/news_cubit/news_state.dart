part of 'news_cubit.dart';

 class NewsState extends Equatable {
final RequestState? getNewsState, changeDataState, uploadImageState;
  final String? image;

  final NewsResponse? news;
  const NewsState(
      {this.changeDataState,
      this.getNewsState,
      this.news,
      this.uploadImageState,
      this.image});

  NewsState copyWith(
          {final RequestState? getNewsState,
          final RequestState? changeDataState,
          final RequestState? uploadImageState,
          final String? image,
          final NewsResponse? news}) =>
      NewsState(
        getNewsState: getNewsState ?? this.getNewsState,
        news: news ?? this.news,

          uploadImageState: uploadImageState ?? this.uploadImageState,
        image: image ?? this.image,
        changeDataState: changeDataState ?? this.changeDataState,
      );

  @override
  List<Object?> get props => [getNewsState, news, changeDataState,image,uploadImageState];
}