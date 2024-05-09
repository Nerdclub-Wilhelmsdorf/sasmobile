import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sasmobile/account/account.dart';
import 'package:sasmobile/account/balance.dart';
import 'package:sasmobile/main.dart';
import 'package:sasmobile/utils/get_history.dart';
import 'package:sasmobile/utils/reset.dart';

class HistoryController extends GetxController {
  final ValueNotifier<Future<List<dynamic>>> historyFutureNotifier =
      ValueNotifier(loadHistory());

  Future<void> updateHistory() async {
    historyFutureNotifier.value = loadHistory();
    historyFutureNotifier.notifyListeners(); // Notify listeners of the change
  }

  static Future<List<dynamic>> loadHistory() async {
    var historyResponse = await getHistory();
    if (historyResponse.statusCode == 200) {
      var _response = historyResponse.data!;
      _response = _response.substring(2, _response.length - 2);
      _response = _response.replaceAll('\\', "");
      _response = _response.replaceAll("[", "");

      var responses =
          _response.split("},{").map((item) => "{" + item + "}").toList();
      responses[0] = responses[0].substring(1, responses[0].length);
      responses.last = responses.last.substring(0, responses.last.length - 2);
      List<dynamic> jsonList =
          responses.map((string) => jsonDecode(string)).toList();
      jsonList = jsonList.reversed.toList();
      return jsonList;
    } else {
      return [];
    }
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Get.find<HistoryController>().updateHistory();
        await loadBalance();
      },
      child: ValueListenableBuilder<Future<List<dynamic>>>(
        valueListenable: Get.find<HistoryController>().historyFutureNotifier,
        builder:
            (BuildContext context, Future<List<dynamic>> value, Widget? child) {
          return FutureBuilder<List<dynamic>>(
            future: value,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(); // show a loading spinner while waiting
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ListView.builder(
                    itemCount: (snapshot.data?.length ?? 0) +
                        1, // Increase itemCount by 1
                    itemBuilder: (BuildContext context, int index) {
                      if (index < (snapshot.data?.length ?? 0)) {
                        // If this is not the last item, return a TransactionEntry
                        return TransactionEntry(
                          index: index,
                          transaction: snapshot.data?[index],
                        );
                      } else {
                        // If this is the last item, return a button
                        return ElevatedButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "App zurücksetzen?",
                                middleText:
                                    "Die PIN und ID des gespeicherten Kontos werden aus der App gelöscht.",
                                confirm: TextButton(
                                    onPressed: () {
                                      Get.back();
                                      reset();
                                    },
                                    child: Text("Bestätigen")));
                          },
                          child: Text(
                            'App zurücksetzten',
                          ),
                        );
                      }
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class TransactionEntry extends StatefulWidget {
  final int index;
  final transaction;
  TransactionEntry({Key? key, required this.index, required this.transaction})
      : super(key: key);
  @override
  State<TransactionEntry> createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  late String from;
  late String to;
  @override
  void initState() {
    from = widget.transaction["from"]
        .substring(5, widget.transaction["from"].length);
    to = widget.transaction["to"].substring(5, widget.transaction["to"].length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  from == id ? Icons.arrow_forward : Icons.arrow_back,
                  color: from == id ? Colors.red : Colors.green,
                  size: 50,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        from == id ? to : from,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaler: TextScaler.linear(1.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(prettyTime(widget.transaction["time"])),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "${from == id ? "-" : "+"}" +
                      widget.transaction["amount"] +
                      "D",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaler: TextScaler.linear(1.8),
                )
              ],
            )
          ],
        ));
  }
}

Future<List<dynamic>> loadHistory() async {
  var historyResponse = await getHistory();
  if (historyResponse.statusCode == 200) {
    var _response = historyResponse.data!;
    _response = _response.substring(2, _response.length - 2);
    _response = _response.replaceAll('\\', "");
    _response = _response.replaceAll("[", "");

    var responses =
        _response.split("},{").map((item) => "{" + item + "}").toList();
    responses[0] = responses[0].substring(1, responses[0].length);
    responses.last = responses.last.substring(0, responses.last.length - 2);
    List<dynamic> jsonList =
        responses.map((string) => jsonDecode(string)).toList();
    jsonList = jsonList.reversed.toList();
    return jsonList;
  } else {
    return [];
  }
}

prettyTime(String time) {
  var splittime = time.split(" ");
  var date = splittime[0];
  var datesSplit = date.split("-");
  var month = datesSplit[0];
  var day = datesSplit[1];
  var year = datesSplit[2];
  return ("${splittime[1].substring(0, splittime[1].length - 3)}, $day.$month.$year ");
}
