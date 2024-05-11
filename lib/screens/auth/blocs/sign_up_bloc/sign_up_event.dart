part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;

  SignUpRequired(this.user, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [user, password];
}
