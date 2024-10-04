import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasource/remote/params/cancel_order_param.dart';
import '../../data/datasource/remote/params/proof_of_work_param.dart';
import '../../data/model/response/proof_of_work/proof_of_work.dart';
import '../../domain/usecase/order_detail/cancel_order_use_case.dart';
import '../../domain/usecase/order_detail/get_proof_of_work_use_case.dart';

class ProofOfWorkState {
  final bool isLoading;
  final List<ProofOfWorkModel>? proofOfWorks;
  final String? error;

  ProofOfWorkState({
    this.isLoading = false,
    this.proofOfWorks,
    this.error,
  });

  ProofOfWorkState copyWith({
    bool? isLoading,
    List<ProofOfWorkModel>? proofOfWorks,
    String? error,
  }) {
    return ProofOfWorkState(
      isLoading: isLoading ?? this.isLoading,
      proofOfWorks: proofOfWorks ?? this.proofOfWorks,
      error: error ?? this.error,
    );
  }
}

class ProofOfWorkController extends Cubit<ProofOfWorkState> {
  final GetProofOfWorkUseCase getProofOfWorkUseCase;
  final CancelOrderUseCase cancelOrderUseCase;

  ProofOfWorkController({
    required this.getProofOfWorkUseCase,
    required this.cancelOrderUseCase,
  }) : super(ProofOfWorkState());

  Future<void> getProofOfWork() async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await getProofOfWorkUseCase.invoke(
        param: ProofOfWorkParams(
          reasonType: ReasonType.poc,
          userType: "supplier",
          appType: "onwheel"
        )
      );
      emit(state.copyWith(isLoading: false, proofOfWorks: result));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> cancelOrder(String orderId, String selectedReason) async {
    emit(state.copyWith(isLoading: true));
    try {
      await cancelOrderUseCase.invoke(param: CancelOrderParams(orderId: orderId, comment: selectedReason));
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
