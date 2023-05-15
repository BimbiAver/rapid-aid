import 'package:flutter/material.dart';
import 'package:rapid_aid/utils/manage_images.dart';

Widget caseImageList(String caseImage) {
  // Convert base64 image to Uint8List and return it
  return Column(
    children: [
      Image.memory(ManageImages().decodeBase64(caseImage)),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
