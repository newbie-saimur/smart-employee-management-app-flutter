import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerator {
  static Future<void> generatePayslip(Map<String, dynamic> payslipData) async {
    final pdf = pw.Document();
    final earningsData = payslipData['earnings'] as Map<String, dynamic>;
    final deductionsData = payslipData['deductions'] as Map<String, dynamic>;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                color: PdfColor.fromHex('#1E293B'),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'SALARY SLIP',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      payslipData['salaryMonth'],
                      style: pw.TextStyle(fontSize: 16, color: PdfColors.white),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Net Pay Section
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColor.fromHex('#E2E8F0')),
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                child: pw.Column(
                  children: [
                    pw.Text(
                      'NET PAY',
                      style: pw.TextStyle(
                        fontSize: 14,
                        color: PdfColor.fromHex('#64748B'),
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      children: [
                        pw.Text(
                          "BDT. ",
                          style: pw.TextStyle(
                            fontSize: 28,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#1E293B'),
                          ),
                        ),
                        pw.Text(
                          '${payslipData['netPay']}',
                          style: pw.TextStyle(
                            fontSize: 36,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#1E293B'),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Disbursed on ${payslipData['disbursementDate']}',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColor.fromHex('#64748B'),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Earnings Section
              pw.Text(
                'EARNINGS',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#64748B'),
                ),
              ),
              pw.SizedBox(height: 10),
              _buildRow('Basic Salary', earningsData['basicSalary']),
              _buildRow('House Rent', earningsData['houseRent']),
              _buildRow('Medical Allowance', earningsData['medicalAllowance']),
              _buildRow('Conveyance', earningsData['conveyance']),
              pw.Divider(),
              _buildRow(
                'TOTAL EARNINGS',
                earningsData['totalEarnings'],
                isTotal: true,
                color: PdfColor.fromHex('#16A34A'),
              ),
              pw.SizedBox(height: 20),

              // Deductions Section
              pw.Text(
                'DEDUCTIONS',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#64748B'),
                ),
              ),
              pw.SizedBox(height: 10),
              _buildRow('Tax (TDS)', deductionsData['taxTDS']),
              _buildRow('Provident Fund', deductionsData['providentFund']),
              pw.Divider(),
              _buildRow(
                'TOTAL DEDUCTIONS',
                deductionsData['totalDeductions'],
                isTotal: true,
                color: PdfColor.fromHex('#E11D65'),
              ),

              pw.Spacer(),

              // Footer
              pw.Divider(),
              pw.Center(
                child: pw.Text(
                  '© 2025 Smart Employee Hub - Version 1.0',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromHex('#90929C'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save or share the PDF
    await _savePdf(pdf, payslipData['salaryMonth']);
  }

  static pw.Widget _buildRow(
    String label,
    String value, {
    bool isTotal = false,
    PdfColor? color,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: color ?? PdfColor.fromHex('#1E293B'),
            ),
          ),
          pw.Text(
            'BDT. $value',
            style: pw.TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: pw.FontWeight.bold,
              color: color ?? PdfColor.fromHex('#1E293B'),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> _savePdf(pw.Document pdf, String fileName) async {
    try {
      // For all platforms, use the share dialog
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'Payslip_${fileName.replaceAll(' ', '_')}.pdf',
      );
    } catch (e) {
      print('Error saving PDF: $e');
      rethrow;
    }
  }
}
