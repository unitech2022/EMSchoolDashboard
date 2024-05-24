part of 'users_cubit.dart';

class UsersState extends Equatable {
  final RequestState? getUsersState;
  final UsersResponse? studentsResponse;
   final UsersResponse? teachersResponse;
     final UsersResponse? parentsResponse;
  final RequestState? getResponseForLoginState;
  final RequestState? registerState;
  final RequestState? updateUsereState;

  
  const UsersState({this.updateUsereState,this.registerState,this.getUsersState, this.parentsResponse, this.studentsResponse,this.teachersResponse,this.getResponseForLoginState});

  UsersState copyWith({
    final RequestState? getUsersState,
  final UsersResponse? studentsResponse,
   final UsersResponse? teachersResponse,
  final RequestState? getResponseForLoginState,
  final RequestState? registerState,
  final RequestState? updateUsereState,
   final UsersResponse? parentsResponse
  }) =>
      UsersState(
        getUsersState: getUsersState ?? this.getUsersState,
          studentsResponse: studentsResponse ?? this.studentsResponse,
           teachersResponse: teachersResponse ?? this.teachersResponse,
          getResponseForLoginState: getResponseForLoginState ?? this.getResponseForLoginState,

           registerState: registerState ?? this.registerState,
          updateUsereState: updateUsereState ?? this.updateUsereState,
          parentsResponse: parentsResponse ?? this.parentsResponse,
      );



  @override
  List<Object?> get props => [parentsResponse,updateUsereState,getUsersState, studentsResponse,getResponseForLoginState,registerState,teachersResponse];
}
