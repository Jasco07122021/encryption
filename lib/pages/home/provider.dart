import 'dart:convert';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:encryption/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/export.dart' as pointycastle;

class HomeProvider extends ChangeNotifier {
  TextEditingController textController = TextEditingController();
  String result = "";
  String checkResponse = "No data";
  bool isLoading = false;

  void isLoad(bool value) {
    isLoading = value;
    notifyListeners();
  }

  encryptionPK() {

    isLoad(true);


    String plaintext = textController.text;

    String publickey =
        "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAiHad18T5QHKSkZpeq7lvDHcZI6SdYGvEg4b64rvaCv21U4ml3qtI/HWr+i96ysQwgT9fL7+5skWgtzqFjxLasxDL0Pom9rTaQGzdFtSM51BTZxnDOBMDiKdTMkL6OkUyBJDikV0r2ILssLCXB68ErzxSYheWfVnD73VExZ8pJ331OkluWDlZDXi34/98dRAtToqRrqrjds52PpX7GJ1/09aifv2jqm71qLye3hH75Z9eLtWGgRTNHU++VK2e4T/LZ2idjpOtGnK1zmnV/6vY92EJ45JmgTK0aM8YNzXZyvF35w3M0u50CYSXm0jC5xVyyVd1dvvY/mmvHWwwCuGh7c7DFfP1uVnDaWg4MazYj70vIyU/87i1doHH3kHX7uCNMHQO/xf51YmLsB3Z0CX8xKCKjBch3nQi8r8i8DTuTHL/ELPBNTRnNDtNN7s1gA7RLLXkb2ziFVjOgWPwC3UO1huJi0qIJIPuTYSxfVNnyVORTSV5AyLrCtplZMA+uarcUcauMOUGWxo7HkleOQ2bNqluBrpfBgKRfR+hGnsOeLj0m8tlbKbsYTFigQpwOwHY1Sc0NPfN7oAPqB4Cw6Usl/Q1Bmlb1JPnYCXj9qovdUWllqDMHY7QqJc/1v1uggHuXJ4gR/KtE2SwqOTcPcHxqu32kkd30SqGEvVSyVV9lK0CAwEAAQ==";
    var pem =
        '-----BEGIN RSA PUBLIC KEY-----\n$publickey\n-----END RSA PUBLIC KEY-----';
    var public = CryptoUtils.rsaPublicKeyFromPem(pem);

    /// Initalizing Cipher
    var cipher = pointycastle.PKCS1Encoding(pointycastle.RSAEngine());
    cipher.init(true, PublicKeyParameter<RSAPublicKey>(public));

    /// Converting into a [Unit8List] from List<int>
    /// Then Encoding into Base64
    Uint8List output =
        cipher.process(Uint8List.fromList(utf8.encode(plaintext)));

    var base64EncodedText = base64Encode(output);

    result = base64EncodedText;

    requestHttp(result);
  }

  requestHttp(String result) async {
    await HttpService.POST(HttpService.bodyNote(result)).then((value) {
      checkResponse = HttpService.parseJson(value!).toString();

      isLoad(false);
    });
  }

  clearResult(){
    textController.clear();
    checkResponse = "No data";
    notifyListeners();
  }
}
