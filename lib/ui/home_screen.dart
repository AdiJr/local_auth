import 'package:flutter/material.dart';
import 'package:libs_samples_app/ui/image_picker_screen.dart';
import 'package:libs_samples_app/ui/local_auth_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<LocalAuthScreen>(
                  builder: (context) => const LocalAuthScreen(),
                ),
              ),
              child: const Text('Local Authentication'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<ImagePickerScreen>(
                  builder: (context) => const ImagePickerScreen(),
                ),
              ),
              child: const Text('Image Picker'),
            ),
          ],
        ),
      ),
    );
  }
}
