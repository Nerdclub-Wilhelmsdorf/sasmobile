
import 'package:flutter/material.dart';
import 'package:sasmobile/transaction/transaction.dart';
class Toggle extends StatefulWidget {

  const Toggle({
    super.key,
  });

  @override
  State<Toggle> createState() => _ToggleState();
}
TransactionType transactionType = TransactionType.expense;

class _ToggleState extends State<Toggle> {
  final ValueChanged<int> update;
  ChildPage({required this.update});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(segments: const <ButtonSegment<TransactionType>>[
            ButtonSegment<TransactionType>(
            value: TransactionType.expense,
            label: Text('Senden'),
            icon: Icon(Icons.arrow_upward)),
        ButtonSegment<TransactionType>(
            value: TransactionType.income,
            label: Text('Empfangen'),
            icon: Icon(Icons.arrow_downward_outlined)),

    ], selected:<TransactionType>{transactionType},
      onSelectionChanged: (Set<TransactionType> newSelection) {
        setState(() {
          transactionType = newSelection.first;
        });
      update();
      },
      
      showSelectedIcon: false,
      style:  ButtonStyle(
        
      ),
     );
  }
}

