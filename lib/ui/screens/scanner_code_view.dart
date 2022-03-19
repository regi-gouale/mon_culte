import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerCodeView extends StatefulWidget {
  final List<Map<String, dynamic>> cultes;
  final List<Map<String, dynamic>> personnes;
  final int index;

  const ScannerCodeView({
    Key? key,
    required this.cultes,
    required this.personnes,
    required this.index,
  }) : super(key: key);

  @override
  State<ScannerCodeView> createState() => _ScannerCodeViewState();
}

class _ScannerCodeViewState extends State<ScannerCodeView> {
  Barcode qrCodeResult = Barcode(
    null,
    BarcodeFormat.dataMatrix,
    null,
  );

  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey();
  var qrCodeValidationColor = Colors.orange;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.cultes[widget.index]['date'].toString()} ${widget.cultes[widget.index]['heureDebut'].toString()}"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildQrView(context),
            flex: 5,
          ),
          Expanded(
            flex: 1,
            child: colorCameraInterface(qrCodeResult),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrCodeResult = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget colorCameraInterface(Barcode barcodeResult) {
    setState(() {
      qrCodeValidationColor = Colors.red;
    });
    if (barcodeResult.format == BarcodeFormat.qrcode &&
        (barcodeResult.code != "" || barcodeResult.code != null)) {
      var personToculte = 0;
      for (var element in widget.personnes) {
        int? idPerson = int.tryParse(barcodeResult.code!);

        if (element["id"] == idPerson) {
          personToculte = idPerson!;
          if (widget.cultes[widget.index]["participants"].contains(idPerson)) {
            setState(() {
              qrCodeValidationColor = Colors.yellow;
            });
          } else {
            setState(() {
              widget.cultes[widget.index]["participants"].add(personToculte);
            });
            setState(() {
              qrCodeValidationColor = Colors.green;
            });
          }
          
        }
      }
    } else {
      setState(() {
        qrCodeValidationColor = Colors.orange;
      });
    }

    return Container(
      color: qrCodeValidationColor,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "Format: ${barcodeResult.format}",
              ),
              Text(
                "Data: ${barcodeResult.code}",
              ),
              Text(
                "Data length: ${(barcodeResult.code != null) ? barcodeResult.code!.length : null}",
              ),
              Text(
                  "participants: ${widget.cultes[widget.index]['participants']}"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: qrCodeValidationColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, permission) =>
          _onPermissionSet(context, ctrl, permission),
    );
  }

  _onPermissionSet(
      BuildContext context, QRViewController ctrl, bool permission) {
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("no permission"),
        ),
      );
    }
  }
}
