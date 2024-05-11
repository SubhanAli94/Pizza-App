part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();
}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  SignInRequired(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class SignOutRequired extends SignInEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
