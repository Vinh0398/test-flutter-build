import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/proof_of_work_param.dart';
import 'package:test_flutter_build/src/utils/platform_channel.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/styles.dart';
import '../../data/model/response/proof_of_work/proof_of_work.dart';
import '../controller/proof_of_work_controller.dart';
import 'widgets/commons/bottom_button_widget.dart';

class CancelOrderView extends StatefulWidget {
  final String orderId;
  bool isFailOrder;
  Function(String)? handleFailReason;

  CancelOrderView({required this.orderId, required this.isFailOrder, this.handleFailReason});
  @override
  _CancelOrderViewState createState() => _CancelOrderViewState();
}

class _CancelOrderViewState extends State<CancelOrderView> {
  late ProofOfWorkController _proofOfWorkController;

  List<ProofOfWorkModel> reasons = [];
  String? selectedReason;
  String? selectedReasonId;
  Map<String, String> groupTitles = {};

  @override
  void initState() {
    super.initState();
    _proofOfWorkController = ProofOfWorkController(
      getProofOfWorkUseCase: context.read(),
      cancelOrderUseCase: context.read(),
    );

    _proofOfWorkController.getProofOfWork(reasonType: widget.isFailOrder ? ReasonType.pof : ReasonType.poc);
    super.initState();
  }

  Widget buildReasonTile(ProofOfWorkModel reason) {
    return RadioListTile<String>(
      title: Text(reason.titleVi ?? ''),
      value: reason.id ?? '',
      groupValue: selectedReason,
      onChanged: (value) {
        setState(() {
          selectedReasonId = value;
          selectedReason = reason.titleVi;
        });
      },
      activeColor: primaryColor,
    );
  }

  Map<String, List<ProofOfWorkModel>> groupReasons() {
    Map<String, List<ProofOfWorkModel>> grouped = {};
    for (var reason in reasons) {
      final group = reason.groupOfReasons ?? '';
      if (!grouped.containsKey(group)) {
        grouped[group] = [];
      }
      grouped[group]!.add(reason);
      groupTitles[group] = reason.groupVi ?? '';
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _proofOfWorkController,
        child: BlocBuilder<ProofOfWorkController, ProofOfWorkState>(
            builder: (BuildContext context, state) {
          if (state.proofOfWorks != null) {
            reasons = state.proofOfWorks!;
            final groupedReasons = groupReasons();

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text('Chọn lý do hủy đơn hàng',
                    style: AppStyles.styleH4.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600)),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var group in groupedReasons.entries) ...[
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            groupTitles[group.key] ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...group.value.map((reason) => buildReasonTile(reason)),
                        SizedBox(height: 8),
                      ],
                      SizedBox(height: 0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      SizedBox(height: 0),
                      BottomButtonWidget(
                          widgetHeight: 80,
                          buttonHeight: 70,
                          buttonPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          buttonTitle: "Xác nhận",
                          buttonColor: primary50,
                          buttonTitleStyle: AppStyles.styleH4.copyWith(
                              color: Colors.white),
                          onTap: () {
                            if (selectedReason != null) {
                              if (widget.isFailOrder == true) {
                                widget.handleFailReason!(selectedReason!);
                                Navigator.pop(context);
                              } else {
                                context.read<ProofOfWorkController>().cancelOrder(
                                  widget.orderId,
                                  selectedReason!,
                                ).then((_) {
                                  // Handle successful cancellation
                                  PlatformChannelMethod.dismissView(
                                      orderId: widget.orderId);
                                }).catchError((error) {
                                  // Handle error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Failed to cancel order: $error')),
                                  );
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please select a reason for cancellation')),
                              );
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
