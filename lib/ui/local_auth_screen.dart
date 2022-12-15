import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libs_samples_app/bloc/local_auth/local_auth_cubit.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  late final LocalAuthCubit localAuthCubit;
  String password = 'I love Flutter <3!';
  String hiddenPassword = '***********';

  @override
  void initState() {
    super.initState();
    localAuthCubit = LocalAuthCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LocalAuthCubit, LocalAuthState>(
              bloc: localAuthCubit,
              builder: (context, state) {
                if (state is LocalAuthSuccess) {
                  return const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Click on reset to start over',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Click on show password to authenticate with biometrics in order to reveal the hidden text',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 40),
            BlocBuilder<LocalAuthCubit, LocalAuthState>(
              bloc: localAuthCubit,
              builder: (context, state) {
                if (state is LocalAuthSuccess) {
                  return Text(
                    password,
                    style: const TextStyle(fontSize: 22),
                  );
                } else {
                  return Text(
                    hiddenPassword,
                    style: const TextStyle(fontSize: 22),
                  );
                }
              },
            ),
            const SizedBox(height: 40),
            BlocBuilder<LocalAuthCubit, LocalAuthState>(
              bloc: localAuthCubit,
              builder: (context, state) {
                if (state is LocalAuthSuccess) {
                  return OutlinedButton(
                    onPressed: localAuthCubit.reset,
                    child: const Text('Reset'),
                  );
                }
                return OutlinedButton(
                  onPressed: localAuthCubit.authenticateWithBiometrics,
                  child: const Text('Show password'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    localAuthCubit.close();
    super.dispose();
  }
}
