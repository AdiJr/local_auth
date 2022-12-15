part of 'image_picker_cubit.dart';

@immutable
abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class ImagePicked extends ImagePickerState {
  ImagePicked(this.path);

  final String path;
}

class ImagePickingFailure extends ImagePickerState {}

