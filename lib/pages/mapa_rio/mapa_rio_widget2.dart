import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'mapa_rio_model.dart';
export 'mapa_rio_model.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

class MapaRioWidget extends StatefulWidget {
  const MapaRioWidget({
    super.key,
    bool? isBluetoothEnabled,
  }) : this.isBluetoothEnabled = isBluetoothEnabled ?? false;

  final bool isBluetoothEnabled;

  @override
  State<MapaRioWidget> createState() => _MapaRioWidgetState();
}

class _MapaRioWidgetState extends State<MapaRioWidget>
    with TickerProviderStateMixin {
  late MapaRioModel _model;

  //BT RAFA
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  String times = '0';

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  void _receiveData() {
    const splitter = LineSplitter();
    // _connection?.input?.listen((Uint8List data) {
    //   // debugPrint('Data incoming: ${ascii.decode(data)} + ${data.length}');
    //   int value = 0;
    //   if (data.length == 2) {
    //     value =
    //         (data[0] << 8) + data[1]; // Combine two bytes into a uint16 value
    //     debugPrint('SIII');
    //   } else {
    //     value = int.parse(ascii.decode(data));
    //   }
    //   // debugPrint('Data incoming: $value');
    //   setState(() => times = value.toString());
    //   // debugPrint("  ");
    //   // print(event);
    // });
    _connection?.input?.listen((Uint8List data) {
      if (data.length > 2) {
        debugPrint('raw data: $data');
        debugPrint('ascii data: ${ascii.decode(data)}');
        debugPrint('String data: ${String.fromCharCodes(data)}');
        var stringList = splitter.convert(String.fromCharCodes(data));
        debugPrint(
            'Splitter string data: $stringList');
        var largestVal = int.parse(stringList[0]);
        for (var i = 0; i < stringList.length ; i++) {
          var stringListInt = int.parse(stringList[i]);
          if (stringListInt > largestVal) {
            largestVal = stringListInt;
          }
        }
        debugPrint('Unique value: $largestVal');
        debugPrint('------------------------------------------------');
        setState(() =>
            times = largestVal.toString());
      }
      // setState(() => times = ascii.decode(data));
    });
  }

  void _sendData(String data) {
    if (_connection?.isConnected ?? false) {
      _connection?.output.add(ascii.encode(data));
    }
  }

  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    super.initState();

    _requestPermission();

    // _bluetooth.state.then((state) {
    //   setState(() => _bluetoothState = state.isEnabled);
    // });

    // _bluetooth.onStateChanged().listen((state) {
    //   switch (state) {
    //     case BluetoothState.STATE_OFF:
    //       setState(() => _bluetoothState = false);
    //       break;
    //     case BluetoothState.STATE_ON:
    //       setState(() => _bluetoothState = true);
    //       break;
    //     // case BluetoothState.STATE_TURNING_OFF:
    //     //   break;
    //     // case BluetoothState.STATE_TURNING_ON:
    //     //   break;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter and Arduino'),
      ),
      body: Column(
        children: [
          _infoDevice(),
          Expanded(child: _listDevices()),
          //_inputSerial(),
          // LiveLineChart(times),
          // _buttons(),
        ],
      ),
    );
  }

  Widget _controlBT() {
    return SwitchListTile(
      value: _bluetoothState,
      onChanged: (bool value) async {
        if (value) {
          await _bluetooth.requestEnable();
        } else {
          await _bluetooth.requestDisable();
        }
      },
      tileColor: Colors.black26,
      title: Text(
        _bluetoothState ? "Bluetooth encendido" : "Bluetooth apagado",
      ),
    );
  }

  Widget _infoDevice() {
    return ListTile(
      tileColor: Colors.black12,
      title: Text("Conectado a: ${_deviceConnected?.name ?? "ninguno"}"),
      trailing: _connection?.isConnected ?? false
          ? TextButton(
              onPressed: () async {
                await _connection?.finish();
                setState(() => _deviceConnected = null);
              },
              child: const Text("Desconectar"),
            )
          : TextButton(
              onPressed: _getDevices,
              child: const Text("Ver dispositivos"),
            ),
    );
  }

  Widget _listDevices() {
    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  ...[
                    for (final device in _devices)
                      ListTile(
                        title: Text(device.name ?? device.address),
                        trailing: TextButton(
                          child: const Text('conectar'),
                          onPressed: () async {
                            setState(() => _isConnecting = true);

                            _connection = await BluetoothConnection.toAddress(
                                device.address);
                            _deviceConnected = device;
                            _devices = [];
                            _isConnecting = false;

                            _receiveData();

                            setState(() {});
                          },
                        ),
                      )
                  ]
                ],
              ),
            ),
          );
  }

  Widget _inputSerial() {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity(vertical: -3),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          "Valor = $times",
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
  //TERMINA BT RAFA

  // final scaffoldKey = GlobalKey<ScaffoldState>();

  // final animationsMap = <String, AnimationInfo>{};

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();
//     _model = createModel(context, () => MapaRioModel());

//     animationsMap.addAll({
//       'textOnPageLoadAnimation': AnimationInfo(
//         trigger: AnimationTrigger.onPageLoad,
//         effectsBuilder: () => [
//           FadeEffect(
//             curve: Curves.easeInOut,
//             delay: 0.0.ms,
//             duration: 600.0.ms,
//             begin: 0.0,
//             end: 1.0,
//           ),
//           MoveEffect(
//             curve: Curves.easeInOut,
//             delay: 0.0.ms,
//             duration: 600.0.ms,
//             begin: Offset(30.0, 0.0),
//             end: Offset(0.0, 0.0),
//           ),
//         ],
//       ),
//     });
//     setupAnimations(
//       animationsMap.values.where((anim) =>
//           anim.trigger == AnimationTrigger.onActionTrigger ||
//           !anim.applyInitialState),
//       this,
//     );
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//           automaticallyImplyLeading: false,
//           title: Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
//             child: Text(
//               'Variable de usuario',
//               style: FlutterFlowTheme.of(context).labelMedium.override(
//                     fontFamily: 'Readex Pro',
//                     letterSpacing: 0.0,
//                   ),
//             ),
//           ),
//           actions: [
//             Align(
//               alignment: AlignmentDirectional(0.0, 1.0),
//               child: Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
//                 child: FFButtonWidget(
//                   onPressed: () async {
//                     GoRouter.of(context).prepareAuthEvent();
//                     await authManager.signOut();
//                     GoRouter.of(context).clearRedirectLocation();

//                     context.pushNamedAuth('HomePage', context.mounted);
//                   },
//                   text: 'Cerrar Sesión',
//                   icon: Icon(
//                     Icons.output_sharp,
//                     size: 15.0,
//                   ),
//                   options: FFButtonOptions(
//                     width: MediaQuery.sizeOf(context).width * 0.3,
//                     height: MediaQuery.sizeOf(context).height * 0.03,
//                     padding: EdgeInsets.all(0.0),
//                     iconPadding:
//                         EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
//                     color: Colors.transparent,
//                     textStyle: FlutterFlowTheme.of(context).titleSmall.override(
//                           fontFamily: 'Readex Pro',
//                           color: FlutterFlowTheme.of(context).primaryText,
//                           fontSize: 14.0,
//                           letterSpacing: 0.0,
//                         ),
//                     elevation: 0.0,
//                     borderSide: BorderSide(
//                       color: Colors.transparent,
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.circular(0.0),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//           centerTitle: false,
//           elevation: 0.0,
//         ),
//         body: SafeArea(
//           top: true,
//           child: Stack(
//             children: [
//               Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   16.0, 4.0, 0.0, 0.0),
//                               child: Text(
//                                 'Plataforma de Rio',
//                                 style: FlutterFlowTheme.of(context)
//                                     .headlineMedium
//                                     .override(
//                                       fontFamily: 'Outfit',
//                                       letterSpacing: 0.0,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(
//                               16.0, 12.0, 0.0, 0.0),
//                           child: Text(
//                             'Distribución de cargas',
//                             style: FlutterFlowTheme.of(context)
//                                 .labelLarge
//                                 .override(
//                                   fontFamily: 'Readex Pro',
//                                   letterSpacing: 0.0,
//                                 ),
//                           ).animateOnPageLoad(
//                               animationsMap['textOnPageLoadAnimation']!),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           // Padding(
//                           //   padding: EdgeInsetsDirectional.fromSTEB(
//                           //       16.0, 50.0, 16.0, 0.0),
//                           //   child: Container(
//                           //     width: 350.0,
//                           //     height: 250.0,
//                           //     decoration: BoxDecoration(
//                           //       color: FlutterFlowTheme.of(context)
//                           //           .secondaryBackground,
//                           //       borderRadius: BorderRadius.circular(24.0),
//                           //     ),
//                           //     child: Stack(
//                           //       children: [
//                           //         Padding(
//                           //           padding: EdgeInsetsDirectional.fromSTEB(
//                           //               16.0, 16.0, 16.0, 16.0),
//                           //           child: ClipRRect(
//                           //             borderRadius: BorderRadius.circular(8.0),
//                           //             child: Image.asset(
//                           //               'assets/images/PlatRio.png',
//                           //               width: 320.0,
//                           //               height: 200.0,
//                           //               fit: BoxFit.fitWidth,
//                           //             ),
//                           //           ),
//                           //         ),
//                           //         Align(
//                           //           alignment:
//                           //               AlignmentDirectional(-0.54, -0.6),
//                           //           child: CircularPercentIndicator(
//                           //             percent: 0.5,
//                           //             radius: 20.0,
//                           //             lineWidth: 8.0,
//                           //             animation: true,
//                           //             animateFromLastPercent: true,
//                           //             progressColor:
//                           //                 FlutterFlowTheme.of(context)
//                           //                     .alternate,
//                           //             backgroundColor:
//                           //                 FlutterFlowTheme.of(context).error,
//                           //           ),
//                           //         ),
//                           //         Align(
//                           //           alignment:
//                           //               AlignmentDirectional(-0.83, 0.62),
//                           //           child: CircularPercentIndicator(
//                           //             percent: 0.5,
//                           //             radius: 20.0,
//                           //             lineWidth: 8.0,
//                           //             animation: true,
//                           //             animateFromLastPercent: true,
//                           //             progressColor:
//                           //                 FlutterFlowTheme.of(context)
//                           //                     .alternate,
//                           //             backgroundColor:
//                           //                 FlutterFlowTheme.of(context).error,
//                           //           ),
//                           //         ),
//                           //         Align(
//                           //           alignment:
//                           //               AlignmentDirectional(-0.25, 0.62),
//                           //           child: CircularPercentIndicator(
//                           //             percent: 0.5,
//                           //             radius: 20.0,
//                           //             lineWidth: 8.0,
//                           //             animation: true,
//                           //             animateFromLastPercent: true,
//                           //             progressColor:
//                           //                 FlutterFlowTheme.of(context)
//                           //                     .alternate,
//                           //             backgroundColor:
//                           //                 FlutterFlowTheme.of(context).error,
//                           //           ),
//                           //         ),
//                           //         Align(
//                           //           alignment: AlignmentDirectional(0.26, 0.62),
//                           //           child: CircularPercentIndicator(
//                           //             percent: 0.5,
//                           //             radius: 20.0,
//                           //             lineWidth: 8.0,
//                           //             animation: true,
//                           //             animateFromLastPercent: true,
//                           //             progressColor:
//                           //                 FlutterFlowTheme.of(context)
//                           //                     .alternate,
//                           //             backgroundColor:
//                           //                 FlutterFlowTheme.of(context).error,
//                           //           ),
//                           //         ),
//                           //         Align(
//                           //           alignment: AlignmentDirectional(0.54, -0.6),
//                           //           child: CircularPercentIndicator(
//                           //             percent: 0.5,
//                           //             radius: 20.0,
//                           //             lineWidth: 8.0,
//                           //             animation: true,
//                           //             animateFromLastPercent: true,
//                           //             progressColor:
//                           //                 FlutterFlowTheme.of(context)
//                           //                     .alternate,
//                           //             backgroundColor:
//                           //                 FlutterFlowTheme.of(context).error,
//                           //           ),
//                           //         ),
//                           //         Align(
//                           //           alignment: AlignmentDirectional(0.83, 0.62),
//                           //           child: CircularPercentIndicator(
//                           //             percent: 0.5,
//                           //             radius: 20.0,
//                           //             lineWidth: 8.0,
//                           //             animation: true,
//                           //             animateFromLastPercent: true,
//                           //             progressColor:
//                           //                 FlutterFlowTheme.of(context)
//                           //                     .alternate,
//                           //             backgroundColor:
//                           //                 FlutterFlowTheme.of(context).error,
//                           //           ),
//                           //         ),
//                           //       ],
//                           //     ),
//                           //   ),
//                           // ),
//                           // Padding(
//                           //   padding: EdgeInsetsDirectional.fromSTEB(
//                           //       0.0, 16.0, 0.0, 0.0),
//                           //   child: Text(
//                           //     'Vista por arriba',
//                           //     style: FlutterFlowTheme.of(context)
//                           //         .headlineSmall
//                           //         .override(
//                           //           fontFamily: 'Outfit',
//                           //           fontSize: 20.0,
//                           //           letterSpacing: 0.0,
//                           //         ),
//                           //   ),
//                           // ),
//                           // Row(
//                           //   mainAxisSize: MainAxisSize.max,
//                           //   mainAxisAlignment: MainAxisAlignment.center,
//                           //   children: [
//                           //     Padding(
//                           //       padding: EdgeInsetsDirectional.fromSTEB(
//                           //           4.0, 4.0, 0.0, 12.0),
//                           //       child: Text(
//                           //         'Más Información',
//                           //         style: FlutterFlowTheme.of(context)
//                           //             .labelMedium
//                           //             .override(
//                           //               fontFamily: 'Readex Pro',
//                           //               fontSize: 14.0,
//                           //               letterSpacing: 0.0,
//                           //             ),
//                           //       ),
//                           //     ),
//                           //     Padding(
//                           //       padding: EdgeInsetsDirectional.fromSTEB(
//                           //           0.0, 4.0, 0.0, 12.0),
//                           //       child: Icon(
//                           //         Icons.navigate_next,
//                           //         color: Colors.black,
//                           //         size: 24.0,
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           // SizedBox(
//                           //   width: 350.0,
//                           //   child: Divider(
//                           //     thickness: 3.0,
//                           //     color: FlutterFlowTheme.of(context).accent4,
//                           //   ),
//                           // ),
//                           // Padding(
//                           //   padding: EdgeInsetsDirectional.fromSTEB(
//                           //       16.0, 12.0, 16.0, 0.0),
//                           //   child: Row(
//                           //     mainAxisSize: MainAxisSize.max,
//                           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //     children: [
//                           //       Text(
//                           //         'Conectado a: Dispositivo',
//                           //         style: FlutterFlowTheme.of(context)
//                           //             .bodyLarge
//                           //             .override(
//                           //               fontFamily: 'Readex Pro',
//                           //               letterSpacing: 0.0,
//                           //             ),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),
//                           // Align(
//                           //   alignment: AlignmentDirectional(-1.0, 0.0),
//                           //   child: Padding(
//                           //     padding: EdgeInsetsDirectional.fromSTEB(
//                           //         16.0, 12.0, 16.0, 0.0),
//                           //     child: FFButtonWidget(
//                           //       onPressed: () {
//                           //         print('Button pressed ...');
//                           //       },
//                           //       text: 'Ver Dispositivos',
//                           //       icon: Icon(
//                           //         Icons.output_sharp,
//                           //         size: 15.0,
//                           //       ),
//                           //       options: FFButtonOptions(
//                           //         width: MediaQuery.sizeOf(context).width * 0.5,
//                           //         height:
//                           //             MediaQuery.sizeOf(context).height * 0.03,
//                           //         padding: EdgeInsets.all(4.0),
//                           //         iconPadding: EdgeInsetsDirectional.fromSTEB(
//                           //             0.0, 0.0, 0.0, 0.0),
//                           //         color: FlutterFlowTheme.of(context).alternate,
//                           //         textStyle: FlutterFlowTheme.of(context)
//                           //             .titleSmall
//                           //             .override(
//                           //               fontFamily: 'Readex Pro',
//                           //               color: FlutterFlowTheme.of(context)
//                           //                   .primaryText,
//                           //               fontSize: 14.0,
//                           //               letterSpacing: 0.0,
//                           //             ),
//                           //         elevation: 0.0,
//                           //         borderSide: BorderSide(
//                           //           color:
//                           //               FlutterFlowTheme.of(context).tertiary,
//                           //           width: 1.0,
//                           //         ),
//                           //         borderRadius: BorderRadius.circular(10.0),
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ),
//                           // Text(
//                           //   times,
//                           //   style: FlutterFlowTheme.of(context)
//                           //       .bodyMedium
//                           //       .override(
//                           //         fontFamily: 'Readex Pro',
//                           //         letterSpacing: 0.0,
//                           //       ),
//                           // ),
//                           _infoDevice(),
//                           _listDevices(),
                          
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}
//BLUETOOTH 