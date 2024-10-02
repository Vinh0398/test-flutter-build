import 'package:flutter/material.dart';
import '../../../../data/model/response/order_detail/order_detail_model.dart';
import '../../../../utils/texts_utils.dart';

class BillingDetailsWidget extends StatelessWidget {
  final OrderDetailModel order;

  const BillingDetailsWidget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Decreased corner radius
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Chi tiết giá', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildFeeRow('Phí vận chuyển', TextsUtils.moneyString(order.supplierDistancePrice?.toInt() ?? 0, '')),
            _buildFeeRow('Phí điểm dừng', TextsUtils.moneyString(order.supplierStopPointPrice?.toInt() ?? 0, '')),
            _buildFeeRow('Dịch vụ kèm theo', TextsUtils.moneyString(order.supplierSpecialRequestPrice?.toInt() ?? 0, '')),
            _buildFeeRow('Tổng phí [A]', TextsUtils.moneyString(order.supplierSubtotalPrice?.toInt() ?? 0, ''), isBold: true),
            Divider(),
            _buildFeeRow('Thu hộ AHA [B]', TextsUtils.moneyString(order.collectCashForAha?.toInt() ?? 0, '')),
            _buildFeeRow('Tổng cộng [A] + [B]', TextsUtils.moneyString(order.supplierTotalPrice?.toInt() ?? 0, ''), isBold: true),
            Divider(),
            _buildFeeRow('Trừ tiền thu hộ [C]', TextsUtils.moneyString(order.commissionFee?.toInt() ?? 0, '')),
            _buildFeeRow('Thuế và Phí hoa hồng [D]', TextsUtils.moneyString(order.liability?.toInt() ?? 0, '')),
            _buildFeeRow('Số tiền thực nhận\n[A + B] - [C + D]', TextsUtils.moneyString(order.supplierTotalPrice?.toInt() ?? 0, ''), isBold: true),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildAmountBox('Nhận tiền mặt', TextsUtils.moneyString(order.payByCash?.toInt() ?? 0, ''))),
                SizedBox(width: 16),
                Expanded(child: _buildAmountBox('Trong tài khoản', TextsUtils.moneyString(order.payByBalance?.toInt() ?? 0, ''))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          if (value.startsWith('-'))  
            Text(
              '- đ${value.substring(1)}',
              style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            )
          else
            Text(
              'đ$value',
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountBox(String title, String amount) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          if (amount.startsWith('-'))
            Text(
              '- đ${amount.substring(1)}',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          else
            Text(
              'đ$amount',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
