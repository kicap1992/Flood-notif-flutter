import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/themes/app_text.dart';
import './log_data_view_model.dart';

class LogDataView extends StatelessWidget {
  const LogDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LogDataViewModel>.reactive(
      viewModelBuilder: () => LogDataViewModel(),
      onViewModelReady: (LogDataViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        LogDataViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: model.isBusy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: Text(
                                'Waktu',
                                style: boldTextStyle,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                'Status',
                                style: boldTextStyle,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                'Ketinggian Air',
                                style: boldTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...model.dataList.map((data) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  data.createdAt!,
                                  style: regularTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  data.status! == 0
                                      ? "Air Dalam \nTahap Normal"
                                      : data.status! == 1
                                          ? "Air Dalam \nTahap Warning"
                                          : "Air Dalam \nTahap Danger",
                                  style: regularTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(
                                  data.status == 2
                                      ? "${data.waterHeight!} m"
                                      : "-",
                                  style: regularTextStyle,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
