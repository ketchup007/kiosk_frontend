import 'dart:io';
import 'dart:typed_data';

class Payment {
  int pedState = 0;

  checkState() async {
    final socket = await Socket.connect('10.3.15.90', 5189);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

    final bytesBuilder = BytesBuilder();
    bytesBuilder.add([0x00, 0x00, 0x00, 0x00]);
    bytesBuilder.add([0x00, 0x02]);
    bytesBuilder.add([0x00, 0x1C]);

    socket.add(bytesBuilder.toBytes());
    await socket.flush();
    socket.listen((Uint8List data) {
      print(data[16]);
      pedState = data[16];
      socket.destroy();
    }, onError: (error) {
      print(error);
      socket.destroy();
    }, onDone: () {
      print("done");
      socket.destroy();
    });
  }

  Future<String> startTransaction(double price) async {
    pedState = 0;
    while (true) {
      await checkState();
      if (pedState == 1) {
        break;
      } else {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    return await startPayment(price);
  }

  Future<String> startPayment(double price) async {
    print("in payment");
    final socket = await Socket.connect('10.3.15.90', 5188);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

    List<int> tagEftMessageNumber = [0x00, 0x00, 0x02, 0x00];
    List<int> tagEftMessageNumberLength = [0x02, 0x00, 0x00, 0x00]; //2
    List<int> tagEftMessageNumberValue = [0x30, 0x31]; //0 1
    List<int> tagEftMessageNumberFull = tagEftMessageNumber + tagEftMessageNumberLength + tagEftMessageNumberValue;

    List<int> tagEftAmount1 = [0x01, 0x00, 0x02, 0x00];
    List<int> tagEftAmount1Length = [0x0C, 0x00, 0x00, 0x00]; //12
    List<int> tagEftAmount1Value = priceToAscii(price);
    List<int> tagEftAmount1Full = tagEftAmount1 + tagEftAmount1Length + tagEftAmount1Value;

    List<int> tagEftAmount1Label = [0x05, 0x00, 0x02, 0x00];
    List<int> tagEftAmount1LabelLength = [0x07, 0x00, 0x00, 0x00]; //7
    List<int> tagEftAmount1LabelValue = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x31]; //A m o u n t 1
    List<int> tagEftAmount1LabelFull = tagEftAmount1Label + tagEftAmount1LabelLength + tagEftAmount1LabelValue;

    List<int> tagEftTransactionType = [0x09, 0x00, 0x02, 0x00];
    List<int> tagEftTransactionTypeLength = [0x02, 0x00, 0x00, 0x00]; //2
    List<int> tagEftTransactionTypeValue = [0x30, 0x30]; // 0 0
    List<int> tagEftTransactionTypeFull = tagEftTransactionType + tagEftTransactionTypeLength + tagEftTransactionTypeValue;

    List<int> tagEftAmount2 = [0x02, 0x00, 0x02, 0x00];
    List<int> tagEftAmount2Length = [0x0C, 0x00, 0x00, 0x00]; // 7
    List<int> tagEftAmount2Value = [0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30]; // 0 0 0 0 0 0 0 0 0 0 0 0
    List<int> tagEftAmount2Full = tagEftAmount2 + tagEftAmount2Length + tagEftAmount2Value;

    List<int> tagEftAmount3 = [0x03, 0x00, 0x02, 0x00];
    List<int> tagEftAmount3Length = [0x0C, 0x00, 0x00, 0x00]; // 12
    List<int> tagEftAmount3Value = [0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30]; // 0 0 0 0 0 0 0 0 0 0 0 0
    List<int> tagEftAmount3Full = tagEftAmount3 + tagEftAmount3Length + tagEftAmount3Value;

    List<int> tagEftAmount4 = [0x04, 0x00, 0x02, 0x00];
    List<int> tagEftAmount4Length = [0x0C, 0x00, 0x00, 0x00]; // 12
    List<int> tagEftAmount4Value = [0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30]; // 0 0 0 0 0 0 0 0 0 0 0 0
    List<int> tagEftAmount4Full = tagEftAmount4 + tagEftAmount4Length + tagEftAmount4Value;

    List<int> tagEftAmount2Label = [0x06, 0x00, 0x02, 0x00];
    List<int> tagEftAmount2LabelLength = [0x07, 0x00, 0x00, 0x00]; // 7
    List<int> tagEftAmount2LabelValue = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x32]; // A m o u n t 2
    List<int> tagEftAmount2LabelFull = tagEftAmount2Label + tagEftAmount2LabelLength + tagEftAmount2LabelValue;

    List<int> tagEftAmount3Label = [0x07, 0x00, 0x02, 0x00];
    List<int> tagEftAmount3LabelLength = [0x07, 0x00, 0x00, 0x00]; // 7
    List<int> tagEftAmount3LabelValue = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x33]; // A m o u n t 3
    List<int> tagEftAmount3LabelFull = tagEftAmount3Label + tagEftAmount3LabelLength + tagEftAmount3LabelValue;

