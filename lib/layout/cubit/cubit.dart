
import 'package:apex2/layout/cubit/states.dart';
import 'package:apex2/models/CartModel.dart';
import 'package:apex2/models/CategoryModel.dart';
import 'package:apex2/models/ProductModel.dart';
import 'package:apex2/modules/cart_screeen.dart';
import 'package:apex2/modules/favorite_screen.dart';
import 'package:apex2/modules/home_screen.dart';
import 'package:apex2/modules/grid_screen.dart';
import 'package:apex2/modules/more_screen.dart';
import 'package:apex2/shared/components/components.dart';
import 'package:apex2/shared/components/constant.dart';
import 'package:apex2/shared/network/end_points.dart';
import 'package:apex2/shared/network/local/cache_helper.dart';
import 'package:apex2/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit.dart';
class ApexCubit extends Cubit<ApexStates> {
  ApexCubit() : super(ApexInitialState());

  static ApexCubit get(context) => BlocProvider.of(context);

  int currentIndex = 2;

  List<Widget> screens = [
    MoreScreen(),
    FavoriteScreen(),
    HomeScreen(),
    GridScreen(),
    CartScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ApexChangeBottomNavState());
  }

  void getCategories({
  @required int id,
})async{
    emit(ApexLoadingCategoriesState());
    DioHelper.getData(
      url: '$GET_CATEGORIES?category_id=$id',
      token: CacheHelper.getData(key: 'token'),
    ).then((value)async{
      categoriesModel =await CategoryModel.fromJson(value.data);
      print('${categoriesModel.data} + categoriesModel');
      token =await CacheHelper.getData(key: 'token');
      emit(ApexSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ApexErrorCategoriesState(
        error.toString(),
      ));
    });
  }

  void getProduct({
  @required int id,
})async{
    DioHelper.getData(
      url: '$GET_PRODUCT?product_id=${id}',
      token: CacheHelper.getData(key: 'token'),
    ).then((value)async{
      productModel =await ProductModel.fromJson(value.data);
      print('${productModel.data} + productModel');
      token =await CacheHelper.getData(key: 'token');
      emit(ApexSuccessProductState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ApexErrorProductState(
        error.toString(),
      ));
    });
  }

  void addCart({
    @required int id,
    // @required int qty,
  })async{
    DioHelper.postData(
      url: '$POST_ADDCART?product_id=${id}&qty=1',
      token: CacheHelper.getData(key: 'token'),
    ).then((value)async{
      cartModel =await CartModel.fromJson(value.data);
      cartModel.data.cartProducts.length++;
      if(cartModel.status == true){
        showToast(text: 'تمت الإضافة', state: ToastStates.SUCCESS);
      }
      print('${cartModel.data} + cartModel');
      emit(ApexSuccessAddCartState());
    }).catchError((error)
    {
      showToast(text: 'كمية المنتج غير متوفرة', state: ToastStates.ERROR);
      print(error.toString());
      emit(ApexErrorAddCartState(
        error.toString(),
      ));
    });
  }



  void getCart()async{
    DioHelper.getData(
      url: GET_CART,
      token: CacheHelper.getData(key: 'token'),
    ).then((value)async{
      cartModel =await CartModel.fromJson(value.data);
      token =await CacheHelper.getData(key: 'token');
      emit(ApexSuccessGetCartState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ApexErrorGetCartState(
        error.toString(),
      ));
    });
  }


}