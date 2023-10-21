// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileResultModelAdapter extends TypeAdapter<ProfileResultModel> {
  @override
  final int typeId = 12;

  @override
  ProfileResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileResultModel(
      id: fields[0] as int?,
      userId: fields[1] as int?,
      aboutCompany: fields[2] as String?,
      mobile: fields[3] as String?,
      location: fields[4] as String?,
      companyLogo: fields[5] as String?,
      companyName: fields[6] as String?,
      companyNameArabic: fields[7] as String?,
      companyAddress1: fields[8] as String?,
      companyAddress1Arabic: fields[9] as String?,
      companyAddress2: fields[10] as String?,
      companyAddress2Arabic: fields[11] as String?,
      companyCrn: fields[12] as String?,
      companyVat: fields[13] as String?,
      accountName: fields[14] as String?,
      accountNameArabic: fields[15] as String?,
      bankName: fields[16] as String?,
      bankNameArabic: fields[17] as String?,
      accountNumber: fields[18] as String?,
      iban: fields[19] as String?,
      bankBranch: fields[20] as String?,
      bankBranchArabic: fields[21] as String?,
      web: fields[22] as String?,
      mail: fields[23] as String?,
      tele: fields[24] as String?,
      saleStartNumber: fields[25] as int?,
      quotationStartNumber: fields[26] as int?,
      purchaseStartNumber: fields[27] as int?,
      deliveryStartNumber: fields[28] as int?,
      companySalePrefix: fields[29] as String?,
      companyPurchaseOrderPrefix: fields[30] as String?,
      companyPurchasePrefix: fields[31] as String?,
      companyPurchaseReturnPrefix: fields[32] as String?,
      companyQuotationPrefix: fields[33] as String?,
      companySaleReturnPrefix: fields[34] as String?,
      companyDeliveryNotePrefix: fields[35] as String?,
      zeroPad: fields[36] as int?,
      logoInPos: fields[37] as bool?,
      pdfHeader: fields[38] as String?,
      pdfFooter: fields[39] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileResultModel obj) {
    writer
      ..writeByte(40)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.aboutCompany)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.companyLogo)
      ..writeByte(6)
      ..write(obj.companyName)
      ..writeByte(7)
      ..write(obj.companyNameArabic)
      ..writeByte(8)
      ..write(obj.companyAddress1)
      ..writeByte(9)
      ..write(obj.companyAddress1Arabic)
      ..writeByte(10)
      ..write(obj.companyAddress2)
      ..writeByte(11)
      ..write(obj.companyAddress2Arabic)
      ..writeByte(12)
      ..write(obj.companyCrn)
      ..writeByte(13)
      ..write(obj.companyVat)
      ..writeByte(14)
      ..write(obj.accountName)
      ..writeByte(15)
      ..write(obj.accountNameArabic)
      ..writeByte(16)
      ..write(obj.bankName)
      ..writeByte(17)
      ..write(obj.bankNameArabic)
      ..writeByte(18)
      ..write(obj.accountNumber)
      ..writeByte(19)
      ..write(obj.iban)
      ..writeByte(20)
      ..write(obj.bankBranch)
      ..writeByte(21)
      ..write(obj.bankBranchArabic)
      ..writeByte(22)
      ..write(obj.web)
      ..writeByte(23)
      ..write(obj.mail)
      ..writeByte(24)
      ..write(obj.tele)
      ..writeByte(25)
      ..write(obj.saleStartNumber)
      ..writeByte(26)
      ..write(obj.quotationStartNumber)
      ..writeByte(27)
      ..write(obj.purchaseStartNumber)
      ..writeByte(28)
      ..write(obj.deliveryStartNumber)
      ..writeByte(29)
      ..write(obj.companySalePrefix)
      ..writeByte(30)
      ..write(obj.companyPurchaseOrderPrefix)
      ..writeByte(31)
      ..write(obj.companyPurchasePrefix)
      ..writeByte(32)
      ..write(obj.companyPurchaseReturnPrefix)
      ..writeByte(33)
      ..write(obj.companyQuotationPrefix)
      ..writeByte(34)
      ..write(obj.companySaleReturnPrefix)
      ..writeByte(35)
      ..write(obj.companyDeliveryNotePrefix)
      ..writeByte(36)
      ..write(obj.zeroPad)
      ..writeByte(37)
      ..write(obj.logoInPos)
      ..writeByte(38)
      ..write(obj.pdfHeader)
      ..writeByte(39)
      ..write(obj.pdfFooter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResultModel _$ProfileResultModelFromJson(Map<String, dynamic> json) =>
    ProfileResultModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      aboutCompany: json['about_company'] as String?,
      mobile: json['mobile'] as String?,
      location: json['location'] as String?,
      companyLogo: json['company_logo'] as String?,
      companyName: json['company_name'] as String?,
      companyNameArabic: json['company_name_arabic'] as String?,
      companyAddress1: json['company_address_1'] as String?,
      companyAddress1Arabic: json['company_address_1_arabic'] as String?,
      companyAddress2: json['company_address_2'] as String?,
      companyAddress2Arabic: json['company_address_2_arabic'] as String?,
      companyCrn: json['company_crn'] as String?,
      companyVat: json['company_vat'] as String?,
      accountName: json['account_name'] as String?,
      accountNameArabic: json['account_name_arabic'] as String?,
      bankName: json['bank_name'] as String?,
      bankNameArabic: json['bank_name_arabic'] as String?,
      accountNumber: json['account_number'] as String?,
      iban: json['iban'] as String?,
      bankBranch: json['bank_branch'] as String?,
      bankBranchArabic: json['bank_branch_arabic'] as String?,
      web: json['web'] as String?,
      mail: json['mail'] as String?,
      tele: json['tele'] as String?,
      saleStartNumber: json['sale_start_number'] as int?,
      quotationStartNumber: json['quotation_start_number'] as int?,
      purchaseStartNumber: json['purchase_start_number'] as int?,
      deliveryStartNumber: json['delivery_start_number'] as int?,
      companySalePrefix: json['company_sale_prefix'] as String?,
      companyPurchaseOrderPrefix:
          json['company_purchase_order_prefix'] as String?,
      companyPurchasePrefix: json['company_purchase_prefix'] as String?,
      companyPurchaseReturnPrefix:
          json['company_purchase_return_prefix'] as String?,
      companyQuotationPrefix: json['company_quotation_prefix'] as String?,
      companySaleReturnPrefix: json['company_sale_return_prefix'] as String?,
      companyDeliveryNotePrefix:
          json['company_delivery_note_prefix'] as String?,
      zeroPad: json['zero_pad'] as int?,
      logoInPos: json['logo_in_pos'] as bool?,
      pdfHeader: json['pdf_header'] as String?,
      pdfFooter: json['pdf_footer'] as String?,
    );