    List<int> tagEftAmount4Label = [0x08, 0x00, 0x02, 0x00];
    List<int> tagEftAmount4LabelLength = [0x07, 0x00, 0x00, 0x00]; // 7
    List<int> tagEftAmount4LabelValue = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x34]; // A m o u n t 4
    List<int> tagEftAmount4LabelFull = tagEftAmount4Label + tagEftAmount4LabelLength + tagEftAmount4LabelValue;

    List<int> tagEftCommercialCode = [0x0C, 0x00, 0x02, 0x00];
    List<int> tagEftCommercialCodeLength = [0x02, 0x00, 0x00, 0x00]; // 2
    List<int> tagEftCommercialCodeValue = [0x20, 0x20]; // SPACE SPACE
    List<int> tagEftCommercialCodeFull = tagEftCommercialCode + tagEftCommercialCodeLength + tagEftCommercialCodeValue;

    List<int> tagEftSuspectFraudIndicator = [0x5B, 0x00, 0x02, 0x00];
    List<int> tagEftSuspectFraudIndicatorLength = [0x01, 0x00, 0x00, 0x00]; // 1
    List<int> tagEftSuspectFraudIndicatorValue = [0x00]; // 0
    List<int> tagEftSuspectFraudIndicatorFull = tagEftSuspectFraudIndicator + tagEftSuspectFraudIndicatorLength + tagEftSuspectFraudIndicatorValue;

    List<int> tagEftReturnCardRespValue = [0x7D, 0x00, 0x02, 0x00];
    List<int> tagEftReturnCardRespValueLength = [0x01, 0x00, 0x00, 0x00]; // 1
    List<int> tagEftReturnCardRespValueValue = [0x01]; // 1
    List<int> tagEftReturnCardRespValueFull = tagEftReturnCardRespValue + tagEftReturnCardRespValueLength + tagEftReturnCardRespValueValue;

    List<int> tagEftReturnSigReqValue = [0x86, 0x00, 0x02, 0x00];
    List<int> tagEftReturnSigReqValueLength = [0x01, 0x00, 0x00, 0x00]; // 1
    List<int> tagEftReturnSigReqValueValue = [0x01]; // 1
    List<int> tagEftReturnSigReqValueFull = tagEftReturnSigReqValue + tagEftReturnSigReqValueLength + tagEftReturnSigReqValueValue;

    List<int> tagEftEnableEcrBlik = [0x89, 0x00, 0x02, 0x00];
    List<int> tagEftEnableEcrBlikLength = [0x01, 0x00, 0x00, 0x00]; // 1
    List<int> tagEftEnableEcrBlikValue = [0x01]; // 1
    List<int> tagEftEnableEcrBlikFull = tagEftEnableEcrBlik + tagEftEnableEcrBlikLength + tagEftEnableEcrBlikValue;

    List<int> tagEftEnableToken = [0x8D, 0x00, 0x02, 0x00];
    List<int> tagEftEnableTokenLength = [0x01, 0x00, 0x00, 0x00]; // 1
    List<int> tagEftEnableTokenValue = [0x00]; // 0
    List<int> tagEftEnableTokenFull = tagEftEnableToken + tagEftEnableTokenLength + tagEftEnableTokenValue;

    List<int> tagEftEnableReturnMarkupTextIndicator = [0x9B, 0x00, 0x02, 0x00];
    List<int> tagEftEnableReturnMarkupTextIndicatorLength = [0x01, 0x00, 0x00, 0x00]; // 1
    List<int> tagEftEnableReturnMarkupTextIndicatorValue = [0x00]; // 0
    List<int> tagEftEnableReturnMarkupTextIndicatorFull = tagEftEnableReturnMarkupTextIndicator + tagEftEnableReturnMarkupTextIndicatorLength + tagEftEnableReturnMarkupTextIndicatorValue;

    List<int> tagEftReturnApmData = [0x9D, 0x00, 0x02, 0x00];
    List<int> tagEftReturnApmDataLength = [0x01, 0x00, 0x00, 0x00]; // 1
    List<int> tagEftReturnApmDataValue = [0x00]; // 0
    List<int> tagEftReturnApmDataFull = tagEftReturnApmData + tagEftReturnApmDataLength + tagEftReturnApmDataValue;

    List<int> payload = tagEftMessageNumberFull +
        tagEftAmount1Full +
        tagEftAmount1LabelFull +
        tagEftTransactionTypeFull +
        tagEftAmount2Full +
        tagEftAmount3Full +
        tagEftAmount4Full +
        tagEftAmount2LabelFull +
        tagEftAmount3LabelFull +
        tagEftAmount4LabelFull +
        tagEftCommercialCodeFull +
        tagEftSuspectFraudIndicatorFull +
        tagEftReturnCardRespValueFull +
        tagEftReturnSigReqValueFull +
        tagEftEnableEcrBlikFull +
        tagEftEnableTokenFull +
        tagEftEnableReturnMarkupTextIndicatorFull +
        tagEftReturnApmDataFull;

    final bytesBuilder = BytesBuilder();
    bytesBuilder.add([payload.length, 0x00, 0x00, 0x00]); //header
    bytesBuilder.add([0x00, 0x02]); //protocol version
    bytesBuilder.add([0x00, 0x02]); //message type
    bytesBuilder.add(payload); //payload

    socket.add(bytesBuilder.toBytes());
    await socket.flush();

    String endstring = "";

    var response = socket.listen((Uint8List data) async {
      int i = 8;
      int tag = 0;
      int tagLength = 0;
      int responseCode = 0;
      while (i < data.length) {
        tag = data[i] + data[i + 1] * 256 + data[i + 2] * 65536 + data[i + 3] * 16777216;
        tagLength = data[i + 4] + data[i + 5] * 256 + data[i + 6] * 65536 + data[i + 7] * 16777216;
        if (tag == 131086) {
          if (tagLength == 1) {
            responseCode = asciiToInt(data[i + 8]);
          } else if (tagLength == 2) {
            responseCode = asciiToInt(data[i + 8] + data[i + 8]);
          }
        }
        i += 8 + tagLength;
      }
      socket.destroy();

      //to rewrite from string to int on whole stack
      switch (responseCode) {
        case 0:
          endstring = "0";
          break;
        case 1:
          endstring = "1";
          break;
        case 2:
          endstring = "2";
          break;
        case 3:
          endstring = "3";
          break;
        case 4:
          endstring = "4";
          break;
        case 5:
          endstring = "5";
          break;
        case 6:
          endstring = "6";
          break;
        case 7:
          endstring = "7";
          break;
        case 8:
          endstring = "8";
          break;
        case 9:
          endstring = "9";
          break;
        case 10:
          endstring = "10";
          break;
        case 11:
          endstring = "11";
          break;
        case 12:
          endstring = "12";
          break;
        case 13:
          endstring = "13";
          break;
        case 14:
          endstring = "14";
          break;
        case 15:
          endstring = "15";
          break;
      }

      print(endstring);
    }, onError: (error) {
      print("error");
      print(error);
      socket.destroy();
    }, onDone: () {
      print("done");
      socket.destroy();
    });

    await response.asFuture<void>();
    return endstring;
  }

  Uint8List priceToAscii(double price) {
    String priceString = price.toStringAsFixed(2);

    final bytesBuilder = BytesBuilder();

    for (int i = 0; i < 13 - priceString.length; i++) {
      bytesBuilder.addByte(0x30);
    }

    for (int i = 0; i < priceString.length; i++) {
      switch (priceString[i]) {
        case '0':
          bytesBuilder.addByte(0x30);
          break;
        case '1':
          bytesBuilder.addByte(0x31);
          break;
        case '2':
          bytesBuilder.addByte(0x32);
          break;
        case '3':
          bytesBuilder.addByte(0x33);
          break;
        case '4':
          bytesBuilder.addByte(0x34);
          break;
        case '5':
          bytesBuilder.addByte(0x35);
          break;
        case '6':
          bytesBuilder.addByte(0x36);
          break;
        case '7':
          bytesBuilder.addByte(0x37);
          break;
        case '8':
          bytesBuilder.addByte(0x38);
          break;
        case '9':
          bytesBuilder.addByte(0x39);
          break;
        default:
      }
    }

    return bytesBuilder.toBytes();
  }

  int asciiToInt(int data) {
    int output = 10;

    switch (data) {
      case 0x30:
        output = 0;
        break;
      case 0x31:
        output = 1;
        break;
      case 0x32:
        output = 2;
        break;
      case 0x33:
        output = 3;
        break;
      case 0x34:
        output = 4;
        break;
      case 0x35:
        output = 5;
        break;
      case 0x36:
        output = 6;
        break;
      case 0x37:
        output = 7;
        break;
      case 0x38:
        output = 8;
        break;
      case 0x39:
        output = 9;
        break;
      default:
    }
    return output;
  }
}
