import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "LName" field.
  String? _lName;
  String get lName => _lName ?? '';
  bool hasLName() => _lName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "sensor1" field.
  double? _sensor1;
  double get sensor1 => _sensor1 ?? 0.0;
  bool hasSensor1() => _sensor1 != null;

  // "sensor2" field.
  double? _sensor2;
  double get sensor2 => _sensor2 ?? 0.0;
  bool hasSensor2() => _sensor2 != null;

  // "sensor3" field.
  double? _sensor3;
  double get sensor3 => _sensor3 ?? 0.0;
  bool hasSensor3() => _sensor3 != null;

  // "sensor4" field.
  double? _sensor4;
  double get sensor4 => _sensor4 ?? 0.0;
  bool hasSensor4() => _sensor4 != null;

  // "sensor5" field.
  double? _sensor5;
  double get sensor5 => _sensor5 ?? 0.0;
  bool hasSensor5() => _sensor5 != null;

  // "sensor6" field.
  double? _sensor6;
  double get sensor6 => _sensor6 ?? 0.0;
  bool hasSensor6() => _sensor6 != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "isPatient" field.
  bool? _isPatient;
  bool get isPatient => _isPatient ?? false;
  bool hasIsPatient() => _isPatient != null;

  void _initializeFields() {
    _name = snapshotData['Name'] as String?;
    _lName = snapshotData['LName'] as String?;
    _email = snapshotData['email'] as String?;
    _sensor1 = castToType<double>(snapshotData['sensor1']);
    _sensor2 = castToType<double>(snapshotData['sensor2']);
    _sensor3 = castToType<double>(snapshotData['sensor3']);
    _sensor4 = castToType<double>(snapshotData['sensor4']);
    _sensor5 = castToType<double>(snapshotData['sensor5']);
    _sensor6 = castToType<double>(snapshotData['sensor6']);
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _isPatient = snapshotData['isPatient'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? name,
  String? lName,
  String? email,
  double? sensor1,
  double? sensor2,
  double? sensor3,
  double? sensor4,
  double? sensor5,
  double? sensor6,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  bool? isPatient,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Name': name,
      'LName': lName,
      'email': email,
      'sensor1': sensor1,
      'sensor2': sensor2,
      'sensor3': sensor3,
      'sensor4': sensor4,
      'sensor5': sensor5,
      'sensor6': sensor6,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'isPatient': isPatient,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.lName == e2?.lName &&
        e1?.email == e2?.email &&
        e1?.sensor1 == e2?.sensor1 &&
        e1?.sensor2 == e2?.sensor2 &&
        e1?.sensor3 == e2?.sensor3 &&
        e1?.sensor4 == e2?.sensor4 &&
        e1?.sensor5 == e2?.sensor5 &&
        e1?.sensor6 == e2?.sensor6 &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.isPatient == e2?.isPatient;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.name,
        e?.lName,
        e?.email,
        e?.sensor1,
        e?.sensor2,
        e?.sensor3,
        e?.sensor4,
        e?.sensor5,
        e?.sensor6,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.isPatient
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
