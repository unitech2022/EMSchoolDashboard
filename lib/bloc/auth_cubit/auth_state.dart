part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final RequestState? loginSignUpState;

  final UserResponse? userResponse;
  const AuthState({this.loginSignUpState, this.userResponse});

  AuthState copyWith(
          {final RequestState? loginSignUpState,
          final UserResponse? userResponse}) =>
      AuthState(
        loginSignUpState: loginSignUpState ?? this.loginSignUpState,
           userResponse: userResponse ?? this.userResponse,
      );

  @override
  List<Object?> get props => [loginSignUpState,userResponse];
}
