import 'package:app_riverpod/module/detail_transaction/route/detail_transaction_input_output.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DetailTransactionScreen extends ConsumerStatefulWidget {
  const DetailTransactionScreen({
    super.key,
    required this.input,
  });

  final DetailTransactionInput input;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends ConsumerState<DetailTransactionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Detail Transaction"),
          Text(widget.input.prospectId),
          ElevatedButton(
            onPressed: () {
              context.pop(const DetailTransactionOutput(result: "Berhasil"));
            },
            child: const Text('Close'),
          )
        ],
      )
    );
  }
}