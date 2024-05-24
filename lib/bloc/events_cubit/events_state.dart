part of 'events_cubit.dart';

class EventsState extends Equatable {
  final RequestState? getEventsState, uploadImageState, changeDataState;
  final EventsResponse? eventsResponse;
  final String? image;
  const EventsState(
      {this.uploadImageState,
      this.image,
      this. changeDataState,
      this.getEventsState,
      this.eventsResponse});

  EventsState copyWith({
    final RequestState? getEventsState,
     final RequestState? changeDataState,
    final EventsResponse? eventsResponse,
    final RequestState? uploadImageState,
    final String? image,
  }) =>
      EventsState(
        eventsResponse: eventsResponse ?? this.eventsResponse,
       getEventsState: getEventsState ?? this.getEventsState,
        uploadImageState: uploadImageState ?? this.uploadImageState,
        image: image ?? this.image,
        changeDataState: changeDataState ?? this.changeDataState,
      );

  @override
  List<Object?> get props => [
    getEventsState,eventsResponse,image,changeDataState,uploadImageState
  ];
}
