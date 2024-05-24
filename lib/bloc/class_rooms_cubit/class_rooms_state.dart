part of 'class_rooms_cubit.dart';

 class ClassRoomsState extends Equatable {
  final RequestState? getClassRoomsState,addClassRoomsState;
  final ClassRoomsResponse? classRooms;
  const ClassRoomsState({this.addClassRoomsState, this.getClassRoomsState, this.classRooms });


 ClassRoomsState copyWith({
 final RequestState? getClassRoomsState,final RequestState? addClassRoomsState,
  final RequestState? addStageState,
  final ClassRoomsResponse? classRooms
  }) =>
      ClassRoomsState(
        getClassRoomsState: getClassRoomsState ?? this.getClassRoomsState,
          classRooms: classRooms ?? this.classRooms,
           addClassRoomsState: addClassRoomsState ?? this.addClassRoomsState,
         
      );

  @override
  List<Object?> get props => [getClassRoomsState, classRooms,addClassRoomsState];
}

