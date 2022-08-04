import 'dart:developer';
import 'dart:io';
import 'package:app_visitor/common/common.dart';
import 'package:app_visitor/screens/scan_qr/widget/view_success.dart';
import 'package:app_visitor/screens/screens.dart';
import 'package:app_visitor/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  ScanQRController get _controller => Get.find();

  final _textTheme = Get.textTheme;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller.qrController!.pauseCamera();
    }
    _controller.qrController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanQRController>(
      builder: (_) {
        if (_controller.checkoutSuccess) {
          return ViewCheckoutSuccess();
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Scan QR Code', style: _textTheme.headline5!.textWhite),
            leading: Center(
              child: InkWell(
                onTap: Get.back,
                child: Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorGrey797979,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: _buildQrView(context),
        );
      },
    );
  }

  Widget _buildQrView(BuildContext context) {
    const scanArea = 335.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        QRView(
          key: _controller.qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 25,
              borderLength: 0.001,
              borderWidth: 0.001,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
//         ScanView(
//           controller: _controller.scanController,
// // custom scan area, if set to 1.0, will scan full area
//           scanAreaScale: 260 / Get.width,
//           scanLineColor: Colors.transparent,
//           onCapture: (data) {
//             _controller.checkout(data);
//           },
//         ),
        Image.asset(
          'img_border_scan'.assetImagesPathPNG,
          width: 350,
        ),
        Text(
          'Use QR code in the badge you have received\nin the step Check-in',
          style: _textTheme.headline5!.regular.textWhite,
          textAlign: TextAlign.center,
        ).paddingOnly(bottom: scanArea + 160),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (scanArea + 250).verticalSpace,
            Text(
              'OR',
              style: _textTheme.headline6!.textWhite,
            ),
            30.verticalSpace,
            const Text('Add manually')
                .elevatedButton(onPressed: _controller.addManually)
                .wrapWidth(250)
          ],
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller.qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      _controller.confirmCheckout(scanData.code ?? '');
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    _controller.qrController!.dispose();
    super.dispose();
  }
}
