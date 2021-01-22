import 'package:intl/intl.dart';

class AdministrationData {
  final String area;
  final DateTime administrationDate;
  final int total;

  final int male;
  final int female;
  final int healthOperators;
  final int notHealthOperators;
  final int retirementHomeGuests;
  final int ageOver80;
  final int firstDose;
  final int secondDose;

  AdministrationData(
      {this.total,
      this.male,
      this.female,
      this.healthOperators,
      this.notHealthOperators,
      this.retirementHomeGuests,
      this.ageOver80,
      this.firstDose,
      this.secondDose,
      this.area,
      this.administrationDate});

  factory AdministrationData.fromJson(Map<String, dynamic> json) {
    return AdministrationData(
        area: json["area"],
        administrationDate: DateTime.parse(json["administration_date"]),
        total: json["total"],
        male: json["male"],
        female: json["female"],
        healthOperators: json["category_health_operators"],
        notHealthOperators: json["category_not_health_operators"],
        ageOver80: json["category_age_over_80"],
        firstDose: json["first_dose"],
        secondDose: json["second_dose"]);
  }

  String get formattedAdministrationDate {
    return DateFormat('dd/MM/yyyy').format(administrationDate);
  }
}
