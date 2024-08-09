import '../app/app.locator.dart';
import '../services/other_function.dart';

class DataModel {
  final _myFunction = locator<OtherFunction>();
  int? no;
  String? waterHeight;
  int? status;
  String? createdAt;

  DataModel({this.no, this.waterHeight, this.status, this.createdAt});

  DataModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    waterHeight = json['water_height'];
    status = json['status'];
    createdAt = _myFunction.formatDateString2(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no'] = no;
    data['water_height'] = waterHeight;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
