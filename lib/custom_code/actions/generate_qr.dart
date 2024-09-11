// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart'; // Import for Firebase Storage
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:firebase_auth/firebase_auth.dart'; // Import for Firebase Authentication

Future<String> generateQr(
  DocumentReference contactRef,
  DocumentReference eventRef,
) async {
  // Check if the contactRef and eventRef are not null
  if (contactRef == null || eventRef == null) {
    throw Exception(
        'Contact reference and event reference are required to generate QR code.');
  }

  // Ensure the user is authenticated
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance
        .signInAnonymously(); // Sign in anonymously if not already signed in
  }

  // Get the current user ID
  String userId = FirebaseAuth.instance.currentUser!.uid;

  // Generate a unique identifier using UUID
  var uuid = Uuid();
  String uniqueId =
      uuid.v4(); // Example: '550e8400-e29b-41d4-a716-446655440000'

  // Combine contact reference path, event reference path, and unique ID for QR code data
  String qrData = '${contactRef.path}|${eventRef.path}|$uniqueId';

  // Generate QR Code as an Image using QrPainter
  final qrCodePainter = QrPainter(
    data: qrData,
    version: QrVersions.auto,
    gapless: true,
    color: const Color(0xFF000000),
    emptyColor: const Color(0xFFFFFFFF),
  );

  try {
    // Generate image data
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    const size = 200.0; // Size of the QR code image
    qrCodePainter.paint(canvas, Size(size, size));
    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());

    // Convert image to byte data
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    // Upload the QR code image to Firebase Storage under /users/{userId}/
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('users/$userId/qr_codes/$uniqueId.png');
    await storageRef.putData(buffer);

    // Get the download URL
    final downloadUrl = await storageRef.getDownloadURL();

    // Save the generated QR code data to Firestore
    await FirebaseFirestore.instance.collection('QRCodes').add({
      'ContactID': contactRef,
      'EventID': eventRef,
      'UniqueId': uniqueId,
      'QRCodeValue': qrData,
      'QrUrl': downloadUrl, // Save the URL for viewing/downloading the QR code
      'Status': false, // Initially set as unused
      'CheckInTime': FieldValue.serverTimestamp(),
    });

    // Return the permanent download URL for the generated QR code
    return downloadUrl;
  } catch (e) {
    throw Exception('Failed to generate and upload QR code image: $e');
  }
}