Map<String, dynamic> _$ProfileResultModelToJson(ProfileResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'about_company': instance.aboutCompany,
      'mobile': instance.mobile,
      'location': instance.location,
      'company_logo': instance.companyLogo,
      'company_name': instance.companyName,
      'company_name_arabic': instance.companyNameArabic,
      'company_address_1': instance.companyAddress1,
      'company_address_1_arabic': instance.companyAddress1Arabic,
      'company_address_2': instance.companyAddress2,
      'company_address_2_arabic': instance.companyAddress2Arabic,
      'company_crn': instance.companyCrn,
      'company_vat': instance.companyVat,
      'account_name': instance.accountName,
      'account_name_arabic': instance.accountNameArabic,
      'bank_name': instance.bankName,
      'bank_name_arabic': instance.bankNameArabic,
      'account_number': instance.accountNumber,
      'iban': instance.iban,
      'bank_branch': instance.bankBranch,
      'bank_branch_arabic': instance.bankBranchArabic,
      'web': instance.web,
      'mail': instance.mail,
      'tele': instance.tele,
      'sale_start_number': instance.saleStartNumber,
      'quotation_start_number': instance.quotationStartNumber,
      'purchase_start_number': instance.purchaseStartNumber,
      'delivery_start_number': instance.deliveryStartNumber,
      'company_sale_prefix': instance.companySalePrefix,
      'company_purchase_order_prefix': instance.companyPurchaseOrderPrefix,
      'company_purchase_prefix': instance.companyPurchasePrefix,
      'company_purchase_return_prefix': instance.companyPurchaseReturnPrefix,
      'company_quotation_prefix': instance.companyQuotationPrefix,
      'company_sale_return_prefix': instance.companySaleReturnPrefix,
      'company_delivery_note_prefix': instance.companyDeliveryNotePrefix,
      'zero_pad': instance.zeroPad,
      'logo_in_pos': instance.logoInPos,
      'pdf_header': instance.pdfHeader,
      'pdf_footer': instance.pdfFooter,
    };
