part of 'local_auth_cubit.dart';

@immutable
abstract class LocalAuthState {}

class LocalAuthInitial extends LocalAuthState {}

class LocalAuthSuccess extends LocalAuthState {}

class LocalAuthFailure extends LocalAuthState {}
