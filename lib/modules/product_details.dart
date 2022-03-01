
import 'package:apex2/layout/cubit/cubit.dart';
import 'package:apex2/layout/cubit/states.dart';
import 'package:apex2/models/CategoryModel.dart';
import 'package:apex2/shared/components/components.dart';
import 'package:apex2/shared/components/constant.dart';
import 'package:apex2/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_html/flutter_html.dart';


class ProductDetails extends StatefulWidget {

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  double rating = 3.5;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApexCubit,ApexStates>(
      listener: (context,state){},
      builder: (context, state){
        var html = '${productModel.data.description}';
        return  ConditionalBuilder(
          condition: productModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16)),
                        child: Image(
                          image: NetworkImage(
                           '${productModel.data.images[0].image}',
                          ),
                          height: 266.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: CircleAvatar(
                                  backgroundColor: ContainerColor,
                                  radius: 15.0,
                                  child: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
                                ),
                                onTap: (){
                                  Navigator.pop(context);
                                },
                              ),
                              Spacer(),
                              InkWell(
                                child: CircleAvatar(
                                  backgroundColor: ContainerColor,
                                  radius: 15.0,
                                  child: Icon(Icons.share,color: Colors.black,),
                                ),
                                onTap: () async {
                                 await Share.share('hello how are you');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${productModel.data.title}',
                                style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  fontSize: 18.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'شراء التطبيق لمدة سنه',
                                style: Theme.of(context).textTheme.caption.copyWith(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: ()
                          {
                            // ShopCubit.get(context).changeFavorites(model.id);
                            // print(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: primColor,
                            child: Icon(
                              Icons.favorite,
                              size: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  myDivider(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text(
                          ' ${productModel.data.price}ر.س ',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: primColor,
                          ),
                        ),
                        Spacer(),
                        SmoothStarRating(
                            allowHalfRating: true,
                            rating: rating,
                            onRated: (rating) => setState(() => this.rating = rating),
                            starCount: 5,
                            size: 12.0,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_border,
                            color: Colors.yellow,
                            borderColor: ContainerColor,
                            spacing:0.0
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '(50 تقييم)',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: hintTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  myDivider(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6,right:20 ,left: 20,top: 16),
                    child: Text(
                      'الوصف',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                    child: Html(
                      padding: EdgeInsets.zero,
                      defaultTextStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      data: html,

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            backgroundColor: ContainerColor,
                            radius: 22.0,
                            child: Icon(Icons.add_shopping_cart_outlined,color: primColor,),
                          ),
                          onTap: (){
                            ApexCubit.get(context).addCart(id: productModel.data.id,);
                          }

                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.0),
                              color: primColor,
                            ),
                            height: 44,
                            child: MaterialButton(
                              onPressed: (){},
                              child: Text(
                                'buyNow'.tr(),
                                style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

          ),
          fallback:  (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
