import 'package:covid19_vaccines_app/model/administration_data.dart';
import 'package:covid19_vaccines_app/service/webservice.dart';
import 'package:covid19_vaccines_app/utils/view_model_state.dart';
import 'package:flutter/material.dart';

class RegionDetailsViewModel extends ChangeNotifier {
  ViewModelState state = ViewModelState.Loading;
  List<AdministrationData> administrationData;

  Future<void> fetchAdministrationData(String area) async {
    this.administrationData = await Webservice().fetchAdministrationData(area);
    this.administrationData = this.administrationData.reversed.toList();
    this.state = ViewModelState.Success;
    notifyListeners();
  }
}
