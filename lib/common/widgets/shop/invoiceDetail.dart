import 'package:flutter/material.dart';

import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';

class InvoiceDetail extends StatelessWidget {
  const InvoiceDetail({
    super.key,
    required this.tableData,
  });

  final List<Map<String, String>> tableData;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
      },
      children: tableData.map((data) {
        final isLastRow = data[Strings.key] == Strings.grandTotal;

        return TableRow(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: isLastRow ? 0 : CustomSize.defaultSpace / 4,
                  top: !isLastRow ? 0 : CustomSize.defaultSpace / 4
              ),
              child: Text(
                data[Strings.key]!,
                style: isLastRow ? Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: dark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ) : Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: dark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: isLastRow ? 0 : CustomSize.defaultSpace / 4,
                  top: !isLastRow ? 0 : CustomSize.defaultSpace / 4
              ),
              child: Text(
                data[Strings.value]!,
                style: isLastRow ? Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 18,
                  color: dark ? Colors.blue[400] : Colors.blue[500],
                ) : Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}