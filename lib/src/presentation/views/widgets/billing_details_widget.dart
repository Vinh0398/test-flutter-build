import 'package:flutter/material.dart';
import '../../../data/model/response/order_detail/order_detail_model.dart';
import '../../../utils/texts_utils.dart';

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
            _buildFeeRow('Phí vận chuyển', CurrencyFormatter.moneyString(order.supplierDistancePrice ?? 0, '')),
            _buildFeeRow('Phí điểm dừng', CurrencyFormatter.moneyString(order.supplierStoppointPrice ?? 0, '')),
            _buildFeeRow('Dịch vụ kèm theo', CurrencyFormatter.moneyString(order.supplierSpecialRequestPrice ?? 0, '')),
            _buildFeeRow('Tổng phí [A]', CurrencyFormatter.moneyString(order.supplierSubtotalPrice ?? 0, ''), isBold: true),
            Divider(),
            _buildFeeRow('Thu hộ AHA [B]', CurrencyFormatter.moneyString(order.collectCashForAha ?? 0, '')),
            _buildFeeRow('Tổng cộng [A] + [B]', CurrencyFormatter.moneyString(order.supplierTotalPrice ?? 0, ''), isBold: true),
            Divider(),
            _buildFeeRow('Trừ tiền thu hộ [C]', CurrencyFormatter.moneyString(order.commissionFee ?? 0, '')),
            _buildFeeRow('Thuế và Phí hoa hồng [D]', CurrencyFormatter.moneyString(order.liability ?? 0, '')),
            _buildFeeRow('Số tiền thực nhận\n[A + B] - [C + D]', CurrencyFormatter.moneyString(order.supplierTotalPrice ?? 0, ''), isBold: true),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildAmountBox('Nhận tiền mặt', CurrencyFormatter.moneyString(order.payByCash ?? 0, ''))),
                SizedBox(width: 16),
                Expanded(child: _buildAmountBox('Trong tài khoản', CurrencyFormatter.moneyString(order.payByBalance ?? 0, ''))),
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
