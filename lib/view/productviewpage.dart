import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proplus/constants/constants.dart';
import 'package:proplus/model/particularproductmodel.dart';
import 'package:proplus/model/productlistmodel.dart';
import 'package:proplus/notification.dart';
import 'package:proplus/viewmodel/productlistviewmodel.dart';

class ProductViewPage extends StatefulWidget {
  const ProductViewPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  ProductListViewModel productListViewModel = ProductListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ParticularProductModel>(
          future: productListViewModel.fetchSelectedProductData(widget.id),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customAppbar(dataSnapshot.data!.category.toString()),
                    Flexible(
                        flex: 5,
                        child: imageView(
                          dataSnapshot.data!.image.toString(),
                        )),
                    Flexible(
                        flex: 1,
                        child: ratingBar(
                            dataSnapshot.data!.rating!.rate!.toDouble())),
                    Flexible(
                        flex: 3,
                        child: titleWidget(dataSnapshot.data!.title.toString(),
                            dataSnapshot.data!.description.toString())),
                    Flexible(
                        flex: 2,
                        child: footerBar(
                            dataSnapshot.data!.price.toString(),
                            dataSnapshot.data!.title.toString(),
                            dataSnapshot.data!.image.toString()))
                  ],
                );
              }
            }
          }),
    );
  }

  Widget customAppbar(String appBarName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 15.w, top: 5.h),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Text(appBarName,
            style: GoogleFonts.lato(
                fontSize: 22.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget imageView(String img) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Container(
              height: 230.h,
              width: MediaQuery.of(context).size.width / 1,
              margin: EdgeInsets.only(
                  top: 5.h, bottom: 35.h, left: 5.w, right: 5.w),
              child: Column(children: [
                Flexible(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ])),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: ColorConstants.productButtonColor,
                radius: 15.sp,
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
              SizedBox(
                width: 13.h,
              ),
              CircleAvatar(
                backgroundColor: ColorConstants.productButtonColor,
                radius: 15.sp,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget ratingBar(double rating) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 5.w),
          child: Text("Rating",
              style: GoogleFonts.lato(
                fontSize: 12.sp,
                color: Colors.black,
              )),
        ),
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 18.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ],
    );
  }

  Widget titleWidget(String title, String subTitle) {
    return ListTile(
      title: Text(title,
          style: GoogleFonts.lato(
            fontSize: 18.sp,
            color: Colors.black,
          )),
      subtitle: Text(subTitle),
    );
  }

  Widget footerBar(String price, String title, String image) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 13.w),
          child: Text(price,
              style: GoogleFonts.lato(
                  fontSize: 22.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 90.sp, right: 30.sp, top: 10.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 5,
            height: 30.h,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(1.sp)),
            child: Center(
              child: Text("Add to Cart",
                  style: GoogleFonts.lato(
                    fontSize: 10.sp,
                    color: Colors.black,
                  )),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: InkWell(
            onTap: () {
              NotificationLocal.localNotification(title, price, image);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5,
              height: 30.h,
              decoration: BoxDecoration(
                  color: ColorConstants.productButtonColor,
                  borderRadius: BorderRadius.circular(1.sp)),
              child: Center(
                child: Text("Buy Now",
                    style: GoogleFonts.lato(
                      fontSize: 10.sp,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
