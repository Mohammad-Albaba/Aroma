import 'package:apex2/layout/cubit/cubit.dart';
import 'package:apex2/layout/cubit/states.dart';
import 'package:apex2/models/CategoryModel.dart';
import 'package:apex2/modules/product_details.dart';
import 'package:apex2/shared/components/components.dart';
import 'package:apex2/shared/components/constant.dart';
import 'package:apex2/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int isClicked = 0;

  void changeState(isClicked){
    if(isClicked == 0){
      setState(() {
        isClicked = 0;
      });
    }else if(isClicked == 1){
      setState(() {
        isClicked = 1;
      });
    }else if(isClicked == 2){
      setState(() {
        isClicked = 2;
      });
    };

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApexCubit.get(context).getCategories(id: 2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApexCubit, ApexStates>(
      listener: (context, state){
       if (state is ApexLoadingCategoriesState){
          ApexCubit.get(context).getCategories(id: 2);
        };
      },
      builder: (context, state)  {
        return ConditionalBuilder(
          condition: categoriesModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 50,
              shadowColor: endAppbarColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              flexibleSpace: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[endAppbarColor, startAppbarColor]),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 90,
                    child: SvgPicture.asset(
                      'assets/images/ell.svg',
                      width: 80,
                      height: 80,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 200,
                    child: SvgPicture.asset(
                      'assets/images/ell.svg',
                      width: 32,
                      height: 32,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),


              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              centerTitle: true,
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/notifi.svg',
                    width: 16,
                    height: 20,
                  ),
                  SizedBox(width: 16.0,),
                  SvgPicture.asset(
                    'assets/images/whatsapp.svg',
                    width: 18,
                    height: 18,
                  ),
                  Spacer(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Image(
                        height: 24,
                        width: 66,
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.search,size: 24,),
                ],
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildCategoryItem(),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 8.0,
                          ),
                          itemCount: 10
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => changeState(isClicked = 0),
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  color: isClicked == 0? primColor : Colors.grey,
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                ),
                                child: Text(
                                  'packages'.tr(),
                                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                                    color: Colors.white,),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 17.0,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => changeState(isClicked = 1),
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  color:isClicked == 1? primColor : Colors.grey,
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                ),
                                child: Text(
                                  'devices'.tr(),
                                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                                    color: Colors.white,),
                                ),
                              ),

                            ),
                          ),
                          SizedBox(
                            width: 17.0,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => changeState(isClicked = 2),
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  color:isClicked == 2? primColor : Colors.grey,
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                ),
                                child: Text(
                                  'apps'.tr(),
                                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                                    color: Colors.white,),
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/product.svg'),
                        SizedBox(width: 5,),
                        Text(
                          'AromaProducts'.tr(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'viewAll'.tr(),
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 1 / 1.6,
                      children: List.generate(
                        categoriesModel.data.products.length,
                            (index) => buildGridProduct(categoriesModel.data.products[index],),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ),
          fallback:  (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCategoryItem() =>  ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Image(
      image: NetworkImage(
          'https://img.freepik.com/free-photo/cabinet-tv-modern-living-room-with-armchair-lamp-table-flower-plant-concrete-wall-background-3d-rendering_41470-3344.jpg?w=1380'),
      height: 132.0,
      width: 335.0,
      fit: BoxFit.cover,
    ),
  );

  Widget buildGridProduct(Products model,) => InkWell(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),topRight: Radius.circular(8.0)),
                  child: Image(
                    image: NetworkImage(
                         '${model.images[0].image}',
                    ),
                    width: double.infinity,
                    height: 168.0,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  onPressed: ()
                  {
                    // ShopCubit.get(context).changeFavorites(model.id);
                    // print(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor:Colors.grey[300],
                    child: Icon(
                      Icons.favorite,
                      size: 14.0,
                      color: Colors.grey[100],
                    ),
                  ),
                ),
              ]
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.title}'.tr(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Text(
                  '${model.subTitle}'.tr(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8.0,
                    height: 1.3,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Text(
                      '${model.price}\$',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: endAppbarColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.shopping_cart_outlined,color: backgroundContainerColor,)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: (){
      ApexCubit.get(context).getProduct(id: model.id);
      navigateTo(context, ProductDetails());
    },
  );
}
