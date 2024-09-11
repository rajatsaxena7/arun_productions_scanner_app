import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactsRecord extends FirestoreRecord {
  ContactsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "Email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "PhoneNumber" field.
  int? _phoneNumber;
  int get phoneNumber => _phoneNumber ?? 0;
  bool hasPhoneNumber() => _phoneNumber != null;

  // "AssociatedEventID" field.
  DocumentReference? _associatedEventID;
  DocumentReference? get associatedEventID => _associatedEventID;
  bool hasAssociatedEventID() => _associatedEventID != null;

  // "islogged" field.
  bool? _islogged;
  bool get islogged => _islogged ?? false;
  bool hasIslogged() => _islogged != null;

  // "signedintime" field.
  DateTime? _signedintime;
  DateTime? get signedintime => _signedintime;
  bool hasSignedintime() => _signedintime != null;

  // "inclusions" field.
  List<String>? _inclusions;
  List<String> get inclusions => _inclusions ?? const [];
  bool hasInclusions() => _inclusions != null;

  void _initializeFields() {
    _name = snapshotData['Name'] as String?;
    _email = snapshotData['Email'] as String?;
    _phoneNumber = castToType<int>(snapshotData['PhoneNumber']);
    _associatedEventID =
        snapshotData['AssociatedEventID'] as DocumentReference?;
    _islogged = snapshotData['islogged'] as bool?;
    _signedintime = snapshotData['signedintime'] as DateTime?;
    _inclusions = getDataList(snapshotData['inclusions']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Contacts');

  static Stream<ContactsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ContactsRecord.fromSnapshot(s));

  static Future<ContactsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ContactsRecord.fromSnapshot(s));

  static ContactsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ContactsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ContactsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ContactsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ContactsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ContactsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createContactsRecordData({
  String? name,
  String? email,
  int? phoneNumber,
  DocumentReference? associatedEventID,
  bool? islogged,
  DateTime? signedintime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'AssociatedEventID': associatedEventID,
      'islogged': islogged,
      'signedintime': signedintime,
    }.withoutNulls,
  );

  return firestoreData;
}

class ContactsRecordDocumentEquality implements Equality<ContactsRecord> {
  const ContactsRecordDocumentEquality();

  @override
  bool equals(ContactsRecord? e1, ContactsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.email == e2?.email &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.associatedEventID == e2?.associatedEventID &&
        e1?.islogged == e2?.islogged &&
        e1?.signedintime == e2?.signedintime &&
        listEquality.equals(e1?.inclusions, e2?.inclusions);
  }

  @override
  int hash(ContactsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.email,
        e?.phoneNumber,
        e?.associatedEventID,
        e?.islogged,
        e?.signedintime,
        e?.inclusions
      ]);

  @override
  bool isValidKey(Object? o) => o is ContactsRecord;
}
