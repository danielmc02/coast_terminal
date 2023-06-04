// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_consent_certificate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContractConsentCertificateAdapter
    extends TypeAdapter<ContractConsentCertificate> {
  @override
  final int typeId = 2;

  @override
  ContractConsentCertificate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContractConsentCertificate(
      fields[0] as bool,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContractConsentCertificate obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ccpaCompliant)
      ..writeByte(1)
      ..write(obj.schoolName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractConsentCertificateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
