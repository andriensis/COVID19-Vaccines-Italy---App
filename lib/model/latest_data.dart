import 'package:covid19_vaccines_app/utils/globals.dart';
import 'package:intl/intl.dart';

class LatestData {
  final LatestDataSummary summary;
  final List<LatestDataDetail> details;

  LatestData({this.summary, this.details});

  factory LatestData.fromJson(Map<String, dynamic> json) {
    final Iterable details = json["details"];
    return LatestData(
        summary: LatestDataSummary.fromJson(json["summary"]),
        details: details
            .map((detail) => LatestDataDetail.fromJson(detail))
            .toList());
  }

  int get totalCount {
    if (summary == null || details == null) return 0;
    return details.length + 1;
  }
}

class LatestDataSummary {
  final String area;
  final int dosesAdministered;
  final int dosesDelivered;
  final double administrationPercentage;
  final DateTime lastUpdate;

  LatestDataSummary(
      {this.area,
      this.dosesAdministered,
      this.dosesDelivered,
      this.administrationPercentage,
      this.lastUpdate});

  factory LatestDataSummary.fromJson(Map<String, dynamic> json) {
    return LatestDataSummary(
        area: "ITA",
        dosesAdministered: json["doses_administered"],
        dosesDelivered: json["doses_delivered"],
        administrationPercentage: json["administration_percentage"],
        lastUpdate: DateTime.parse(json["last_update"]));
  }

  String get formattedLastUpdate {
    return DateFormat('dd/MM/yyyy HH:mm').format(lastUpdate);
  }
}

class LatestDataDetail {
  final int index;
  final String area;
  final int dosesAdministered;
  final int dosesDelivered;
  final double administrationPercentage;
  final DateTime lastUpdate;

  LatestDataDetail(
      {this.index,
      this.area,
      this.dosesAdministered,
      this.dosesDelivered,
      this.administrationPercentage,
      this.lastUpdate});

  factory LatestDataDetail.fromJson(Map<String, dynamic> json) {
    return LatestDataDetail(
        index: json["index"],
        area: json["area"],
        dosesAdministered: json["doses_administered"],
        dosesDelivered: json["doses_delivered"],
        administrationPercentage:
            (json["administration_percentage"]).toDouble(),
        lastUpdate: DateTime.parse(json["last_update"]));
  }

  String get areaVerbose {
    return Globals.getAreaName(area);
  }
}
