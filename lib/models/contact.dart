import 'dart:typed_data';

class Contact {
  final String name;
  final String email;
  final String phone;

  /// Picked image bytes (null if the user didn't pick an image).
  final Uint8List? image;

  const Contact({
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });
}
