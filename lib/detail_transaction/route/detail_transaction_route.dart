import 'package:app_riverpod/core/router/base_route.dart';
import 'package:app_riverpod/detail_transaction/detail_transaction_screen.dart';
import 'package:app_riverpod/detail_transaction/route/detail_transaction_input_output.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_transaction_route.g.dart';

@riverpod
DetailTransactionRoute detailTransactionRoute(DetailTransactionRouteRef ref) {
  return DetailTransactionRoute();
}

class DetailTransactionRoute extends BaseRoute<DetailTransactionInput, DetailTransactionOutput> {
  DetailTransactionRoute({
    super.name = "detail_transaction",
    super.path = "/detail_transaction",
  });


  GoRoute route() {
    return GoRoute(
      name: name,
      path: path,
      builder: (context, state) {
        return DetailTransactionScreen(input: state.extra as DetailTransactionInput);
      },
    );
  }
}