import 'package:flood_app/model/data_model.dart';

import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';

class LogDataViewModel extends CustomBaseViewModel {
  final log = getLogger('LogDataViewModel');
  List<DataModel> dataList = [];

  Future<void> init() async {
    await getData(null);
  }

  getData(String? date) async {
    setBusy(true);
    try {
      // wait 2 seconds
      await Future.delayed(const Duration(seconds: 2));
      var response = await httpService.get("");
      var data = response.data;
      data = data['data'];
      log.i(data);
      for (var i = 0; i < data.length; i++) {
        dataList.add(DataModel.fromJson(data[i]));
      }
      notifyListeners();
    } catch (e) {
      log.e(e);
    } finally {
      setBusy(false);
    }
  }
}
