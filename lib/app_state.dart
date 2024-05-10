import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _Usuarios = prefs.getStringList('ff_Usuarios') ?? _Usuarios;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _Usuarios = ['Hello World', 'Hello World', 'Hello World'];
  List<String> get Usuarios => _Usuarios;
  set Usuarios(List<String> _value) {
    _Usuarios = _value;
    prefs.setStringList('ff_Usuarios', _value);
  }

  void addToUsuarios(String _value) {
    _Usuarios.add(_value);
    prefs.setStringList('ff_Usuarios', _Usuarios);
  }

  void removeFromUsuarios(String _value) {
    _Usuarios.remove(_value);
    prefs.setStringList('ff_Usuarios', _Usuarios);
  }

  void removeAtIndexFromUsuarios(int _index) {
    _Usuarios.removeAt(_index);
    prefs.setStringList('ff_Usuarios', _Usuarios);
  }

  void updateUsuariosAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _Usuarios[_index] = updateFn(_Usuarios[_index]);
    prefs.setStringList('ff_Usuarios', _Usuarios);
  }

  void insertAtIndexInUsuarios(int _index, String _value) {
    _Usuarios.insert(_index, _value);
    prefs.setStringList('ff_Usuarios', _Usuarios);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
