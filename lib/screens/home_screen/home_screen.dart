import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:kenz/constants/asset_manager.dart';
import 'package:kenz/constants/color_manger.dart';
import 'package:kenz/constants/font_manager.dart';
import 'package:kenz/constants/values_manger.dart';
import 'package:kenz/screens/widget/Circular_progress_indicator_widget.dart';
import 'package:kenz/screens/widget/rounded_button_widget.dart';

import '../../constants/constants.dart';
import '../../constants/style_manager.dart';
import '../../core/notifier/category_notifier/category_notifier.dart';
import '../../core/notifier/checkinout.dart';
import '../../core/notifier/data/pos_post_notifier.dart';
import '../../core/notifier/data/product_list_notifier.dart';
import '../../models/pos_sales_model/sales_model.dart';
import '../../models/product_model/product_content_model.dart';
import '../../provider/checken_in_notifier.dart';
import '../../provider/draft_notifier.dart';
import '../../provider/general_notifier.dart';
import '../../provider/invoice_printing_notifier.dart';
import '../../provider/pos_sales_notifier.dart';
import '../../provider/product_management_notifier.dart';
import '../../provider/setup_settings_notifier.dart';
import '../widget/payment_switch_widget.dart';
import '../widget/quick_menu_widget.dart';
import '../widget/square_tile_widget.dart';
import '../widget/text_field_widget.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productManagementNotifier =
        context.watch<ProductManagementNotifier>();
    final checkInOutNotifier = context.read<CheckInOutNotifier>();
    final categoryNotifier = context.read<CategoryNotifier>();

    final isLoading = useState<bool>(false);
    final balance = useState<double>(0.00);
    ValueNotifier axisCount = useState<int>(5);
    ValueNotifier multiPayRows = useState<int>(1);
    ValueNotifier isParcel = useState<bool>(false);
    ValueNotifier<List<String>> selectedPaymentType =
        useState<List<String>>([]);
    ValueNotifier paymentTypes =
        useState<List<String>>(["Cash", "Card", "Credit"]);
    final searchTextController = useTextEditingController();
    final cashController = useTextEditingController();
    final multiPayCashController = useState<List<TextEditingController>>([]);
    ValueNotifier<Map<int, TextEditingController>> qtyControllers =
        useState<Map<int, TextEditingController>>({});
    final formKey = useMemoized(() => GlobalKey<FormState>());

    double screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    if (screenWidth >= 1600) {
      axisCount.value = 6;
    } else if (screenWidth > 1400) {
      axisCount.value = 5;
    } else if (screenWidth > 1200) {
      axisCount.value = 4;
    } else if (screenWidth > 1000) {
      axisCount.value = 3;
    } else {
      axisCount.value = 2;
    }

    Future<void> printing({bool? isRecentTransaction =false, String? orderNo, String? invoiceNo}) async {
      isLoading.value = true;
      await context.read<InvoicePrintingNotifier>().printInvoice(context: context, isRecentTransaction: isRecentTransaction ?? false, orderID: orderNo ?? "",invoiceID: invoiceNo ?? "").then((value) {
        if (context.read<InvoicePrintingNotifier>().getIsDone) {
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showDialog(
            context: context,
            builder: (context) {
              return showAwesomeDialogue(
                  content: "Cannot Print Now, Please Try Again Later",
                  title: "Warning",
              );
            },
          );
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p12),
          child: Consumer<ProductManagementNotifier>(
              builder: (context, snapshot, _) {
            return Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppPadding.p20),
                            child: Container(
                              height: 120.h,
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p16,
                                    vertical: AppPadding.p12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Categories",
                                      style: getBoldStyle(
                                          color: ColorManager.primaryLight,
                                          fontSize: AppSize.s20),
                                    ),
                                    SizedBox(height: 10),
                                    Consumer<CategoryNotifier>(
                                      builder: (context, snapshotCategory,_) {
                                        return snapshotCategory.getIsLoading ? CircularProgressIndicatorWidget() :Expanded(
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (snapshotCategory.getCategory?.result?.length ?? 0 ),
                                            itemBuilder: (context, index) {
                                              final dataCategory = snapshotCategory.getCategory?.result?[index];
                                              print("ddddddd ${snapshotCategory.getCategory?.result?.length}");
                                              if (index == 0) {
                                                return  InkWell(
                                                  onTap: (){
                                                    context.read<ProductListNotifier>().search(id: 0000000000, accessAll: true);
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(
                                                        horizontal: AppPadding.p8,
                                                        vertical: AppPadding.p6),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(12),
                                                      color: ColorManager.white,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          offset: Offset(0.0, 1.0),
                                                          blurRadius: 6.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Container(
                                                      margin:
                                                      const EdgeInsets.symmetric(
                                                          horizontal:
                                                          AppPadding.p8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          // Container(
                                                          //   height: 40,
                                                          //   width: 40,
                                                          //   margin:
                                                          //       EdgeInsets.symmetric(
                                                          //     horizontal: AppPadding.p8,
                                                          //     vertical: AppPadding.p6,
                                                          //   ),
                                                          //   decoration: BoxDecoration(
                                                          //     color: ColorManager.white,
                                                          //     borderRadius:
                                                          //         BorderRadius.circular(
                                                          //             8),
                                                          //     image: DecorationImage(
                                                          //       image: NetworkImage(
                                                          //         "https://a.cdn-hotels.com/gdcs/production0/d1513/35c1c89e-408c-4449-9abe-f109068f40c0.jpg?impolicy=fcrop&w=800&h=533&q=medium",
                                                          //       ),
                                                          //       fit: BoxFit.cover,
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                                                            child: Text(
                                                              "All",
                                                              style: getSemiBoldStyle(
                                                                  color: ColorManager
                                                                      .primaryLight,
                                                                  fontSize: FontSize.s16),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return InkWell(
                                                onTap: (){
                                                  context.read<ProductListNotifier>().search(id: dataCategory?.id ?? 9999, accessAll: false);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(
                                                      horizontal: AppPadding.p8,
                                                      vertical: AppPadding.p6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                    color: ColorManager.white,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        offset: Offset(0.0, 1.0),
                                                        blurRadius: 6.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                            horizontal:
                                                                AppPadding.p8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        // Container(
                                                        //   height: 40,
                                                        //   width: 40,
                                                        //   margin:
                                                        //       EdgeInsets.symmetric(
                                                        //     horizontal: AppPadding.p8,
                                                        //     vertical: AppPadding.p6,
                                                        //   ),
                                                        //   decoration: BoxDecoration(
                                                        //     color: ColorManager.white,
                                                        //     borderRadius:
                                                        //         BorderRadius.circular(
                                                        //             8),
                                                        //     image: DecorationImage(
                                                        //       image: NetworkImage(
                                                        //         "https://a.cdn-hotels.com/gdcs/production0/d1513/35c1c89e-408c-4449-9abe-f109068f40c0.jpg?impolicy=fcrop&w=800&h=533&q=medium",
                                                        //       ),
                                                        //       fit: BoxFit.cover,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                                                          child: Text(
                                                            dataCategory?.name ?? "",
                                                            style: getSemiBoldStyle(
                                                                color: ColorManager
                                                                    .primaryLight,
                                                                fontSize: FontSize.s16),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Consumer<ProductListNotifier>(
                                  builder: (context, productSnapshot, _) {
                                return productSnapshot.getIsLoading
                                    ? const CircularProgressIndicatorWidget()
                                    : (productSnapshot.getProductListData?.isNotEmpty ?? false) &&
                                          productSnapshot.getProductListData !=null
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: AppPadding.p16,
                                                vertical: AppPadding.p12),
                                            child:Column(
                                              children: [
                                                Expanded(
                                                  child: GridView.count(
                                                      crossAxisCount: axisCount.value,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      children: List.generate(productSnapshot.getProductListData?.length ?? 0, (index) {
                                                        ProductContentModel? product = productSnapshot.getProductListData![index];
                                                        return SquareTileWidget(
                                                          icon: Icons.shopping_bag_rounded,
                                                          onTap: () async {
                                                            productManagementNotifier.productSummaryManagement(
                                                                product: product,
                                                                isDelete: false,
                                                                context:  context,isDraftConverting: false); // Pass the category type as identifier
                                                          },
                                                          isSelected: productManagementNotifier.isSelected(product), // Pass the category type as identifier
                                                          name: product.name ?? "",
                                                          nameArabic:
                                                          product.name_arabic ?? "",
                                                          price:
                                                          product.price.toString(),
                                                        );
                                                      })

                                                  ),
                                                ),
                                                kSizedBox100
                                              ],
                                            )
                                          )
                                        :  Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(child: Image.asset(ImageAssets.notFound,height: 250.h,width: 250.w,),),
                                      Text("No Record Found",style: getSemiBoldStyle(color: ColorManager.grey4,fontSize: FontSize.s16),)
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            height: 140.h,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: AppPadding.p20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p16,
                                      vertical: AppPadding.p12),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Quick Menu",
                                              style: getBoldStyle(
                                                  color:
                                                      ColorManager.primaryLight,
                                                  fontSize: AppSize.s20),
                                            ),
                                            Consumer2<PosPostNotifier,CheckOutINIDNotifier>(
                                              builder: (context, snapshotPost,snapshotCheckout,_) {
                                                return Row(
                                                  children: [
                                                   snapshotPost.getIsLoading || snapshotCheckout.getIsLoading ? CupertinoActivityIndicator(color: ColorManager.primaryLight,):InkWell(
                                                      child: Icon(Icons.logout),
                                                      onTap: () async {
                                                        isLoading.value = true;

                                                        await snapshotPost.getPostList(context: context).then((value) async {
                                                          if(value =="OK"){
                                                            await snapshotCheckout.checkinOut(context: context, type: "checkout").then((value) async {
                                                              if(value == "OK"){
                                                                await checkInOutNotifier.setCheckIn(checkIN: false, context: context);
                                                                await checkInOutNotifier.retrieveCheckIn(context: context);
                                                              }
                                                            });

                                                          }
                                                        });


                                                        isLoading.value = false;

                                                        snapshot.cleanAfterSale();
                                                      },
                                                    ),
                                                    kSizedW5,
                                                    snapshotPost.getIsLoading? CupertinoActivityIndicator(color: ColorManager.primaryLight,):  InkWell(
                                                      child: Icon(
                                                          Icons.sync),
                                                      onTap: () async {
                                                        isLoading.value = true;
                                                        await context.read<PosPostNotifier>().getPostList(context: context);
                                                        isLoading.value = false;
                                                      },
                                                    )
                                                  ],
                                                );
                                              }
                                            )
                                          ],
                                        ),
                                        kSizedBox10,
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Expanded(
                                            //     child: QuickMenuWidget(
                                            //   icon: Icons.person_2_rounded,
                                            //       isSelected: true,
                                            //
                                            //       height: 50,
                                            //   width: 50,
                                            //   onTap: () {},
                                            // )),
                                            // // kSizedW10,
                                            //
                                            // Expanded(
                                            //     child: QuickMenuWidget(
                                            //   icon: Icons.edit_rounded,
                                            //       isSelected: true,
                                            //
                                            //       height: 50,
                                            //   width: 50,
                                            //   onTap: () {},
                                            // )),
                                            // // kSizedW10,
                                            //
                                            // Expanded(
                                            //     child: QuickMenuWidget(
                                            //   icon: Icons.add_circle_rounded,
                                            //       isSelected: true,
                                            //
                                            //       height: 50,
                                            //   width: 50,
                                            //   onTap: () {},
                                            // )),
                                            // // kSizedW10,
                                            Expanded(
                                                child: QuickMenuWidget(
                                              icon: Icons.request_page,
                                                  isSelected: true,

                                                  height: 50,
                                              width: 50,
                                              onTap: () {},
                                            )),
                                            // kSizedW10,
                                            Expanded(
                                                child: QuickMenuWidget(
                                              icon: Icons.description_rounded,
                                                  isSelected: true,

                                                  height: 50,
                                              width: 50,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                        builder: (context,stateSetterSetModalState) {
                                                      return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12.0),
                                                        ),
                                                        child: Container(
                                                          height: 600.h,
                                                          padding: EdgeInsets.all(AppPadding.p22),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            color: ColorManager.white,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .description_rounded,
                                                                      color: ColorManager
                                                                          .primaryLight),
                                                                  kSizedW2,
                                                                  Text(
                                                                    "Draft List",
                                                                    style: getBoldStyle(
                                                                        color: ColorManager
                                                                            .primaryLight,
                                                                        fontSize:
                                                                            AppSize.s18),
                                                                  ),
                                                                ],
                                                              ),
                                                              kSizedBox10,
                                                              Text(
                                                                "Select a Draft To Covert into Sale",
                                                                style: getSemiBoldStyle(
                                                                    color: ColorManager
                                                                        .black,
                                                                    fontSize:
                                                                        AppSize
                                                                            .s16),
                                                              ),
                                                              kSizedBox5,
                                                              SizedBox(
                                                                height: 450.h,
                                                                child: Consumer<
                                                                        DraftNotifier>(
                                                                    builder:
                                                                        (context,
                                                                            snapshotDraft,
                                                                            _) {
                                                                  return GridView
                                                                      .count(
                                                                          crossAxisCount: axisCount.value +
                                                                              2,
                                                                          crossAxisSpacing:
                                                                              10,
                                                                          mainAxisSpacing:
                                                                              10,
                                                                          children: List.generate(
                                                                              snapshotDraft.getDraftSales?.length ?? 0,
                                                                              (index) {
                                                                            PosSalesModel draftData =snapshotDraft.getDraftSales?[index] ?? [];

                                                                            return InkWell(
                                                                              onTap: () {
                                                                                productManagementNotifier.cleanAfterSale();

                                                                                draftData.items?.forEach((element) {
                                                                                  ProductContentModel product = ProductContentModel(
                                                                                      price: double.parse(element.gross_total ?? "0.00") + double.parse(element.vat_amount ?? "0.00"),
                                                                                      total: double.parse(element.total_amount ?? "0.00"),
                                                                                      name: element.name, name_arabic: element.name_arabic,
                                                                                      vat: double.parse(element.vat_amount ?? "0.00"),
                                                                                      user_id: draftData.user_id,
                                                                                      priceWithoutVat: double.parse(element.gross_total ?? "0.00"),
                                                                                      added: null, discounted_price: null, discount_type: null, discount: null,
                                                                                      qty: int.parse(element.quantity ?? "0"),
                                                                                      category_id: null, id: int.parse(element.id ?? "0"));
                                                                                  productManagementNotifier.productSummaryManagement(
                                                                                      product:product,
                                                                                      isDelete: false,
                                                                                      context: context,
                                                                                      isDraftConverting: true);
                                                                                });
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
                                                                                padding: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(12.r),
                                                                                  color: ColorManager.white,
                                                                                  boxShadow: const [
                                                                                    BoxShadow(
                                                                                      color: Colors.grey,
                                                                                      offset: Offset(0.0, 1.0),
                                                                                      blurRadius: 6.0,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                child: Center(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(draftData.invoice_id!, textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                      kSizedBox2,
                                                                                      Text(dateFormatter.format(DateTime.parse(draftData.created!)), textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                      kSizedBox2,
                                                                                      Text(draftData.customerName ?? "", textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                      kSizedBox2,
                                                                                      Text("Total Items: ${draftData.items?.length ?? "0"} ", textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                      kSizedBox10,
                                                                                      Text("Total: ${draftData.total ?? "0"} ${context.read<SetupSettingsNotifier>().getCurrency.toString()}", textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }));
                                                                }),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                  },
                                                );
                                              },
                                            )),
                                            Expanded(
                                                child: QuickMenuWidget(
                                              icon: Icons.receipt_long_rounded,
                                                  isSelected: true,

                                                  height: 50,
                                              width: 50,
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                            builder: (context,stateSetterSetModalState) {
                                                              return Dialog(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                ),
                                                                child: Container(
                                                                  height: 600.h,
                                                                  padding: EdgeInsets.all(AppPadding.p22),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(12),
                                                                    color: ColorManager.white,
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                              Icons
                                                                                  .description_rounded,
                                                                              color: ColorManager
                                                                                  .primaryLight),
                                                                          kSizedW2,
                                                                          Text(
                                                                            "Recent Sales List",
                                                                            style: getBoldStyle(
                                                                                color: ColorManager
                                                                                    .primaryLight,
                                                                                fontSize:
                                                                                AppSize.s18),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      kSizedBox10,
                                                                      Text(
                                                                        "Select a Sale To print",
                                                                        style: getSemiBoldStyle(
                                                                            color: ColorManager
                                                                                .black,
                                                                            fontSize:
                                                                            AppSize
                                                                                .s16),
                                                                      ),
                                                                      kSizedBox5,
                                                                      SizedBox(
                                                                        height: 450.h,
                                                                        child: Consumer<PosSaleNotifier>(
                                                                            builder: (context, snapshotRecent, _) {
                                                                              return GridView.count(crossAxisCount: axisCount.value + 2,
                                                                                  crossAxisSpacing: 10,
                                                                                  mainAxisSpacing: 10,
                                                                                  children: List.generate(
                                                                                      (snapshotRecent.getRecentSales?.length ?? 0) >= 10 ? 10 :(snapshotRecent.getRecentSales?.length ?? 0), (index) {
                                                                                        PosSalesModel? recentData = snapshotRecent.getRecentSales?.reversed.toList()[index] ;
                                                                                        return InkWell(
                                                                                          onTap: () async {
                                                                                            productManagementNotifier.cleanAfterSale();
                                                                                            recentData?.items?.forEach((element) {
                                                                                              ProductContentModel product = ProductContentModel(
                                                                                                  price: double.parse(element.gross_total ?? "0.00") + double.parse(element.vat_amount ?? "0.00"),
                                                                                                  total: double.parse(element.total_amount ?? "0.00"),
                                                                                                  name: element.name, name_arabic: element.name_arabic,
                                                                                                  vat: double.parse(element.vat_amount ?? "0.00"),
                                                                                                  user_id: recentData.user_id,
                                                                                                  priceWithoutVat: double.parse(element.gross_total ?? "0.00"),
                                                                                                  added: null, discounted_price: null, discount_type: null, discount: null,
                                                                                                  qty: int.parse(element.quantity ?? "0"),
                                                                                                  category_id: null, id: int.parse(element.id ?? "0"));
                                                                                              productManagementNotifier.productSummaryManagement(
                                                                                                  product:product,
                                                                                                  isDelete: false,
                                                                                                  context: context,
                                                                                                  isDraftConverting: true);
                                                                                            });
                                                                                            Navigator.pop(context);
                                                                                            await printing(isRecentTransaction: true,orderNo: recentData?.order_id ?? "",invoiceNo: recentData?.invoice_id ??"");

                                                                                          },
                                                                                          child: Container(
                                                                                            margin: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
                                                                                            padding: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(12.r),
                                                                                              color: ColorManager.white,
                                                                                              boxShadow: const [
                                                                                                BoxShadow(
                                                                                                  color: Colors.grey,
                                                                                                  offset: Offset(0.0, 1.0),
                                                                                                  blurRadius: 6.0,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            child: Center(
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Text(recentData?.invoice_id ?? "", textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                                  kSizedBox2,
                                                                                                  Text(dateFormatter.format(DateTime.parse(recentData?.created ?? DateTime.now().toString())), textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                                  kSizedBox2,
                                                                                                  Text(recentData?.customerName ?? "", textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                                  kSizedBox2,
                                                                                                  Text("Total Items: ${recentData?.items?.length ?? "0"} ", textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                                  kSizedBox10,
                                                                                                  Text("Total: ${(recentData?.total ?? "0")} ${context.read<SetupSettingsNotifier>().getCurrency.toString()}", textAlign: TextAlign.center, style: getBoldStyle(color: ColorManager.primaryLight, fontSize: FontSize.s12)),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      }));
                                                                            }),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                    );
                                                  },
                                            ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppPadding.p16,
                                      vertical: AppPadding.p12),
                                  child: Container(
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Deliver Type",
                                            style: getBoldStyle(
                                                color:
                                                    ColorManager.primaryLight,
                                                fontSize: AppSize.s20),
                                          ),
                                        ),
                                        kSizedBox10,
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              QuickMenuWidget(
                                                icon: Icons
                                                    .delivery_dining_rounded,
                                                width: 50,
                                                height: 50,
                                                isSelected: isParcel.value,
                                                onTap: () {
                                                  isParcel.value = true;
                                                  snapshot.isParcel(true);
                                                },
                                              ),
                                              kSizedW10,
                                              QuickMenuWidget(
                                                icon: Icons.restaurant,
                                                width: 50,
                                                height: 50,
                                                isSelected: isParcel.value == false ? true:false,
                                                onTap: () {
                                                  isParcel.value = false;
                                                  snapshot.isParcel(false);
                                                },
                                              ),
                                              // kSizedW10,
                                              // QuickMenuWidget(
                                              //   icon: Icons
                                              //       .delivery_dining_rounded,
                                              //   width: 50,
                                              //   height: 50,
                                              //   onTap: () {},
                                              // )
                                            ],
                                          ),
                                        ),
                                        kSizedBox2,
                                        kDivider,
                                        kSizedBox2,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Summary",
                                              style: getBoldStyle(
                                                color:
                                                    ColorManager.primaryLight,
                                                fontSize: AppSize.s20,
                                              ),
                                            ),
                                            Text(
                                              "Invoice No:${"${(snapshot.getInvoicePrefix)} ${formatString(snapshot.getInvoiceNo.toString())}"} || Order No:${snapshot.getInvoiceNo}",
                                              style: getBoldStyle(
                                                color:
                                                    ColorManager.primaryLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // CupertinoSearchTextField(
                                        //   controller: searchTextController,
                                        //   backgroundColor:
                                        //       ColorManager.filledColor,
                                        //   prefixIcon: Icon(
                                        //     Icons.search_rounded,
                                        //     color: ColorManager.primaryLight,
                                        //   ),
                                        //   onChanged: (query) {},
                                        // ),
                                        kSizedBox10,
                                        Table(
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: {
                                            0: FlexColumnWidth(1.5),
                                            1: FlexColumnWidth(1),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(1),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Text(
                                                "Name",
                                                style: getSemiBoldStyle(
                                                  color:
                                                      ColorManager.primaryLight,
                                                  fontSize: FontSize.s14,
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  "QTY",
                                                  style: getSemiBoldStyle(
                                                    color: ColorManager
                                                        .primaryLight,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  "Price",
                                                  style: getSemiBoldStyle(
                                                    color: ColorManager
                                                        .primaryLight,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  "Sub total",
                                                  style: getSemiBoldStyle(
                                                    color: ColorManager
                                                        .primaryLight,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            ...List.generate(
                                                snapshot.getSelectedIndices.length, (index) {
                                              if (snapshot.getUpdateDisabledBool == true) {
                                                qtyControllers.value[index] = TextEditingController(text: snapshot.getSelectedIndices[index].qty.toString());
                                              }
                                              return TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: AppPadding.p8),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                                  .getSelectedIndices[
                                                                      index]
                                                                  .name_arabic ??
                                                              "",
                                                          style:
                                                              getSemiBoldStyle(
                                                            color: ColorManager
                                                                .primaryLight,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize:
                                                                FontSize.s14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          snapshot
                                                              .getSelectedIndices[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                          style:
                                                              getSemiBoldStyle(
                                                            color: ColorManager
                                                                .grey4,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize:
                                                                FontSize.s12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical:
                                                            AppPadding.p8),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            onTap: () {
                                                              snapshot.productSummaryManagement(product: snapshot.getSelectedIndices[index],isDelete: false,context: context,isDraftConverting: false);
                                                              print(qtyControllers.value[index]?.text);
                                                            },
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: Icon(
                                                                Icons.add,
                                                                color: ColorManager.green,
                                                                weight: 1200,
                                                                size: FontSize.s30,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        kSizedW2,
                                                        Expanded(
                                                          flex: 3,
                                                          child: Focus(
                                                            onFocusChange: ((value) {
                                                              if (value == false) {
                                                                if ((qtyControllers.value[index]?.text.isEmpty ?? true) || qtyControllers.value[index]?.text == null) {
                                                                  qtyControllers.value[index]?.text = "1";
                                                                }
                                                              }
                                                            }),
                                                            child: TextField(
                                                              controller: qtyControllers.value[index],
                                                              // autofocus: true,
                                                              onChanged: (value) {
                                                                if (value.isNotEmpty) {
                                                                  snapshot.editProductFromSummary(snapshot.getSelectedIndices[index], value);
                                                                }
                                                              },

                                                              decoration: InputDecoration(
                                                                border: InputBorder.none,
                                                                fillColor: ColorManager.filledColor,
                                                                filled: true,
                                                                contentPadding: EdgeInsets.symmetric(
                                                                        vertical: 12.0,
                                                                        horizontal: 16.0),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide.none,
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide.none,
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                              ),
                                                              style: getSemiBoldStyle(
                                                                  color: ColorManager
                                                                      .primaryLight),

                                                              // textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            onTap: () {
                                                               snapshot.productSummaryManagement(product:snapshot.getSelectedIndices[index],
                                                                  isDelete:true,
                                                                  context: context, isDraftConverting: false);
                                                            },
                                                            onLongPress: () {
                                                              snapshot
                                                                  .deleteProductFromSummary(
                                                                snapshot.getSelectedIndices[
                                                                    index],
                                                              );
                                                            },
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                  Icons.remove,
                                                                  color:
                                                                      ColorManager
                                                                          .red,
                                                                  weight: 1200,
                                                                  size: FontSize
                                                                      .s30),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical:
                                                            AppPadding.p8),
                                                    child: Text(
                                                      snapshot
                                                          .getSelectedIndices[
                                                              index]
                                                          .price
                                                          .toString(),
                                                      style: getSemiBoldStyle(
                                                        color: ColorManager
                                                            .primaryLight,
                                                        fontSize: FontSize.s14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical:
                                                            AppPadding.p8),
                                                    child: Text(
                                                      ((snapshot
                                                                      .getSelectedIndices[
                                                                          index]
                                                                      .price ??
                                                                  1) *
                                                              int.parse(qtyControllers
                                                                      .value[
                                                                          index]
                                                                      ?.text ??
                                                                  "0"))
                                                          .toString(),
                                                      style: getSemiBoldStyle(
                                                        color: ColorManager
                                                            .primaryLight,
                                                        fontSize: FontSize.s14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]);
                                            }),

                                            // Add more rows as needed
                                            TableRow(children: [
                                              kSizedBox100,
                                              kSizedBox100,
                                              kSizedBox100,
                                              kSizedBox100,
                                            ]),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ///----------------------------------SALES SWITCH---------------------------------------///
                Positioned(
                    bottom: MediaQuery.of(context).viewPadding.bottom,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      color: ColorManager.white,
                      // padding: const EdgeInsets.only(bottom: AppPadding.p16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20,
                            vertical: AppPadding.p12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ///----------------------------------DRAFT SWITCH---------------------------------------///
                                PaymentTypeWidget(
                                  title: "Draft",
                                  icon: Icons.save_as_rounded,
                                  onTap: () async {
                                    if (snapshot
                                        .getSelectedIndices.isNotEmpty) {
                                      isLoading.value = true;
                                      await context
                                          .read<DraftNotifier>()
                                          .setDraftInvoice(context: context)
                                          .then((value) {
                                        if (value == "OK") {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return showAwesomeDialogue(
                                                  title: "Success",
                                                  content:
                                                      "Added to Draft Successfully",
                                                  icon: Icons
                                                      .check_circle_outline_rounded,
                                                  color: ColorManager.green);
                                            },
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return showAwesomeDialogue(
                                                title: "Failed",
                                                content:
                                                    "Could not add to draft \n Please Try Again.",
                                              );
                                            },
                                          );
                                        }
                                      });
                                      isLoading.value = false;
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return showAwesomeDialogue(
                                              title: "Warning",
                                              content:
                                                  "Please Select at least one product");
                                        },
                                      );
                                    }
                                  },
                                ),
                                kSizedW10,

                                ///----------------------------------CASH SWITCH---------------------------------------///
                                PaymentTypeWidget(
                                  title: "cash",
                                  icon: Icons.payments,
                                  onTap: () {
                                    if (snapshot
                                        .getSelectedIndices.isNotEmpty) {
                                      snapshot.setPaymentTypeString("Cash");

                                      cashController.clear();
                                      balance.value = 0.00;
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (context,
                                                  stateSetterSetModalState) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                width: 150.w,
                                                padding: EdgeInsets.all(
                                                    AppPadding.p22),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: ColorManager.white,
                                                ),
                                                child: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.payments,
                                                              color: ColorManager
                                                                  .primaryLight),
                                                          kSizedW2,
                                                          Text(
                                                            "Customer Payment",
                                                            style: getBoldStyle(
                                                                color: ColorManager
                                                                    .primaryLight,
                                                                fontSize:
                                                                    AppSize
                                                                        .s18),
                                                          ),
                                                        ],
                                                      ),
                                                      kSizedBox10,
                                                      Text(
                                                        "Please Enter amount given by the customer below",
                                                        style: getSemiBoldStyle(
                                                            color: ColorManager
                                                                .black,
                                                            fontSize:
                                                                AppSize.s16),
                                                      ),
                                                      kSizedBox5,
                                                      TextFormFieldCustom(
                                                        controller:
                                                            cashController,
                                                        hintName: "Enter Cash",
                                                        autoFocus: true,
                                                        onFieldSubmitted:
                                                            (value) async {
                                                          if ((formKey
                                                                  .currentState
                                                                  ?.validate() ??
                                                              false)) {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        onChanged: (value) {
                                                          if (value
                                                              .isNotEmpty) {
                                                            stateSetterSetModalState(
                                                                () {
                                                              balance
                                                                  .value = double
                                                                      .parse(
                                                                          value) -
                                                                  snapshot
                                                                      .getTotal;
                                                              snapshot.setCashAndBalance(
                                                                  cash: double.parse(
                                                                      cashController
                                                                          .text),
                                                                  balance: balance
                                                                      .value);
                                                            });
                                                          } else {
                                                            showSnackBar(
                                                                context:
                                                                    context,
                                                                text:
                                                                    "Please enter a value");
                                                          }
                                                        },
                                                        inputType: TextInputType
                                                            .number,
                                                      ),
                                                      kSizedBox20,
                                                      Text(
                                                        "Balance: ${balance.value}",
                                                        style: getBoldStyle(
                                                            color: ColorManager
                                                                .black,
                                                            fontSize:
                                                                AppSize.s18),
                                                      ),
                                                      kSizedBox20,
                                                      Align(
                                                        child: SizedBox(
                                                          width: 50.w,
                                                          child: CustomButton(
                                                            onTap: () async {
                                                              if ((formKey
                                                                      .currentState
                                                                      ?.validate() ??
                                                                  false)) {
                                                                Navigator.pop(
                                                                    context);
                                                                if (!balance
                                                                    .value
                                                                    .isNegative) {
                                                                  snapshot.setPaymentType(
                                                                      type: PaymentType
                                                                          .CASH,
                                                                      method: PaymentType
                                                                          .CASH,
                                                                      price: cashController
                                                                          .text);
                                                                  await printing();
                                                                } else {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return showAwesomeDialogue(
                                                                          title:
                                                                              "Warning",
                                                                          content:
                                                                              "Paid Amount is less than the payable amount.");
                                                                    },
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            title: "Checkout",
                                                            width: 35.w,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return showAwesomeDialogue(
                                              title: "Warning",
                                              content:
                                                  "Please Select at least one product");
                                        },
                                      );
                                    }
                                  },
                                ),
                                kSizedW10,

                                ///----------------------------------CARD SWITCH---------------------------------------///

                                PaymentTypeWidget(
                                  title: "Card",
                                  icon: Icons.credit_card,
                                  onTap: () async {
                                    if (snapshot
                                        .getSelectedIndices.isNotEmpty) {
                                      snapshot.setPaymentTypeString("Card");

                                      isLoading.value = true;
                                      snapshot.setPaymentType(
                                          type: PaymentType.CARD,
                                          method: PaymentType.CARD,
                                          price: snapshot.getTotal.toString());
                                      await printing();
                                      isLoading.value = false;
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return showAwesomeDialogue(
                                              title: "Warning",
                                              content:
                                                  "Please Select at least one product");
                                        },
                                      );
                                    }
                                  },
                                ),
                                kSizedW10,

                                ///----------------------------------Express SWITCH---------------------------------------///
                                PaymentTypeWidget(
                                  title: "Express",
                                  icon: Icons.bolt_rounded,
                                  onTap: () async {
                                    if (snapshot
                                        .getSelectedIndices.isNotEmpty) {
                                      snapshot.setPaymentTypeString("Express");
                                      isLoading.value = true;
                                      snapshot.setPaymentType(
                                          type: PaymentType.EXPRESS,
                                          method: PaymentType.CASH,
                                          price: snapshot.getTotal.toString());

                                      await printing();
                                      isLoading.value = false;
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return showAwesomeDialogue(
                                              title: "Warning",
                                              content:
                                                  "Please Select at least one product");
                                        },
                                      );
                                    }
                                  },
                                ),
                                kSizedW10,

                                ///----------------------------------MULTI SWITCH---------------------------------------///
                                PaymentTypeWidget(
                                  title: "Multi Pay",
                                  icon: Icons.local_atm_rounded,
                                  onTap: () {
                                    if (snapshot
                                        .getSelectedIndices.isNotEmpty) {
                                      snapshot.setPaymentTypeString("Multi");

                                      multiPayRows.value = 1;
                                      balance.value = 0.00;
                                      selectedPaymentType.value = [];
                                      multiPayCashController.value = [];
                                      List<double> totalAmount = [];
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (context,
                                                  stateSetterSetModalState) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                width: 150.w,
                                                padding: EdgeInsets.all(
                                                    AppPadding.p22),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: ColorManager.white,
                                                ),
                                                child: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.payments,
                                                              color: ColorManager
                                                                  .primaryLight),
                                                          Text(
                                                            "Multiple pay",
                                                            style: getBoldStyle(
                                                                color: ColorManager
                                                                    .primaryLight,
                                                                fontSize:
                                                                    AppSize
                                                                        .s18),
                                                          ),
                                                        ],
                                                      ),
                                                      kSizedBox10,
                                                      ...List.generate(
                                                        multiPayRows.value,
                                                        (indexOfMultiPay) {
                                                          multiPayCashController
                                                              .value
                                                              .add(
                                                                  TextEditingController());
                                                          if (selectedPaymentType
                                                              .value.isEmpty) {
                                                            selectedPaymentType
                                                                .value
                                                                .add("Cash");
                                                          } else if (!selectedPaymentType
                                                              .value
                                                              .contains(
                                                                  "Card")) {
                                                            selectedPaymentType
                                                                .value
                                                                .add("Card");
                                                          } else {
                                                            selectedPaymentType
                                                                .value
                                                                .add("Credit");
                                                          }
                                                          return Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        TextFormFieldCustom(
                                                                      controller:
                                                                          multiPayCashController
                                                                              .value[indexOfMultiPay],
                                                                      hintName:
                                                                          "Amount",
                                                                      autoFocus:
                                                                          true,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        if ((formKey.currentState?.validate() ??
                                                                            false)) {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      },
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter
                                                                            .digitsOnly,
                                                                      ],
                                                                      onChanged:
                                                                          (value) {
                                                                        if (value
                                                                            .isNotEmpty) {
                                                                          stateSetterSetModalState(
                                                                              () {
                                                                            totalAmount.add(0);
                                                                            totalAmount[indexOfMultiPay] =
                                                                                double.parse(value);
                                                                            double
                                                                                sum =
                                                                                totalAmount.fold(0, (previous, current) => previous + current);
                                                                            balance.value =
                                                                                sum - snapshot.getTotal;
                                                                            snapshot.setCashAndBalance(
                                                                                cash: sum,
                                                                                balance: balance.value);
                                                                            snapshot.setPaymentType(
                                                                                type: PaymentType.MULTI,
                                                                                method: selectedPaymentType.value[indexOfMultiPay] == "Cash"
                                                                                    ? PaymentType.CASH
                                                                                    : selectedPaymentType.value[indexOfMultiPay] == "Card"
                                                                                        ? PaymentType.CARD
                                                                                        : selectedPaymentType.value[indexOfMultiPay] == "Credit"
                                                                                            ? PaymentType.CREDIT
                                                                                            : PaymentType.NONE,
                                                                                price: totalAmount[indexOfMultiPay].toString());
                                                                          });
                                                                        } else {
                                                                          showSnackBar(
                                                                              context: context,
                                                                              text: "Please enter a value");
                                                                        }
                                                                      },
                                                                      inputType:
                                                                          TextInputType
                                                                              .number,
                                                                    ),
                                                                  ),
                                                                  kSizedW2,
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            AppPadding
                                                                                .p12,
                                                                        vertical:
                                                                            AppPadding.p14),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                8.0)),
                                                                        border: Border.all(
                                                                            color: ColorManager
                                                                                .primaryLight),
                                                                        color: ColorManager
                                                                            .white),
                                                                    child:
                                                                        DropdownButtonHideUnderline(
                                                                      child: DropdownButton<
                                                                          String>(
                                                                        hint:
                                                                            Text(
                                                                          "Select Type",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              getBoldStyle(
                                                                            color:
                                                                                ColorManager.primaryLight,
                                                                            fontSize:
                                                                                FontSize.s13,
                                                                          ),
                                                                        ),
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_drop_down_circle_outlined,
                                                                          color:
                                                                              ColorManager.primaryLight,
                                                                        ),
                                                                        iconSize:
                                                                            FontSize.s22,
                                                                        style:
                                                                            getBoldStyle(
                                                                          color:
                                                                              ColorManager.black,
                                                                          fontSize:
                                                                              FontSize.s16,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(22),
                                                                        isDense:
                                                                            true,
                                                                        isExpanded:
                                                                            true,
                                                                        value: selectedPaymentType
                                                                            .value[indexOfMultiPay],
                                                                        onChanged:
                                                                            (String?
                                                                                newValue) {
                                                                          stateSetterSetModalState(
                                                                              () {
                                                                            if (!(selectedPaymentType.value.contains(newValue))) {
                                                                              selectedPaymentType.value[indexOfMultiPay] = newValue ?? "Cash";
                                                                            }
                                                                          });
                                                                        },
                                                                        items: paymentTypes
                                                                            .value
                                                                            .map<DropdownMenuItem<String>>((String
                                                                                provider) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                provider,
                                                                            onTap:
                                                                                () async {},
                                                                            child:
                                                                                Text(
                                                                              provider,
                                                                              style: getSemiBoldStyle(
                                                                                color: ColorManager.primaryLight,
                                                                                fontSize: FontSize.s14,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                      ),
                                                                    ),
                                                                  )),
                                                                ],
                                                              ),
                                                              kSizedBox10,
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                      kSizedBox10,
                                                      ElevatedButton(
                                                        onPressed:
                                                            multiPayRows.value <
                                                                    3
                                                                ? () {
                                                                    stateSetterSetModalState(
                                                                        () {
                                                                      multiPayRows
                                                                              .value =
                                                                          multiPayRows.value +
                                                                              1;
                                                                    });
                                                                  }
                                                                : null,
                                                        child: Text(
                                                          "Add Row",
                                                          style: getSemiBoldStyle(
                                                              color:
                                                                  ColorManager
                                                                      .white,
                                                              fontSize:
                                                                  FontSize.s16),
                                                        ),
                                                      ),
                                                      kSizedBox20,
                                                      Text(
                                                        "Balance: ${balance.value}",
                                                        style: getBoldStyle(
                                                            color: ColorManager
                                                                .black,
                                                            fontSize:
                                                                AppSize.s18),
                                                      ),
                                                      kSizedBox20,
                                                      Center(
                                                        child: SizedBox(
                                                          width: 50.w,
                                                          child: CustomButton(
                                                            onTap: () async {
                                                              if ((formKey
                                                                      .currentState
                                                                      ?.validate() ??
                                                                  false)) {
                                                                Navigator.pop(
                                                                    context);
                                                                if (!balance
                                                                    .value
                                                                    .isNegative) {
                                                                  await printing();
                                                                } else {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return showAwesomeDialogue(
                                                                          title:
                                                                              "Warning",
                                                                          content:
                                                                              "Paid Amount is less than the payable amount.");
                                                                    },
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            title: "Checkout",
                                                            width: 35.w,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return showAwesomeDialogue(
                                              title: "Warning",
                                              content:
                                                  "Please Select at least one product");
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),

                            ///----------------------------------SALES SWITCH---------------------------------------///
                            axisCount.value <= 4
                                ? Row(
                                    children: [
                                      Column(
                                        children: [
                                          _buildRichText("Sub Total",
                                              snapshot.getSubTotal.toString()),
                                          kSizedBox4,
                                          _buildRichText("Discount", "0.00"),
                                        ],
                                      ),
                                      kSizedW15,
                                      Column(
                                        children: [
                                          _buildRichText(
                                              "Tax 15% (VAT Included)",
                                              snapshot.getTaxAmount.toString()),
                                          kSizedBox,
                                          RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Total: ",
                                                  style: getSemiBoldStyle(
                                                      color: ColorManager.red,
                                                      fontSize: FontSize.s20),
                                                ),
                                                TextSpan(
                                                  text: snapshot.getTotal
                                                      .toStringAsFixed(2),
                                                  style: getSemiBoldStyle(
                                                      color: ColorManager.black,
                                                      fontSize: FontSize.s22),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      _buildRichText("Sub Total",
                                          snapshot.getSubTotal.toString()),
                                      kSizedW5,
                                      _buildRichText("Discount", "0.00"),
                                      kSizedW5,
                                      _buildRichText("Tax 15% (VAT Included)",
                                          snapshot.getTaxAmount.toString()),
                                      kSizedW5,
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Total: ",
                                              style: getSemiBoldStyle(
                                                  color: ColorManager.red,
                                                  fontSize: FontSize.s20),
                                            ),
                                            TextSpan(
                                              text: snapshot.getTotal
                                                  .toStringAsFixed(2),
                                              style: getSemiBoldStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s22),
                                            ),
                                          ],
                                        ),
                                      ),
                                      kSizedW5,
                                    ],
                                  )
                          ],
                        ),
                      ),
                    )),
                isLoading.value
                    ? Positioned.fill(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              color: const Color(0x66ffffff),
                              child: const CircularProgressIndicatorWidget(),
                            )))
                    : kSizedBox
              ],
            );
          }),
        ),
      ),
    );
  }

  RichText _buildRichText(String label, String value) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: getSemiBoldStyle(
                color: ColorManager.grey, fontSize: FontSize.s14),
          ),
          TextSpan(
            text: value,
            style: getSemiBoldStyle(
                color: ColorManager.black, fontSize: FontSize.s16),
          ),
        ],
      ),
    );
  }
}
