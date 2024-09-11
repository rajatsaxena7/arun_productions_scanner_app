import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'accepeted_model.dart';
export 'accepeted_model.dart';

class AccepetedWidget extends StatefulWidget {
  const AccepetedWidget({super.key});

  @override
  State<AccepetedWidget> createState() => _AccepetedWidgetState();
}

class _AccepetedWidgetState extends State<AccepetedWidget> {
  late AccepetedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccepetedModel());

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
      'assets/lottie_animations/Animation_-_1725977647637.json',
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      fit: BoxFit.cover,
      animate: true,
    );
  }
}
