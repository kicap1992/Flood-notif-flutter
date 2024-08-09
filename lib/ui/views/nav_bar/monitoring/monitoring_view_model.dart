import '../../../../app/app.logger.dart';
import '../../../../app/core/custom_base_view_model.dart';

class MonitoringViewModel extends CustomBaseViewModel {
  final log = getLogger('MonitoringViewModel');

  Future<void> init() async {
    while (true) {
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
