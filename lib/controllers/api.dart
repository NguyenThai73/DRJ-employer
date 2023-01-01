// ignore_for_file: empty_catches, unused_catch_clause, depend_on_referenced_packages, unnecessary_string_interpolations

import 'dart:convert';
import 'package:atbmtptpmdd_employer/controllers/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
String ip = "localhost";
String baseUrl = "http://$ip:8084";

//đăng nhập
httpPostLogin(requestBody, context) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var finalRequestBody = json.encode(requestBody);
  var response = await http.post(
      Uri.parse("$baseUrl/api/employer/login".toString()),
      headers: headers,
      body: finalRequestBody);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
    } on FormatException catch (e) {}
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}

//đăng ký
httpPostRegister(requestBody, context) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var finalRequestBody = json.encode(requestBody);
  var response = await http.post(Uri.parse("$baseUrl/api/employer/sign"),
      headers: headers, body: finalRequestBody);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
    } on FormatException catch (e) {
      //bypass
    }
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}

//lấy về bản ghi
httpGet(url, context) async {
  var securityModel = Provider.of<Employer>(context, listen: false);
  Map<String, String> headers = {'content-type': 'application/json'};
  if (securityModel.authorization != "") {
    headers["Authorization"] = "${securityModel.authorization}";
  }
  var response = await http.get(Uri.parse('$baseUrl$url'), headers: headers);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
    } on FormatException catch (e) {}
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}

httpGetNo(url, context) async {
  Map<String, String> headers = {};
  var response = await http.get(Uri.parse('$url'), headers: headers);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
    } on FormatException catch (e) {}
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}

//insert bản ghi
httpPost(url, requestBody, context) async {
  var user = Provider.of<Employer>(context, listen: false);
  Map<String, String> headers = {'content-type': 'application/json'};
  if (user.authorization != "") {
    headers["Authorization"] = "${user.authorization}";
  }
  var finalRequestBody = json.encode(requestBody);
  var response = await http.post(Uri.parse("$baseUrl$url".toString()),
      headers: headers, body: finalRequestBody);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
    } on FormatException catch (e) {
      //bypass
    }
  } else {
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
  }
}

//update bản ghi
httpPut(url, requestBody, context) async {
  var securityModel = Provider.of<Employer>(context, listen: false);
  Map<String, String> headers = {'content-type': 'application/json'};
  headers["Authorization"] = "${securityModel.authorization}";
  var finalRequestBody = json.encode(requestBody);
  var response = await http.put(Uri.parse('$baseUrl$url'),
      headers: headers, body: finalRequestBody);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
    } on FormatException catch (e) {}
  } else
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
}

//xóa bản ghi
httpDelete(url, context) async {
  var securityModel = Provider.of<Employer>(context, listen: false);
  Map<String, String> headers = {'content-type': 'application/json'};
  if (securityModel.authorization != "") {
    headers["Authorization"] = "${securityModel.authorization}";
  }
  var response = await http.delete(Uri.parse('$baseUrl$url'), headers: headers);
  if (response.statusCode == 200 &&
      response.headers["content-type"] == 'application/json') {
    try {
      return {
        "headers": response.headers,
        "body": json.decode(utf8.decode(response.bodyBytes))
      };
      // ignore: unused_catch_clause
    } on FormatException catch (e) {
      //bypass
    }
  } else
    return {
      "headers": response.headers,
      "body": utf8.decode(response.bodyBytes)
    };
}
void downloadFile(String fileName) {
  html.AnchorElement anchorElement =
      new html.AnchorElement(href: "$fileName");
  anchorElement.download = "$fileName";
  anchorElement.click();
}
