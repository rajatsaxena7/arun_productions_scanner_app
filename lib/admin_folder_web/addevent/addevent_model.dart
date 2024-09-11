import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/custom_code/actions/index.dart' as actions;
import 'addevent_widget.dart' show AddeventWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddeventModel extends FlutterFlowModel<AddeventWidget> {
  ///  Local state fields for this page.

  List<ExcelsheetdetailsStruct> emaildetails = [];
  void addToEmaildetails(ExcelsheetdetailsStruct item) =>
      emaildetails.add(item);
  void removeFromEmaildetails(ExcelsheetdetailsStruct item) =>
      emaildetails.remove(item);
  void removeAtIndexFromEmaildetails(int index) => emaildetails.removeAt(index);
  void insertAtIndexInEmaildetails(int index, ExcelsheetdetailsStruct item) =>
      emaildetails.insert(index, item);
  void updateEmaildetailsAtIndex(
          int index, Function(ExcelsheetdetailsStruct) updateFn) =>
      emaildetails[index] = updateFn(emaildetails[index]);

  bool emailupdated = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  DateTime? datePicked;
  // Stores action output result for [Custom Action - uploadexcel] action in Container widget.
  List<DocumentReference>? excelupload;
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<DocumentReference>();
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  EventRecord? createdEvent;
  // Stores action output result for [Custom Action - generateQr] action in Button widget.
  String? qrcode;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    paginatedDataTableController.dispose();
  }
}
