import 'package:apex2/layout/cubit/cubit.dart';
import 'package:apex2/layout/cubit/states.dart';
import 'package:apex2/models/CartModel.dart';
import 'package:apex2/shared/components/constant.dart';
import 'package:apex2/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isChecked = false;
  bool isChecked2 = false;
  int weight = 1;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return primColor;
    }
    return primColor;
  }
  Color getColor2(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApexCubit.get(context).getCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApexCubit,ApexStates>(
      listener: (context, state){},
      builder: (context,state){
        return ConditionalBuilder(
            condition: cartModel != null,
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
                      width: 17,
                      height: 21,
                    ),
                    SizedBox(width: 16.0,),
                    SvgPicture.asset(
                      'assets/images/audio.svg',
                      width: 18,
                      height: 22,
                    ),
                    Spacer(),
                    Text(
                      'selectAll'.tr(),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Checkbox(
                      shape: CircleBorder(),
                      // checkColor: primColor,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      activeColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool value) {
                        setState(() {
                          isChecked = value;
                          isChecked2 = isChecked;
                        });
                      },
                      side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ConditionalBuilder(
                  condition: cartModel.data.cartProducts.length > 0,
                  builder: (context){
                    return  ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildGridProduct(cartModel.data.cartProducts[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 16.0,
                      ),
                      itemCount: cartModel.data.cartProducts.length,
                    );
                  },
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          fallback:  (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildGridProduct(CartProducts cartProducts) => Padding(
    padding: const EdgeInsets.only(left: 20,right: 20),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Checkbox(
              shape: CircleBorder(),
               // checkColor: primColor,
              fillColor: MaterialStateProperty.resolveWith(getColor2),
              checkColor: primColor,
              value: isChecked2,
              onChanged: (bool value) {
                setState(() {
                  isChecked2 = value;
                });
              },
              side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: hintTextColor)),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image(
                image: NetworkImage(
                  '${cartProducts.productImage}',
                ),
                width: 96,
                height: 96.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cartProducts.productName}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${cartProducts.price}ر.س  ',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: primColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 24,
                          width: 24,
                          child: FloatingActionButton(
                            backgroundColor: ContainerCartColor,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            onPressed: (){
                              setState(() {
                                weight--;
                              });
                            },
                            heroTag: 'weight-',
                            mini: true,
                            child: Icon(
                              Icons.remove,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Text(
                          '$weight',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 24,
                          width: 24,
                          child: FloatingActionButton(
                            backgroundColor: ContainerCartColor,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            onPressed: (){
                              setState(() {
                                weight++;
                              });
                            },
                            heroTag: 'weight+',
                            mini: true,
                            child: Icon(
                              Icons.add,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Icon(Icons.close,size: 10,color: Colors.black,),
            ),
          ],
        ),
      ),
    ),
  );

}
