import 'package:test_flutter_build/src/data/model/response/proof_of_work/proof_of_work.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';


import '../../../data/datasource/remote/params/proof_of_work_param.dart';
import '../../../data/repository/oder_detail/order_detail_repository.dart';

class GetProofOfWorkUseCase implements BaseUseCase<List<ProofOfWorkModel>, ProofOfWorkParams> {
  final OrderDetailRepository orderRepository;

  GetProofOfWorkUseCase({required this.orderRepository});

  @override
  Future<List<ProofOfWorkModel>> invoke({required ProofOfWorkParams param}) async {
    return await orderRepository.getProofOfWork(param);
  }
}


