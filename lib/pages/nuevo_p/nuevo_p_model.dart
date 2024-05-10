import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'nuevo_p_widget.dart' show NuevoPWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class NuevoPModel extends FlutterFlowModel<NuevoPWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for txt_name widget.
  FocusNode? txtNameFocusNode;
  TextEditingController? txtNameTextController;
  String? Function(BuildContext, String?)? txtNameTextControllerValidator;
  String? _txtNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  // State field(s) for txt_Lname widget.
  FocusNode? txtLnameFocusNode;
  TextEditingController? txtLnameTextController;
  String? Function(BuildContext, String?)? txtLnameTextControllerValidator;
  String? _txtLnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an age for the patient.';
    }

    return null;
  }

  // State field(s) for txt_PhN widget.
  FocusNode? txtPhNFocusNode;
  TextEditingController? txtPhNTextController;
  String? Function(BuildContext, String?)? txtPhNTextControllerValidator;
  // State field(s) for txt_DoB widget.
  FocusNode? txtDoBFocusNode;
  TextEditingController? txtDoBTextController;
  final txtDoBMask = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? txtDoBTextControllerValidator;
  String? _txtDoBTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the date of birth of the patient.';
    }

    return null;
  }

  // State field(s) for drop_Pros widget.
  String? dropProsValue;
  FormFieldController<String>? dropProsValueController;
  // State field(s) for txt_sens1 widget.
  FocusNode? txtSens1FocusNode;
  TextEditingController? txtSens1TextController;
  String? Function(BuildContext, String?)? txtSens1TextControllerValidator;
  // State field(s) for txt_sens2 widget.
  FocusNode? txtSens2FocusNode;
  TextEditingController? txtSens2TextController;
  String? Function(BuildContext, String?)? txtSens2TextControllerValidator;
  // State field(s) for txt_sens3 widget.
  FocusNode? txtSens3FocusNode;
  TextEditingController? txtSens3TextController;
  String? Function(BuildContext, String?)? txtSens3TextControllerValidator;
  // State field(s) for txt_sens4 widget.
  FocusNode? txtSens4FocusNode;
  TextEditingController? txtSens4TextController;
  String? Function(BuildContext, String?)? txtSens4TextControllerValidator;
  // State field(s) for txt_sens5 widget.
  FocusNode? txtSens5FocusNode;
  TextEditingController? txtSens5TextController;
  String? Function(BuildContext, String?)? txtSens5TextControllerValidator;
  // State field(s) for txt_sens6 widget.
  FocusNode? txtSens6FocusNode;
  TextEditingController? txtSens6TextController;
  String? Function(BuildContext, String?)? txtSens6TextControllerValidator;

  @override
  void initState(BuildContext context) {
    txtNameTextControllerValidator = _txtNameTextControllerValidator;
    txtLnameTextControllerValidator = _txtLnameTextControllerValidator;
    txtDoBTextControllerValidator = _txtDoBTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    txtNameFocusNode?.dispose();
    txtNameTextController?.dispose();

    txtLnameFocusNode?.dispose();
    txtLnameTextController?.dispose();

    txtPhNFocusNode?.dispose();
    txtPhNTextController?.dispose();

    txtDoBFocusNode?.dispose();
    txtDoBTextController?.dispose();

    txtSens1FocusNode?.dispose();
    txtSens1TextController?.dispose();

    txtSens2FocusNode?.dispose();
    txtSens2TextController?.dispose();

    txtSens3FocusNode?.dispose();
    txtSens3TextController?.dispose();

    txtSens4FocusNode?.dispose();
    txtSens4TextController?.dispose();

    txtSens5FocusNode?.dispose();
    txtSens5TextController?.dispose();

    txtSens6FocusNode?.dispose();
    txtSens6TextController?.dispose();
  }
}
