import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/themes/app_text.dart';
import './splash_screen_view_model.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.nonReactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onViewModelReady: (SplashScreenViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        SplashScreenViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          // backgroundColor: mainColor,
          body: Column(
            children: [
              const SizedBox(),
              Expanded(
                child: Center(
                  // show the logo.png
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Image(
                        image: AssetImage("assets/logo.png"),
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Notif Banjir",
                        style: boldTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Text(
                "Made with Flutter and Passion By Kk",
                textAlign: TextAlign.center,
                style: regularTextStyle,
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}
