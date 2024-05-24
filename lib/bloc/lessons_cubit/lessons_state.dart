part of 'lessons_cubit.dart';

 class LessonsState extends Equatable {
 final RequestState? getLessonsState, changeDataState, uploadImageState;
  final String? image;

  final List<LessonsAdminResponse> lessons;
  const LessonsState(
      {this.changeDataState,
      this.getLessonsState,
      this.lessons=const[],
      this.uploadImageState,
      this.image});

  LessonsState copyWith(
          {final RequestState? getLessonsState,
          final RequestState? changeDataState,
          final RequestState? uploadImageState,
          final String? image,
          final List<LessonsAdminResponse>? lessons}) =>
      LessonsState(
        getLessonsState: getLessonsState ?? this.getLessonsState,
        lessons: lessons ?? this.lessons,

          uploadImageState: uploadImageState ?? this.uploadImageState,
        image: image ?? this.image,
        changeDataState: changeDataState ?? this.changeDataState,
      );

  @override
  List<Object?> get props => [getLessonsState, lessons, changeDataState,image,uploadImageState];
}


