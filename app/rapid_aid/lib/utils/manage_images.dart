import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ManageImages {
  List<File>? image;
  var imageTemp = [];

  Future browseImage() async {
    try {
      final image = await ImagePicker().pickMultiImage(imageQuality: 35);
      if (image == null) return;
      for (final image in image) {
        imageTemp.add(File(image.path));
      }
      this.image = imageTemp.cast<File>();
      return await _encodeBase64(image);
    } catch (e) {
      debugPrint('Failed to browse image(s): $e');
    }
  }

  // Convert to base64
  Future<List> _encodeBase64(var image) async {
    var encodedImage = [];
    for (final element in image) {
      Uint8List imagebytes = await element.readAsBytes(); // Convert to bytes
      encodedImage.add(base64.encode(
          imagebytes)); // // Convert bytes to base64 string and save to the list
    }
    // Return the base64 list
    return encodedImage;
  }

  // Decode base64 image
  Uint8List decodeBase64(var image) {
    Uint8List decodedImage = base64.decode(image);
    return decodedImage;
  }
}
