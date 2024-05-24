part of 'schedules_cubit.dart';

class SchedulesState extends Equatable {
  final RequestState? getSchedulesState, addSchedulesState,chnageDataSelectState;
  final List<ScheduleResponse>? schedulesResponse;

  const SchedulesState(
      {this.getSchedulesState, this.addSchedulesState, this.schedulesResponse, this.chnageDataSelectState});

  SchedulesState copyWith(
          {final RequestState? getSchedulesState,
          final RequestState? addSchedulesState,
           final RequestState? chnageDataSelectState,
          final List<ScheduleResponse>? schedulesResponse}) =>
      SchedulesState(
        getSchedulesState: getSchedulesState ?? this.getSchedulesState,
        addSchedulesState: addSchedulesState ?? this.addSchedulesState,
        schedulesResponse: schedulesResponse ?? this.schedulesResponse,
          chnageDataSelectState: chnageDataSelectState ?? this.chnageDataSelectState,
      );

  @override
  List<Object?> get props => [getSchedulesState, addSchedulesState, schedulesResponse,chnageDataSelectState];
}
