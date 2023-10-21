import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'profile_result_model.g.dart';
@HiveType(typeId: 12)

@JsonSerializable(explicitToJson: true)
class ProfileResultModel {
 @HiveField(0) final int? id;
 @HiveField(1) @JsonKey(name: "user_id") final int? userId;
 @HiveField(2) @JsonKey(name: "about_company") final String? aboutCompany;
 @HiveField(3) final String? mobile;
 @HiveField(4)  final String? location;
 @HiveField(5)  @JsonKey(name: "company_logo") final String? companyLogo;
 @HiveField(6)  @JsonKey(name: "company_name") final String? companyName;
 @HiveField(7)  @JsonKey(name: "company_name_arabic") final String? companyNameArabic;
 @HiveField(8)  @JsonKey(name: "company_address_1") final String? companyAddress1;
 @HiveField(9)  @JsonKey(name: "company_address_1_arabic") final String? companyAddress1Arabic;
 @HiveField(10)  @JsonKey(name: "company_address_2") final String? companyAddress2;
 @HiveField(11)  @JsonKey(name: "company_address_2_arabic") final String? companyAddress2Arabic;
 @HiveField(12)  @JsonKey(name: "company_crn") final String? companyCrn;
 @HiveField(13)  @JsonKey(name: "company_vat") final String? companyVat;
 @HiveField(14)  @JsonKey(name: "account_name") final String? accountName;
 @HiveField(15)  @JsonKey(name: "account_name_arabic") final String? accountNameArabic;
 @HiveField(16)  @JsonKey(name: "bank_name") final String? bankName;
 @HiveField(17)  @JsonKey(name: "bank_name_arabic") final String? bankNameArabic;
 @HiveField(18)  @JsonKey(name: "account_number") final String? accountNumber;
 @HiveField(19)  @JsonKey(name: "iban") final String? iban;
 @HiveField(20)  @JsonKey(name: "bank_branch") final String? bankBranch;
 @HiveField(21)  @JsonKey(name: "bank_branch_arabic") final String? bankBranchArabic;
 @HiveField(22)  @JsonKey(name: "web") final String? web;
 @HiveField(23)  @JsonKey(name: "mail") final String? mail;
 @HiveField(24)  @JsonKey(name: "tele") final String? tele;
 @HiveField(25)  @JsonKey(name: "sale_start_number") final int? saleStartNumber;
 @HiveField(26)  @JsonKey(name: "quotation_start_number") final int? quotationStartNumber;
 @HiveField(27)  @JsonKey(name: "purchase_start_number") final int? purchaseStartNumber;
 @HiveField(28)  @JsonKey(name: "delivery_start_number") final int? deliveryStartNumber;
 @HiveField(29)  @JsonKey(name: "company_sale_prefix") final String? companySalePrefix;
 @HiveField(30)  @JsonKey(name: "company_purchase_order_prefix") final String? companyPurchaseOrderPrefix;
 @HiveField(31)  @JsonKey(name: "company_purchase_prefix") final String? companyPurchasePrefix;
 @HiveField(32)  @JsonKey(name: "company_purchase_return_prefix") final String? companyPurchaseReturnPrefix;
 @HiveField(33)  @JsonKey(name: "company_quotation_prefix") final String? companyQuotationPrefix;
 @HiveField(34)  @JsonKey(name: "company_sale_return_prefix") final String? companySaleReturnPrefix;
 @HiveField(35)  @JsonKey(name: "company_delivery_note_prefix") final String? companyDeliveryNotePrefix;
 @HiveField(36)  @JsonKey(name: "zero_pad") final int? zeroPad;
 @HiveField(37)  @JsonKey(name: "logo_in_pos") final bool? logoInPos;
 @HiveField(38)  @JsonKey(name: "pdf_header") final String? pdfHeader;
 @HiveField(39)  @JsonKey(name: "pdf_footer") final String? pdfFooter;
 @HiveField(40)  ProfileResultModel(
      {this.id,
      this.userId,
      this.aboutCompany,
      this.mobile,
      this.location,
      this.companyLogo,
      this.companyName,
      this.companyNameArabic,
      this.companyAddress1,
      this.companyAddress1Arabic,
      this.companyAddress2,
      this.companyAddress2Arabic,
      this.companyCrn,
      this.companyVat,
      this.accountName,
      this.accountNameArabic,
      this.bankName,
      this.bankNameArabic,
      this.accountNumber,
      this.iban,
      this.bankBranch,
      this.bankBranchArabic,
      this.web,
      this.mail,
      this.tele,
      this.saleStartNumber,
      this.quotationStartNumber,
      this.purchaseStartNumber,
      this.deliveryStartNumber,
      this.companySalePrefix,
      this.companyPurchaseOrderPrefix,
      this.companyPurchasePrefix,
      this.companyPurchaseReturnPrefix,
      this.companyQuotationPrefix,
      this.companySaleReturnPrefix,
      this.companyDeliveryNotePrefix,
      this.zeroPad,
      this.logoInPos,
      this.pdfHeader,
      this.pdfFooter,
      });


  factory ProfileResultModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResultModelToJson(this);
}
