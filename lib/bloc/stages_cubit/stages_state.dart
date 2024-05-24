part of 'stages_cubit.dart';

class StagesState extends Equatable {
  final RequestState? getStagessStage,addStageState;
  final StagesResponse? stages;
  const StagesState({this.addStageState,this.getStagessStage, this.stages });



  StagesState copyWith({
 final RequestState? getStagessStage,
  final RequestState? addStageState,
  final StagesResponse? stages
  }) =>
      StagesState(
        getStagessStage: getStagessStage ?? this.getStagessStage,
          stages: stages ?? this.stages,
           addStageState: addStageState ?? this.addStageState,
         
      );


  @override
  List<Object?> get props => [getStagessStage, stages,addStageState];
}
