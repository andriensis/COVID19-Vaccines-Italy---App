import 'package:covid19_vaccines_app/model/latest_data.dart';
import 'package:covid19_vaccines_app/service/webservice.dart';
import 'package:covid19_vaccines_app/utils/view_model_state.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  ViewModelState state = ViewModelState.Loading;
  LatestData latestData = LatestData();

  Future<void> fetchLatestData() async {
    final result = await Webservice().fetchLatestData();
    this.latestData =
        LatestData(summary: result.summary, details: result.details);
    this.state = ViewModelState.Success;
    notifyListeners();
  }

  refreshLatestDataDetails(List<LatestDataDetail> latestDataDetailList) async {
    LatestData sortedData = LatestData(
        summary: this.latestData.summary, details: latestDataDetailList);
    this.latestData = sortedData;
    notifyListeners();
  }

  sortByAdministrationPercentage({bool descending = true}) {
    List<LatestDataDetail> latestDataDetailList = this.latestData.details;
    latestDataDetailList.sort((a, b) {
      if (descending) {
        return b.administrationPercentage.compareTo(a.administrationPercentage);
      } else {
        return a.administrationPercentage.compareTo(b.administrationPercentage);
      }
    });

    refreshLatestDataDetails(latestDataDetailList);
  }

  sortByDeliveredDoses({bool descending = true}) {
    List<LatestDataDetail> latestDataDetailList = this.latestData.details;
    latestDataDetailList.sort((a, b) {
      if (descending) {
        return b.dosesDelivered.compareTo(a.dosesDelivered);
      } else {
        return a.dosesDelivered.compareTo(b.dosesDelivered);
      }
    });

    refreshLatestDataDetails(latestDataDetailList);
  }

  sortByAdministeredDoses({bool descending = true}) {
    List<LatestDataDetail> latestDataDetailList = this.latestData.details;
    latestDataDetailList.sort((a, b) {
      if (descending) {
        return b.dosesAdministered.compareTo(a.dosesAdministered);
      } else {
        return a.dosesAdministered.compareTo(b.dosesAdministered);
      }
    });

    refreshLatestDataDetails(latestDataDetailList);
  }
}
