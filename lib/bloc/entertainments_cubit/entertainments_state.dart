part of 'entertainments_cubit.dart';

 class EntertainmentsState extends Equatable {
final RequestState? getEntertainmentsState, changeDataState, uploadImageState;
  final String? image;

  final EnntertainmentssResponse? entertainments;
  const EntertainmentsState(
      {this.changeDataState,
      this.getEntertainmentsState,
      this.entertainments,
      this.uploadImageState,
      this.image});

  EntertainmentsState copyWith(
          {final RequestState? getEntertainmentsState,
          final RequestState? changeDataState,
          final RequestState? uploadImageState,
          final String? image,
          final EnntertainmentssResponse? entertainments}) =>
      EntertainmentsState(
        getEntertainmentsState: getEntertainmentsState ?? this.getEntertainmentsState,
        entertainments: entertainments ?? this.entertainments,

          uploadImageState: uploadImageState ?? this.uploadImageState,
        image: image ?? this.image,
        changeDataState: changeDataState ?? this.changeDataState,
      );

  @override
  List<Object?> get props => [getEntertainmentsState, entertainments, changeDataState,image,uploadImageState];


}
