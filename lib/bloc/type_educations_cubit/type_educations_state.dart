part of 'type_educations_cubit.dart';

class TypeEducationsState extends Equatable {
  final RequestState? getTypeEducationsStage,addTypeEducationState;
  final TypeEducationsResponse? typeEducations;
  const TypeEducationsState(
      {this.getTypeEducationsStage,this.addTypeEducationState, this.typeEducations});



  TypeEducationsState copyWith({
 final RequestState? getTypeEducationsStage,
  final RequestState? addTypeEducationState,
  final TypeEducationsResponse? typeEducations
  }) =>
      TypeEducationsState(
        getTypeEducationsStage: getTypeEducationsStage ?? this.getTypeEducationsStage,
          addTypeEducationState: addTypeEducationState ?? this.addTypeEducationState,
           typeEducations: typeEducations ?? this.typeEducations,
         
      );


  @override
  List<Object?> get props => [getTypeEducationsStage, typeEducations,addTypeEducationState];
}
