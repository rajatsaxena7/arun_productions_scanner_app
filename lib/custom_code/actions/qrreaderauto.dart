import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http; // Import http package for making API calls
import 'dart:convert'; // Import for JSON encoding

String Nameofreciver = "";

class SimpleQRScanner extends StatefulWidget {
  @override
  _SimpleQRScannerState createState() => _SimpleQRScannerState();
}

class _SimpleQRScannerState extends State<SimpleQRScanner> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // For playing success sound
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    // Automatically start QR code scanning on page load
    WidgetsBinding.instance.addPostFrameCallback((_) => scanQRCode(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Code Scanner',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3A6073), Color(0xFF16222A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: isProcessing
            ? const SpinKitFadingCircle(
                color: Colors.blueAccent, // Modern loading indicator
                size: 50,
              )
            : ElevatedButton(
                onPressed: () => scanQRCode(context),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blueAccent,
                  elevation: 5,
                ),
                child: const Text(
                  'Please wait, Loading...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> scanQRCode(BuildContext context) async {
    setState(() {
      isProcessing = true; // Indicate processing start
    });

    try {
      // Start the QR code scanner and get the scanned result
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Color of the scan line
        'Cancel', // Text for the cancel button
        true, // Whether to show the flash button
        ScanMode.QR, // The scan mode for QR codes
      );

      if (qrCode != '-1') {
        // Check if the result is not the "Cancel" signal
        print('Scanned QR Code: $qrCode'); // Print the scanned QR code
        await _updateFirestoreWithQRCode(context, qrCode); // Update Firestore
      } else {
        print('Scanning cancelled'); // Handle scan cancel
        _restartScanWithDelay(); // Restart scan
      }
    } catch (e) {
      print('Error scanning QR code: $e'); // Log scanning error
      _showErrorDialog(context,
          'Error scanning QR code. Please try again.'); // Show error dialog
    } finally {
      setState(() {
        isProcessing = false; // Indicate processing end
      });
    }
  }

  Future<void> _updateFirestoreWithQRCode(
      BuildContext context, String qrCode) async {
    try {
      // Print the QR code string for debugging
      print('Updating Firestore with QR Code: $qrCode');

      // Convert the scanned QR code string into a Firestore DocumentReference
      DocumentReference docRef = FirebaseFirestore.instance.doc(qrCode);

      // Check if the document exists and if 'islogged' is already true
      DocumentSnapshot docSnapshot = await docRef.get();
      if (docSnapshot.exists && docSnapshot['islogged'] == true) {
        print('QR Code is already logged');
        _showErrorDialog(context,
            'This QR code is already logged.'); // Show already logged in dialog
      } else {
        // Update the 'islogged' field to true and 'Loggedtime' field to the current time
        await docRef.update({
          'islogged': true,
          'Loggedtime': DateTime.now(),
        });
        print('QR Code logged successfully');

        // Fetch email and username for the API request
        String email = docSnapshot['Email'];
        String username = docSnapshot['Name'];
        await _sendEventCompletionEmail(email, username); // Send email via API

        _playSuccessSound(); // Play sound on success
        _showSuccessDialog(context, username); // Show success dialog with modern UI and username
      }
    } catch (e) {
      print('Error updating Firestore: $e');
      _showErrorDialog(context,
          'Error updating QR code. Please try again.'); // Show error dialog
    }
  }

  // Function to send an API request after a successful event completion
  Future<void> _sendEventCompletionEmail(String email, String username) async {
    final String apiUrl = "https://arunproductsemail.vercel.app/welcome_event";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "eventname":
              "abccccc", // Replace with the dynamic event name if available
          "username": username,
        }),
      );

      if (response.statusCode == 200) {
        print('Email sent successfully.');
      } else {
        print('Failed to send email. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  // Function to play a success sound
  void _playSuccessSound() async {
    await _audioPlayer.play(AssetSource(
        'audios/success_bell-6776.wav')); // Place your sound file in the assets directory
  }

  // Function to show a success dialog with modern UI and username
  void _showSuccessDialog(BuildContext context, String username) {
    showDialog(
      context: context,
      barrierDismissible: false, // Disable dismissing by tapping outside
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
          Navigator.of(context).pop(); // Close the dialog
          _restartScanWithDelay(); // Restart scanning after delay
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              const Text(
                'Success',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '$username successfully logged in to the event.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Function to show an error dialog with modern UI
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // Disable dismissing by tapping outside
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
          Navigator.of(context).pop(); // Close the dialog
          _restartScanWithDelay(); // Restart scanning after delay
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 80),
              const SizedBox(height: 20),
              const Text(
                'Error',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Function to restart the scan after a delay of 2 seconds
  void _restartScanWithDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      scanQRCode(context); // Restart scanning again
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the audio player
    super.dispose();
  }
}
