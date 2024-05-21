import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasmobile/transaction/continue_button.dart';

bool withTax = false;
RxBool hasTaxes = false.obs;
RxString amountText = "".obs;
TextEditingController amountcontroller = TextEditingController();

class Amount extends StatefulWidget {
  const Amount({
    super.key,
  });

  @override
  State<Amount> createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.70,
              child: Obx(
                () => TextField(
                  controller: amountcontroller,
                  onChanged: (val) {
                    amountText.value = val;
                    updateVals();
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.attach_money),
                      labelText: hasTaxes.isTrue
                          ? 'Betrag (mit Steuer):'
                          : "Betrag (ohne Steuer):"),
                ),
              )),
          SizedBox(
            child: Visibility(
              visible: true,
              child: IconButton(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  iconSize: 30,
                  color: const Color(0xFF2F537D),
                  onPressed: () {
                    Null;
                  },
                  icon: const Icon(null)),
            ),
          )
        ],
      ),
    );
  }
}

updateVals() {
  setIsClickable();
  isClickable.refresh();
  topay.value = calculateToPay().value;
  recieval.value = calculateRecieval().value;
  hasTaxes.value = withTax;
  topay.refresh();
  recieval.refresh();
}
