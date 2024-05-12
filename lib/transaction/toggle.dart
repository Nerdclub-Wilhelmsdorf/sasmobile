import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasmobile/transaction/transaction.dart';

class Toggle extends StatefulWidget {
  const Toggle({
    super.key,
  });

  @override
  State<Toggle> createState() => _ToggleState();
}

Rx<TransactionType> transactionType = TransactionType.expense.obs;

class _ToggleState extends State<Toggle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: SegmentedButton(
        segments: const <ButtonSegment<TransactionType>>[
          ButtonSegment<TransactionType>(
              value: TransactionType.expense,
              label: Text('Senden'),
              icon: Icon(Icons.arrow_upward)),
          ButtonSegment<TransactionType>(
              value: TransactionType.income,
              label: Text('Empfangen'),
              icon: Icon(Icons.arrow_downward_outlined)),
        ],
        selected: <TransactionType>{transactionType.value},
        onSelectionChanged: (Set<TransactionType> newSelection) {
          setState(() {
            transactionType.value = newSelection.first;
          });
        },
        showSelectedIcon: false,
        style: const ButtonStyle(),
      ),
    );
  }
}
