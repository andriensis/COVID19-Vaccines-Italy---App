import 'package:covid19_vaccines_app/model/administration_data.dart';
import 'package:covid19_vaccines_app/pages/region_details/region_details_view_model.dart';
import 'package:covid19_vaccines_app/utils/globals.dart';
import 'package:covid19_vaccines_app/utils/view_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

final formatDecimalNumber = NumberFormat.decimalPattern();

class RegionDetailsPage extends StatefulWidget {
  final String regionArea;

  const RegionDetailsPage({Key key, this.regionArea}) : super(key: key);

  @override
  _RegionDetailsPageState createState() => _RegionDetailsPageState(regionArea);
}

class _RegionDetailsPageState extends State<RegionDetailsPage> {
  final String regionArea;

  _RegionDetailsPageState(this.regionArea);

  @override
  void initState() {
    super.initState();
    Provider.of<RegionDetailsViewModel>(context, listen: false)
        .fetchAdministrationData(regionArea);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegionDetailsViewModel>(context);

    return Scaffold(
        appBar: AppBar(title: Text(Globals.getAreaName(regionArea))),
        body: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: administrationDataUi(viewModel)));
  }

  Widget administrationDataUi(RegionDetailsViewModel viewModel) {
    if (viewModel.state == ViewModelState.Loading) {
      return Center(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: CircularProgressIndicator(),
      ));
    } else {
      return ListView.builder(
        itemCount: viewModel.administrationData.length,
        itemBuilder: (context, index) {
          AdministrationData administrationData =
              viewModel.administrationData[index];
          return TimelineTile(
              isFirst: index == 0,
              isLast: index == viewModel.administrationData.length - 1,
              indicatorStyle: IndicatorStyle(
                color: Globals.PRIMARY_COLOR,
              ),
              afterLineStyle: LineStyle(color: Globals.PRIMARY_COLOR),
              beforeLineStyle: LineStyle(color: Globals.PRIMARY_COLOR),
              endChild: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        administrationData.formattedAdministrationDate,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Container(height: 6),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).doses_administered,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(":"),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(formatDecimalNumber
                                .format(administrationData.total)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).first_dose,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(":"),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(formatDecimalNumber
                                .format(administrationData.firstDose)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).second_dose,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(":"),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(formatDecimalNumber
                                .format(administrationData.secondDose)),
                          )
                        ],
                      ),
                    ]),
              ));
        },
      );
    }
  }
}
