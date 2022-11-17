import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../Constant/app_strings.dart';
import '../../Controller/ToastController/toast_controller.dart';
import '../../Utils/Mixins/progress_hub.dart';
import 'custom_exception.dart';

///-----> Warning :: Don't call api directly in this class make appropriate api method in api_request_service.dart file and use it where you want

enum RequestMethods { GET, POST, PUT, DELETE }

class ApiService {
  static Future<dynamic> request(BuildContext context, String url, RequestMethods methods, {Map<String, String>? header}) async {
    showProgressThreeDots(context);
    try {
      log("---Request url: " + url);
      var response = await apiCallMethod(url, methods, header: header);
      log("---Response : " + response.body);
      Navigator.pop(context);
      if (response != null) {
        if (response.statusCode == 200 && response.body.isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          if (response.statusCode == 404 || response.statusCode == 502) {
            log("---!! AuthenticationFailed !!---");
            showToast(context, "AuthenticationFailed", Toast.LENGTH_SHORT);
            //showAuthenticationDialog(context, () => request(context, url, methods, header: header));
          } else {
            var error = responseCodeHandle(response).toString();
            log("--- Error : $error");
            showToast(context, error, Toast.LENGTH_SHORT);
          }
          return null;
        }
      } else {
        showToast(context, ApiStrings.somethingWentWrong, Toast.LENGTH_SHORT);
        return null;
      }
    }on SocketException catch (_) {
      Navigator.pop(context);
      showToast(context, ApiStrings.mobileDataOff, Toast.LENGTH_SHORT);
    } catch (e) {
      log("---Error : " + e.toString());
      Navigator.pop(context);
      showToast(context, ApiStrings.somethingWentWrong, Toast.LENGTH_SHORT);
      return null;
    }
  }

  static dynamic responseCodeHandle(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 404:
      case 403:throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('${ApiStrings.communicationMsg} ${response.statusCode}');
    }
  }

  static Future<dynamic> apiCallMethod(String url, RequestMethods methods,
      {Map<String, String>? header}) async {
    if (methods == RequestMethods.GET) {
      return await http.get(Uri.parse(url));
    } else if (methods == RequestMethods.POST) {
      return await http.post(Uri.parse(url), headers: header!);
    } else if (methods == RequestMethods.PUT) {
      return await http.put(Uri.parse(url), headers: header!);
    } else if (methods == RequestMethods.DELETE) {
      return await http.delete(Uri.parse(url), headers: header!);
    }
    return null;
  }
}

