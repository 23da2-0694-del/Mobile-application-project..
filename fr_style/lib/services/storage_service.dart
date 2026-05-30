import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(String uid, Uint8List fileBytes) async {
    try {
      final ref = _storage.ref().child('profile_images').child('$uid.jpg');
      
      // Upload using putData with a 5 second timeout to prevent hanging
      final uploadTaskSnapshot = await ref.putData(
        fileBytes,
        SettableMetadata(contentType: 'image/jpeg'),
      ).timeout(const Duration(seconds: 5));
      
      final downloadUrl = await uploadTaskSnapshot.ref.getDownloadURL().timeout(const Duration(seconds: 3));
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
