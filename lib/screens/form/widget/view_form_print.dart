import 'dart:typed_data';

import 'package:app_visitor/models/models.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class ViewFormPrinting {
  PdfPageFormat? pageFormat;
  Uint8List byteQrCode;
  Uint8List logoCompany;
  CustomerModel customer;

  ViewFormPrinting(
      {this.pageFormat,
      required this.byteQrCode,
      required this.customer,
      required this.logoCompany});

  pw.Page get page => pw.Page(
        pageFormat: pageFormat,
        build: (context) {
          return pw.Container(
            width: double.infinity,
            height: double.infinity,
            alignment: pw.Alignment.center,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  customer.displayName,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.Divider(height: 10, thickness: 0.5),
                pw.Text(
                  customer.company,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontSize: 8,
                      fontWeight: pw.FontWeight.normal),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  '#ID: ${customer.customerId}',
                  style: pw.TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontSize: 5,
                      fontWeight: pw.FontWeight.normal),
                ),
                pw.SizedBox(height: 5),
                pw.Container(
                  alignment: pw.Alignment.center,
                  width: double.infinity,
                  height: 60,
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColor.fromHex('#F7F7F8'), width: 1),
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.Image(pw.MemoryImage(byteQrCode),
                      fit: pw.BoxFit.cover, width: 60, height: 60),
                ),
              ],
            ),
          );
        },
      );
}
