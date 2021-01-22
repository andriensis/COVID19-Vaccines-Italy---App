import 'package:covid19_vaccines_app/model/latest_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

final formatDecimalNumber = NumberFormat.decimalPattern();

class LatestDataSummaryCard extends StatelessWidget {
  final LatestDataSummary details;
  final ValueChanged<String> onTap;

  LatestDataSummaryCard({this.details, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {this.onTap(details.area)},
      child: Card(
          color: Color.fromRGBO(23, 50, 77, 1),
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        AppLocalizations.of(context).italy,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 20),
                      )),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).administration_percentage,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        ":",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          formatDecimalNumber
                              .format(details.administrationPercentage),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        "%",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).doses_delivered,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        ":",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          formatDecimalNumber.format(details.dosesDelivered),
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).doses_administered,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        ":",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          formatDecimalNumber.format(details.dosesAdministered),
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}
