// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';

Future<List<DocumentReference>> uploadexcel() async {
  // Initialize an empty list to store document references
  List<DocumentReference> uploadedContactRefs = [];

  try {
    // Pick the Excel file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      withData: true, // Use withData for web to get file content
    );

    // Check if a file was picked
    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.single.bytes;
      if (fileBytes == null) {
        print("File bytes are null");
        return [];
      }

      // Decode the Excel file
      var excel = Excel.decodeBytes(fileBytes);

      // Loop through each sheet in the Excel file
      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet == null) continue;

        // Skip the first row (headers)
        for (var i = 1; i < sheet.rows.length; i++) {
          var row = sheet.rows[i];

          // Helper function to parse date
          DateTime parseDate(String? dateString) {
            if (dateString == null || dateString.isEmpty) {
              return DateTime.now();
            } else {
              try {
                return DateTime.parse(dateString);
              } catch (e) {
                return DateTime.now(); // Fallback if parsing fails
              }
            }
          }

          // Parse phone number safely
          int? phoneNumber;
          try {
            phoneNumber = int.tryParse(row[3]?.value?.toString() ?? '');
          } catch (e) {
            phoneNumber = null; // Fallback if conversion fails
          }

          // Map data to Firestore document fields
          Map<String, dynamic> data = {
            'id': "",
            'Name': row[1]?.value?.toString() ?? 'not set', // Name column
            'Email': row[2]?.value?.toString() ?? 'not set', // Email column
            'PhoneNumber': phoneNumber ?? 0, // Phone Number column
          };

          // Add the document to Firestore collection 'Contacts'
          DocumentReference contactRef =
              await FirebaseFirestore.instance.collection('Contacts').add(data);

          // Add the document reference to the list
          uploadedContactRefs.add(contactRef);
        }
      }

      // Return the list of document references after processing
      return uploadedContactRefs;
    } else {
      print("File not selected or is empty");
      return [];
    }
  } catch (e) {
    print("File not uploaded properly.");
    print("Error: $e");
    return [];
  }
}
