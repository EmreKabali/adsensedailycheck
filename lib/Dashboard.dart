import 'package:dailycheck/models/AdSenseModel.dart';
import 'package:dailycheck/service/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AdSenseModel? adSenseModel;
  bool isDone = false;

  // Future initData() async {
  //   adsenseKeys = await Utils().getToday();

  // }

  Future checkadsense() async {
    adSenseModel = await Utils().showAdsense();
    setState(() {
      isDone = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkadsense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DailyCheck'),
          centerTitle: true,
        ),
        body: isDone
            ? Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(adSenseModel!.message, style: textstyle()),
                      Text(
                        adSenseModel!.isShow.toString(),
                        style: textstyle(),
                      )
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }

  TextStyle textstyle() {
    return TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  }
}
