import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasmobile/account/balance.dart';
import 'package:sasmobile/main.dart';
import 'package:sasmobile/utils/get_history.dart';

class HistoryController extends GetxController {
  final ValueNotifier<Future<List<dynamic>>> historyFutureNotifier =
      ValueNotifier(loadHistory());

  Future<void> updateHistory() async {
    historyFutureNotifier.value =
        loadHistory(); // Notify listeners of the change
  }

  static Future<List<dynamic>> loadHistory() async {
    var historyResponse = await getHistory();
    if (historyResponse.statusCode == 200) {
      var response = historyResponse.data!;
      response = response.substring(2, response.length - 2);
      response = response.replaceAll('\\', "");
      response = response.replaceAll("[", "");

      var responses = response.split("},{").map((item) => "{$item}").toList();
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
  const History({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          Get.find<HistoryController>().updateHistory();
          await loadBalance();
        },
        child: ValueListenableBuilder<Future<List<dynamic>>>(
            valueListenable:
                Get.find<HistoryController>().historyFutureNotifier,
            builder: (BuildContext context, Future<List<dynamic>> value,
                Widget? child) {
              return FutureBuilder<List<dynamic>>(
                  future: value,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(); // show a loading spinner while waiting
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                              itemCount: (snapshot.data?.length ??
                                  0), // Increase itemCount by 1
                              itemBuilder: (BuildContext context, int index) {
                                if (index < (snapshot.data?.length ?? 0)) {
                                  // If this is not the last item, return a TransactionEntry
                                  return TransactionEntry(
                                    index: index,
                                    transaction: snapshot.data?[index],
                                  );
                                }
                                return null;
                              }));
                    }
                  });
            }));
  }
}

class TransactionEntry extends StatefulWidget {
  final int index;
  // ignore: prefer_typing_uninitialized_variables
  final transaction;
  const TransactionEntry(
      {super.key, required this.index, required this.transaction});
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textScaler: const TextScaler.linear(1.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(prettyTime(widget.transaction["time"])),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  "${from == id ? "-" : "+"}, ${widget.transaction["amount"]} D",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaler: const TextScaler.linear(1.8),
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
    var response = historyResponse.data!;
    response = response.substring(2, response.length - 2);
    response = response.replaceAll('\\', "");
    response = response.replaceAll("[", "");

    var responses = response.split("},{").map((item) => "{ $item }").toList();
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
