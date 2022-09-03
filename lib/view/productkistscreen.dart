import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proplus/constants/constants.dart';
import 'package:proplus/model/productlistmodel.dart';
import 'package:proplus/view/productviewpage.dart';
import 'package:proplus/viewmodel/productlistviewmodel.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  @override
  Widget build(BuildContext context) {
    List<String> catergories = [
      'Living Room',
      'Kitchen & Dining',
      'Bedroom',
      'office'
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ProductListViewModel>(builder: (context, provider, child) {
        return
        FutureBuilder<List<ProductListModel>>(
          future: provider.fetchProductData(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return const Center(
                  child: Text('An error occured'),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    customAppbar(),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, left: 8.w, right: 8.w),
                      child: SizedBox(
                          height: 20.0, child: _horizontalList(catergories)),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8.sp),
                        child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: dataSnapshot.data!.length,
                            mainAxisSpacing: 12,
                            physics: const ScrollPhysics(),
                            crossAxisSpacing: 12,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductViewPage(id:dataSnapshot.data![i].id.toString())),
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.sp)),
                                  child: Container(
                                    height: i % 2 == 0 ? 230.h : 150.h,
                                    margin: EdgeInsets.only(
                                        top: 5.h,
                                        bottom: 35.h,
                                        left: 5.w,
                                        right: 5.w),
                                    child: imageView(dataSnapshot.data![i]),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) {
                              return const StaggeredTile.fit(1);
                            }),
                      ),
                    )
                  ],
                );
              }
            }
          },
        );
      }),



    );
  }

  Widget imageView(ProductListModel productList) {
    return Column(
      children: [
        Flexible(
          flex: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              productList.image.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: ListTile(
                    title: Text(productList.title.toString()),
                    subtitle: Text(productList.category.toString()),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 10.w),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: ColorConstants.productButtonColor,
                        size: 22.sp,
                      ),
                      Text(
                        productList.price.toString(),
                        style: GoogleFonts.lato(
                            fontSize: 9.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget customAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Text("Discover",
              style: GoogleFonts.lato(
                  fontSize: 22.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: Badge(
            badgeContent: const Text(
              '3',
              style: TextStyle(color: Colors.white),
            ),
            badgeColor: ColorConstants.productButtonColor,
            child: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
        )
      ],
    );
  }

  ListView _horizontalList(List data) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        data.length,
        (i) => Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Container(
            width: 150,
            color: ColorConstants.horizondalBarColor,
            alignment: Alignment.center,
            child: Text(
              data[i],
              style: GoogleFonts.lato(
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
