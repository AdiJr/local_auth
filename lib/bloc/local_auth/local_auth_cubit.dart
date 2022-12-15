import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

part 'local_auth_state.dart';

class LocalAuthCubit extends Cubit<LocalAuthState> {
  LocalAuthCubit() : super(LocalAuthInitial());

  final _auth = LocalAuthentication();

  void reset() {
    emit(LocalAuthInitial());
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      if (await _canUseBiometrics()) {
        final didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please authenticate to show password',
        );
        if (didAuthenticate) {
          emit(LocalAuthSuccess());
        } else {
          emit(LocalAuthFailure());
        }
      } else {
        throw Exception('Cannot use any biometrics on the device');
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        log('Error while authenticating', error: e);
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        log('Too many attempts while authenticating', error: e);
      } else {
        log('Error while authenticating - platform exception', error: e);
      }
      emit(LocalAuthFailure());
    } catch (e) {
      log('Error while authenticating', error: e);
      emit(LocalAuthFailure());
    }
  }

  Future<bool> _canUseBiometrics() async {
    final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }
}
