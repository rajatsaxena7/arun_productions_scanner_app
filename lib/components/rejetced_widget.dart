import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'rejetced_model.dart';
export 'rejetced_model.dart';

class RejetcedWidget extends StatefulWidget {
  const RejetcedWidget({super.key});

  @override
  State<RejetcedWidget> createState() => _RejetcedWidgetState();
}

class _RejetcedWidgetState extends State<RejetcedWidget> {
  late RejetcedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RejetcedModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie_animations/Animation_-_1725978964405.json',
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      fit: BoxFit.cover,
      animate: true,
    );
  }
}
