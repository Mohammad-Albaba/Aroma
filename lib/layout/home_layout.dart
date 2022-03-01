import 'package:apex2/layout/cubit/cubit.dart';
import 'package:apex2/layout/cubit/states.dart';
import 'package:apex2/shared/styles/colors.dart';
import 'package:apex2/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';


class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApexCubit,ApexStates>(
      listener: (context, state){},
      builder: (context, state) {
        var cubit = ApexCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          // bottomNavigationBar: ConvexAppBar(
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 5,
            unselectedFontSize:3,
            showUnselectedLabels: false,
           showSelectedLabels: false,
           backgroundColor: Colors.white,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                Icons.more_horiz,
                color: iconColor,
              ),
                label: 'Business',
                activeIcon: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SvgPicture.asset('assets/images/n.svg',width: 52,height: 52,),
                    Positioned(child: Icon(Icons.more_horiz,color: Colors.white,size: 30,)),
                  ],
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite,color: iconColor,),label: 'Business',
                activeIcon: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SvgPicture.asset('assets/images/n.svg',width: 52,height: 52,),
                    Positioned(child: Icon(Icons.favorite,color: Colors.white,size: 30,)),
                  ],
                ),
              ),
              BottomNavigationBarItem(icon: Icon(Icons.home,color: iconColor,),label: 'Business',
                activeIcon: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SvgPicture.asset('assets/images/n.svg',width: 52,height: 52,),
                    Positioned(child: Icon(Icons.home,color: Colors.white,size: 30,)),
                  ],
                ),),
              BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/menus.svg'),label: 'Business',
                activeIcon: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SvgPicture.asset('assets/images/n.svg',width: 52,height: 52,),
                    Positioned(child: SvgPicture.asset('assets/images/menus.svg',color: Colors.white,height: 30,width: 30,)),
                  ],
                ),),
              BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/cart.svg',),label: 'Business',
                activeIcon: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SvgPicture.asset('assets/images/n.svg',width: 52,height: 52,),
                    Positioned(child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 30,)),
                  ],
                ),),
            ],
          ),
        );
      },
    );
  }
}
