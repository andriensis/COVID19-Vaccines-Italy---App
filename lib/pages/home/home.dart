import 'package:covid19_vaccines_app/pages/home/home_view_model.dart';
import 'package:covid19_vaccines_app/pages/home/latest_data_details_card.dart';
import 'package:covid19_vaccines_app/pages/home/latest_data_summary_card.dart';
import 'package:covid19_vaccines_app/utils/view_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LatestDataPage extends StatefulWidget {
  final ValueChanged<String> onRegionTap;

  const LatestDataPage({Key key, this.onRegionTap}) : super(key: key);

  @override
  _LatestDataPageState createState() => _LatestDataPageState(onRegionTap);
}

class _LatestDataPageState extends State<LatestDataPage> {
  final ValueChanged<String> onRegionTap;

  _LatestDataPageState(this.onRegionTap);

  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).fetchLatestData();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
        appBar: AppBar(title: Text("COVID19 Vaccines")),
        body: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: latestDataUi(viewModel)));
  }

  Widget latestDataUi(HomeViewModel viewModel) {
    if (viewModel.state == ViewModelState.Loading) {
      return Center(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: CircularProgressIndicator(),
      ));
    }
    return Container(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(AppLocalizations.of(context).last_update),
        Text(":"),
        Text(viewModel.latestData.summary.formattedLastUpdate)
      ]),
      ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: viewModel.latestData.totalCount,
        itemBuilder: (context, index) {
          if (index == 0) {
            return LatestDataSummaryCard(
                details: viewModel.latestData.summary, onTap: onRegionTap);
          }
          return LatestDataDetailsCard(
              details: viewModel.latestData.details[index - 1],
              onTap: onRegionTap);
        },
      )
    ])));
  }
}
