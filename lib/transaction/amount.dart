import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child: TextField(
                   keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) => newValue.copyWith(
                            text: newValue.text.replaceAll(',', '.'),
                          ))
                      ],
                  controller: amountcontroller,
                  onChanged: (val) {
                    amountText.value = val;
                    if(val.contains(",")){
                      amountcontroller.text = amountcontroller.text.replaceAll(",", ".");
                    }
                    updateVals();
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.attach_money),
                      labelText: "Betrag"),
                ),
              ),
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
