import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  var qrcode = '';
  // Stores action output result for [Custom Action - stringtoreference] action in Button widget.
  DocumentReference? referencedoc;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  ContactsRecord? readdocument;
  // Stores action output result for [Custom Action - qrreaderauto] action in Button widget.
  bool? readerauto;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
