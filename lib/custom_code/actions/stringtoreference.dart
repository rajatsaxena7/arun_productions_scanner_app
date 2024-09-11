// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<DocumentReference?> stringtoreference(String? string) async {
  // Add your function code here!
  if (string == null || string.isEmpty) {
    return null; // Return null if the input string is invalid
  }

  try {
    // Create a DocumentReference from the provided string
    DocumentReference reference = FirebaseFirestore.instance.doc(string);
    return reference; // Return the DocumentReference
  } catch (e) {
    print('Error converting string to DocumentReference: $e');
    return null;
  }
}
