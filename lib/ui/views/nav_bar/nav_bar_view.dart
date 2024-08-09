import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../app/app.router.dart';
import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_text.dart';
import './nav_bar_view_model.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavBarViewModel>.reactive(
      viewModelBuilder: () => NavBarViewModel(),
      onViewModelReady: (NavBarViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        NavBarViewModel model,
        Widget? child,
      ) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Text(
                model.bottomNavBarList[model.currentIndex]['name'],
                style: boldTextStyle,
              ),
            ),
            body: ExtendedNavigator(
              navigatorKey: StackedService.nestedNavigationKey(3),
              router: NavBarViewRouter(),
              initialRoute: NavBarViewRoutes.monitoringView,
            ),
            bottomNavigationBar: StylishBottomBar(
              items: [
                for (var item in model.bottomNavBarList)
                  BottomBarItem(
                    icon: Icon(item['icon'],
                        color: model.currentIndex ==
                                model.bottomNavBarList.indexOf(item)
                            ? sixthGrey
                            : backgroundColor),
                    title: Text(
                      item['name'],
                      style: regularTextStyle.copyWith(
                        color: model.currentIndex ==
                                model.bottomNavBarList.indexOf(item)
                            ? sixthGrey
                            : mainGrey,
                      ),
                    ),
                    backgroundColor: model.currentIndex ==
                            model.bottomNavBarList.indexOf(item)
                        ? fontColor
                        : mainGrey,
                  ),
              ],
              currentIndex: model.currentIndex,
              hasNotch: true,
              backgroundColor: mainColor,
              onTap: (value) {
                model.handleNavigation(value);
              },
              option: BubbleBarOptions(
                  barStyle: BubbleBarStyle.horizontal,
                  bubbleFillStyle: BubbleFillStyle.fill,
                  opacity: 0.3),
            ),
          ),
        );
      },
    );
  }
}
