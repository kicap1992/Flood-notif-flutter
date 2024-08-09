import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text.dart';
import './monitoring_view_model.dart';

class MonitoringView extends StatelessWidget {
  const MonitoringView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MonitoringViewModel>.reactive(
      viewModelBuilder: () => MonitoringViewModel(),
      onViewModelReady: (MonitoringViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        MonitoringViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Notif Banjir",
                    style: boldTextStyle.copyWith(fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  const Image(
                    image: AssetImage("assets/logo.png"),
                    width: 125,
                    height: 125,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TheText(
                          title: 'Status',
                          text: model.socketIoClient.status,
                        ),
                        TheText(
                          title: 'Warning Level',
                          text: model.socketIoClient.status == "..."
                              ? "No Data"
                              : model.socketIoClient.warningLevel == 0
                                  ? 'Air Belum Mencapai Tahap Warning'
                                  : "Air Mencapai Tahap Warning",
                        ),
                        TheText(
                          title: 'Danger Level',
                          text: model.socketIoClient.status == "..."
                              ? "No Data"
                              : model.socketIoClient.dangerLevel == 0
                                  ? 'Air Belum Mencapai Tahap Danger'
                                  : "Air Mencapai Tahap Danger",
                        ),
                        TheText(
                          title: 'Water Height',
                          text: model.socketIoClient.dangerLevel == 1
                              ? '${model.socketIoClient.waterHeight} m'
                              : '-',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TheText extends StatelessWidget {
  const TheText({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          text: '$title : ',
          style: boldTextStyle,
          children: [
            TextSpan(
              text: text,
              style: regularTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
