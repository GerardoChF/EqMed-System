import '/auth/firebase_auth/auth_util.dart';
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
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

//STATES and vars BT 
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  String times = '0';
  String sdata = '0';
  String sensor1 = '0';
  String sensor2 = '0';
  String sensor3 = '0';
  String sensor4 = '0';
  String sensor5 = '0';
  String sensor6 = '0';

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }
  // termina states bt 


  @override
  void initState() {
    super.initState();
        //Permission bt
    _requestPermission();
    _model = createModel(context, () => MapaRioModel());


    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(30.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: Text(
              'Variable de usuario',
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          actions: [
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    GoRouter.of(context).prepareAuthEvent();
                    await authManager.signOut();
                    GoRouter.of(context).clearRedirectLocation();

                    context.pushNamedAuth('HomePage', context.mounted);
                  },
                  text: 'Cerrar Sesión',
                  icon: Icon(
                    Icons.output_sharp,
                    size: 15.0,
                  ),
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    height: MediaQuery.sizeOf(context).height * 0.03,
                    padding: EdgeInsets.all(0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Plataforma de Rio',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 12.0, 0.0, 0.0),
                          child: Text(
                            'Distribución de cargas',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                          ).animateOnPageLoad(
                              animationsMap['textOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 50.0, 16.0, 0.0),
                          child: Container(
                            width: 350.0,
                            height: 250.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 16.0, 16.0, 16.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/PlatRio.png',
                                      width: 320.0,
                                      height: 200.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                //PROGRESS BAR 1
                                Align(
                                  alignment: AlignmentDirectional(-0.54, -0.6),
                                  child: CircularPercentIndicator(
                                    percent: double.parse(_conversion(sensor1)) /
                                      valueOrDefault(currentUserDocument?.sensor1, 0.0),
                                    radius: 20.0,
                                    lineWidth: 8.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                ),
                                //PROGRESS BAR 2
                                Align(
                                  alignment: AlignmentDirectional(-0.83, 0.62),
                                  child: CircularPercentIndicator(
                                    percent: double.parse(_conversion(sensor2)) / 
                                      valueOrDefault(currentUserDocument?.sensor1, 0.0),
                                    radius: 20.0,
                                    lineWidth: 8.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                ),
                                //PROGRESS BAR 3
                                Align(
                                  alignment: AlignmentDirectional(-0.25, 0.62),
                                  child: CircularPercentIndicator(
                                    percent:double.parse(_conversion(sensor3)) / 
                                      valueOrDefault(currentUserDocument?.sensor1, 0.0),
                                    radius: 20.0,
                                    lineWidth: 8.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                ),
                                //PROGRESS BAR 4
                                Align(
                                  alignment: AlignmentDirectional(0.26, 0.62),
                                  child: CircularPercentIndicator(
                                    percent: double.parse(_conversion(sensor4)) / 
                                      valueOrDefault(currentUserDocument?.sensor1, 0.0),
                                    radius: 20.0,
                                    lineWidth: 8.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                ),
                                //PROGRESS BAR 5
                                Align(
                                  alignment: AlignmentDirectional(0.54, -0.6),
                                  child: CircularPercentIndicator(
                                    percent: double.parse(_conversion(sensor5)) / 
                                      valueOrDefault(currentUserDocument?.sensor1, 0.0),
                                    radius: 20.0,
                                    lineWidth: 8.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                ),
                                //PROGRESS BAR 6
                                Align(
                                  alignment: AlignmentDirectional(0.83, 0.62),
                                  child: CircularPercentIndicator(
                                    percent: double.parse(_conversion(sensor6)) / 
                                      valueOrDefault(currentUserDocument?.sensor1, 0.0),
                                    radius: 20.0,
                                    lineWidth: 8.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: Text(
                            'Vista por arriba',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 4.0, 0.0, 12.0),
                              child: Text(
                                'Más Información',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 4.0, 0.0, 12.0),
                              child: Icon(
                                Icons.navigate_next,
                                color: Colors.black,
                                size: 24.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 350.0,
                          child: Divider(
                            thickness: 3.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                        ),
                        //VALUES OF EACH SENSOR
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              _conversion(sensor1),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              _conversion(sensor2),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              _conversion(sensor3),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              _conversion(sensor4),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              _conversion(sensor5),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              _conversion(sensor6),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                        _infoDevice(),
                        Expanded(child: _listDevices()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//methods bt
  void _receiveData() {
    _connection?.input?.listen((Uint8List data) {
       String decodedString = ascii.decode(data);
       String trimmedString = decodedString.trim();
       String ssdata = trimmedString;
       List<String> values = sdata.split(',');
        String val1 = values.isNotEmpty ? values[0] : 'N/A';
        String val2 = values.length > 1 ? values[1] : 'N/A';
        String val3 = values.length > 2 ? values[2] : 'N/A';
        String val4 = values.length > 3 ? values[3] : 'N/A';
        String val5 = values.length > 4 ? values[4] : 'N/A';
        String val6 = values.length > 5 ? values[5] : 'N/A';

       debugPrint('ssdata = $sdata');
       debugPrint('sensor1 = $val1');
       debugPrint('sensor2 = $val2');
       debugPrint('sensor3 = $val3');
       debugPrint('sensor4 = $val4');
       debugPrint('sensor5 = $val5');
       debugPrint('sensor6 = $val6');

       setState(() {
         sdata = ssdata;
         sensor1 = val1;
         sensor2 = val2;
         sensor3 = val3;
         sensor4 = val4;
         sensor5 = val5;
         sensor6 = val6;
       });
    });
  }

  //CONVERSION BITS TO KPA
  String _conversion(String value) {
    var dvalue = double.parse(value);
    return ((dvalue * 487.144) / 255).toStringAsFixed(2);
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
}

//TESTESTESTESTESTESTESTESTESTETS