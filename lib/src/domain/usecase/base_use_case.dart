abstract class BaseUseCase<Result, Param>{
  Future<Result> invoke({required Param param});
}