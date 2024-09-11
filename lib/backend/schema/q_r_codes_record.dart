import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QRCodesRecord extends FirestoreRecord {
  QRCodesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "EventID" field.
  DocumentReference? _eventID;
  DocumentReference? get eventID => _eventID;
  bool hasEventID() => _eventID != null;

  // "ContactID" field.
  DocumentReference? _contactID;
  DocumentReference? get contactID => _contactID;
  bool hasContactID() => _contactID != null;

  // "Status" field.
  bool? _status;
  bool get status => _status ?? false;
  bool hasStatus() => _status != null;

  // "CheckInTime" field.
  DateTime? _checkInTime;
  DateTime? get checkInTime => _checkInTime;
  bool hasCheckInTime() => _checkInTime != null;

  // "QRCodeValue" field.
  String? _qRCodeValue;
  String get qRCodeValue => _qRCodeValue ?? '';
  bool hasQRCodeValue() => _qRCodeValue != null;

  // "UniqueId" field.
  String? _uniqueId;
  String get uniqueId => _uniqueId ?? '';
  bool hasUniqueId() => _uniqueId != null;

  // "QrUrl" field.
  String? _qrUrl;
  String get qrUrl => _qrUrl ?? '';
  bool hasQrUrl() => _qrUrl != null;

  void _initializeFields() {
    _eventID = snapshotData['EventID'] as DocumentReference?;
    _contactID = snapshotData['ContactID'] as DocumentReference?;
    _status = snapshotData['Status'] as bool?;
    _checkInTime = snapshotData['CheckInTime'] as DateTime?;
    _qRCodeValue = snapshotData['QRCodeValue'] as String?;
    _uniqueId = snapshotData['UniqueId'] as String?;
    _qrUrl = snapshotData['QrUrl'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('QRCodes');

  static Stream<QRCodesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QRCodesRecord.fromSnapshot(s));

  static Future<QRCodesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => QRCodesRecord.fromSnapshot(s));

  static QRCodesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QRCodesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QRCodesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QRCodesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QRCodesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QRCodesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQRCodesRecordData({
  DocumentReference? eventID,
  DocumentReference? contactID,
  bool? status,
  DateTime? checkInTime,
  String? qRCodeValue,
  String? uniqueId,
  String? qrUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'EventID': eventID,
      'ContactID': contactID,
      'Status': status,
      'CheckInTime': checkInTime,
      'QRCodeValue': qRCodeValue,
      'UniqueId': uniqueId,
      'QrUrl': qrUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class QRCodesRecordDocumentEquality implements Equality<QRCodesRecord> {
  const QRCodesRecordDocumentEquality();

  @override
  bool equals(QRCodesRecord? e1, QRCodesRecord? e2) {
    return e1?.eventID == e2?.eventID &&
        e1?.contactID == e2?.contactID &&
        e1?.status == e2?.status &&
        e1?.checkInTime == e2?.checkInTime &&
        e1?.qRCodeValue == e2?.qRCodeValue &&
        e1?.uniqueId == e2?.uniqueId &&
        e1?.qrUrl == e2?.qrUrl;
  }

  @override
  int hash(QRCodesRecord? e) => const ListEquality().hash([
        e?.eventID,
        e?.contactID,
        e?.status,
        e?.checkInTime,
        e?.qRCodeValue,
        e?.uniqueId,
        e?.qrUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is QRCodesRecord;
}
