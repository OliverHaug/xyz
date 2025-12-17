import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PostEditorState extends Equatable {
  final String text;
  final TextEditingController controller;
  final XFile? imageFile;
  final String? existingImageUrl;
  final String? existingImagePath;
  final bool removeImage;
  final bool isSubmitting;
  final bool isEdit;

  const PostEditorState({
    this.text = '',
    required this.controller,
    this.imageFile,
    this.existingImageUrl,
    this.existingImagePath,
    this.removeImage = false,
    this.isSubmitting = false,
    this.isEdit = false,
  });

  PostEditorState copyWith({
    String? text,
    TextEditingController? controller,
    XFile? imageFile,
    String? existingImageUrl,
    String? existingImagePath,
    bool? removeImage,
    bool? isSubmitting,
    bool? isEdit,
  }) {
    return PostEditorState(
      text: text ?? this.text,
      controller: controller ?? this.controller,
      imageFile: imageFile ?? this.imageFile,
      existingImageUrl: existingImageUrl ?? this.existingImageUrl,
      existingImagePath: existingImagePath ?? this.existingImagePath,
      removeImage: removeImage ?? this.removeImage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isEdit: isEdit ?? this.isEdit,
    );
  }

  @override
  List<Object?> get props => [
    text,
    imageFile,
    existingImageUrl,
    existingImagePath,
    removeImage,
    isSubmitting,
    isEdit,
  ];
}
