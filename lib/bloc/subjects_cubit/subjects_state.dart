part of 'subjects_cubit.dart';

class SubjectsState extends Equatable {
  final RequestState? getSubjectsState, addSubjectState, uploadImageState;
  final String? image;

  final SubjectsResponse? subjects;
  const SubjectsState(
      {this.addSubjectState,
      this.getSubjectsState,
      this.subjects,
      this.uploadImageState,
      this.image});

  SubjectsState copyWith(
          {final RequestState? getSubjectsState,
          final RequestState? addSubjectState,
          final RequestState? uploadImageState,
          final String? image,
          final SubjectsResponse? subjects}) =>
      SubjectsState(
        getSubjectsState: getSubjectsState ?? this.getSubjectsState,
        subjects: subjects ?? this.subjects,

          uploadImageState: uploadImageState ?? this.uploadImageState,
        image: image ?? this.image,
        addSubjectState: addSubjectState ?? this.addSubjectState,
      );

  @override
  List<Object?> get props => [getSubjectsState, subjects, addSubjectState,image,uploadImageState];
}
