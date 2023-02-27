import 'package:dailycheck/models/AdSenseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  SharedPreferences? shared;

  Future<AdSenseModel> showAdsense() async {
    var response = AdSenseModel(false, '');
    final today = getToday();

    if (await anyValue(today)) {
      int val = await getCount(today);
      response.message = val.toString();

      if (await calculate(val)) {
        response.isShow = true;
      } else {
        response.isShow = false;
      }
      await increaseValue(val);
    } else {
      await setCount(today, 1);
      response.isShow = true;
      response.message = '1';
    }
    return response;
  }

  Future<bool> calculate(int val) async {
    if (val % 2 == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future initShared() async {
    shared = await SharedPreferences.getInstance();
  }

  Future<bool> anyValue(String key) async {
    await initShared();
    var response = false;
    response = shared!.containsKey(key);
    return response;
  }

//Deprecated Package
  // Future<String> getApplicationId() async {
  //   return await GetVersion.appID;
  // }

  Future<String> getValue(String value) async {
    var response = '';
    await initShared();
    return shared!.getString(value)!;
  }

  Future<int> getCount(String key) async {
    await initShared();
    return shared!.getInt(key)!;
  }

  Future setString(String key, String val) async {
    await initShared();
    await shared!.setString(key, val);
  }

  Future setCount(String key, int val) async {
    await initShared();
    await shared!.setInt(key, val);
  }

  String getToday() {
    DateTime today = DateTime.now();
    return "${today.year.toString()}${today.month.toString().padLeft(2, '0')}${today.day.toString().padLeft(2, '0')}";
  }

  Future increaseValue(int val) async {
    await initShared();
    await shared!.setInt(getToday(), val + 1);
  }
}
