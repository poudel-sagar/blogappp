//import 'dart:html';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
class NetworkHandler {
  String baseurl = "https://flaskapi-sanjeev.herokuapp.com/";

  var log = Logger();
  //secure storage for token
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future get(String url) async {
  //here
  //getting token
    String token = await storage.read(key: "token");

//formater takes input  as a string(url) concatenate url with base url and return it.

    url = formater(url);

//getting response from backend
  //here changed
  //   var response = await http.get(url);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     log.i(response.body);
  //     return json.decode(response.body);
  //   }
  //   log.i(response.body);
  //   log.i(response.statusCode);
  // }
  
  //here changed
  var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    //from tutorial 17

    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }
//sending username, email and password to blog api.

  Future<http.Response> post(String url,
      {Map<String, String> body, Map<String, String> header}) async {
    url = formater(url);
    log.d(body);
    final headers = {"Content-type": "application/json"};
    if (header != null) {
      headers.addAll(header);
    }
    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    return response;
  }



   Future<http.Response> patch(String url,
      {Map<String, String> body, Map<String, String> header}) async {
    url = formater(url);
    log.d(body);
    final headers = {"Content-type": "application/json"};
    if (header != null) {
      headers.addAll(header);
    }
    var response = await http.patch(
      url,
      headers: headers,
      body: json.encode(body),
    );

    return response;
  }

   Future<http.Response> post1(String url,
     var body) async {
      String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
   
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer&token"
      },
      body: json.encode(body),
    );
    return response;
  }

   //patch method to send files to backend
   Future<http.StreamedResponse> patchImage(String url,String filePath) async
  {
    url=formater(url);
    String token = await storage.read(key: "token");
    //multipartrequest method used because we are sending file here
    var request=http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filePath));
    request.headers.addAll({
      "content-type":"multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response= request.send();
    return response;
  }
  
    

//formater takes input  as a string(url) concatenate url with base url and return it.
  String formater(String url) {
    return baseurl + url;
  }
}




// import 'dart:html';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:logger/logger.dart';

// class NetworkHandler {
//   //String baseurl = "https://faker-rest.zeferinix.com/api/v1/";
//   String baseurl = "https://flaskapi-sanjeev.herokuapp.com/";

//   var log = Logger();
//   //secure storage for token
//   FlutterSecureStorage storage = FlutterSecureStorage();

//   Future get(String url) async {
// //getting token
//   String token = await storage.read(key: "token");

// //formater takes input  as a string(url) concatenate url with base url and return it.
//     url = formater(url);

// //getting response from backend
//     var response =
//         await http.get(url, headers: {"Authorization": "Bearer $token"});
//     //from tutorial 17

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       log.i(response.body);
//       return json.decode(response.body);
//     }
//     log.i(response.body);
//     log.i(response.statusCode);
//   }
// //sending username, email and password to blog api.

//   Future<http.Response> post(String url,
//       {Map<String, String> body, Map<String, String> header}) async {
//     //in tutorial 17
//     String token = await storage.read(key: "token");
// //original
//     url = formater(url);
//     log.d(body);
//     final headers = {
//       "Content-type": "application/json"
//       //in tutorial 17
//       ,
//       "Authorization": "Bearer $token"
//       //original
//     };
//     if (header != null) {
//       headers.addAll(header);
//     }
//     var response = await http.post(
//       url,
//       headers: headers,
//       body: json.encode(body),
//     );

//     return response;
//     // if (response.statusCode == 200 || response.statusCode == 201) {
//     //   log.i(response.body);
//     //   return response;
//     // }
//     // log.d(response.body);
//     // log.d(response.statusCode);
//   }
//   //patch method to send files to backend
//   Future<http.StreamedResponse> patchImage(String url,String filePath) async
//   {
//     url=formater(url);
//     String token = await storage.read(key: "token");
//     //multipartrequest method used because we are sending file here
//     var request=http.MultipartRequest('PATCH', Uri.parse(url));
//     request.files.add(await http.MultipartFile.fromPath("img", filePath));
//     request.headers.addAll({
//       "content-type":"multipart/form-data",
//       "Authorization": "Bearer $token"
//     });
//     var response= request.send();
//     return response;
//   }

// //formater takes input  as a string(url) concatenate url with base url and return it.
//   String formater(String url) {
//     return baseurl + url;
//   }
  
//   NetworkImage getImage(String username){
//     //end point for user image v:19 ,16:41
//     String url = formater("/uploads/$username.jpg");
//     return NetworkImage(url);
//   }
// }
