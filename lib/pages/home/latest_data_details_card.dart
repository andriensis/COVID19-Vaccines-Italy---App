import 'package:covid19_vaccines_app/model/latest_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

final formatDecimalNumber = NumberFormat.decimalPattern();

class LatestDataDetailsCard extends StatelessWidget {
  final LatestDataDetail details;
  final ValueChanged<String> onTap;

  LatestDataDetailsCard({this.details, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {this.onTap(details.area)},
      child: Card(
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        details.areaVerbose,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      )),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).administration_percentage,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(":"),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(formatDecimalNumber
                            .format(details.administrationPercentage)),
                      ),
                      Text("%")
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).doses_delivered,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(":"),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                            formatDecimalNumber.format(details.dosesDelivered)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).doses_administered,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(":"),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(formatDecimalNumber
                            .format(details.dosesAdministered)),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}
