import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libs_samples_app/bloc/image_picker/image_picker_cubit.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  late final ImagePickerCubit imagePickerCubit;

  @override
  void initState() {
    super.initState();
    imagePickerCubit = ImagePickerCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ImagePickerCubit, ImagePickerState>(
              bloc: imagePickerCubit,
              builder: (context, state) {
                if (state is ImagePicked) {
                  return Image.file(
                    File(state.path),
                    height: 300,
                    width: 300,
                  );
                }
                return const SizedBox();
              },
            ),
            OutlinedButton(
              onPressed: imagePickerCubit.pickImageFromGallery,
              child: const Text('Select image from gallery'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    imagePickerCubit.close();
    super.dispose();
  }
}
