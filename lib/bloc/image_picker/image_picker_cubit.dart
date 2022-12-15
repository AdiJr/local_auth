import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(ImagePicked(image.path));
      } else {
        throw Exception('Image cannot be null');
      }
    } catch (e) {
      emit(ImagePickingFailure());
    }
  }

  Future<void> pickMultiImagesFromGallery() async {
    try {
      final images = await _picker.pickMultiImage();
    } catch (e) {}
  }

  Future<void> pickVideoFromGallery() async {
    try {
      final image = await _picker.pickVideo(source: ImageSource.gallery);
    } catch (e) {}
  }
}
