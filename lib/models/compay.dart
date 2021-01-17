import 'package:http/http.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<List<Company>> fetchOfferTagged({String tag = '', String lat = '', String long ='', String fullTime = '', int page = 0}) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  String fileName = "CachePopularData.json";
  var cacheDir = await getTemporaryDirectory();
  if(!await File(cacheDir.path + "/" + fileName).exists() ) {
    var response = await get(
        'https://jobs.github.com/positions.json?description=$tag&lat=$lat&long=$long&full_time=$fullTime&page=$page', headers:headers);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName);
      List jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      file.writeAsString(response.body , flush: true, mode: FileMode.write);
      return jsonResponse.map((offer) => new Company.fromJson(offer)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
  else if (await File(cacheDir.path + "/" + fileName).exists() ) {
    //TOD0: Reading from the json File
    var jsonData = File(cacheDir.path + "/" + fileName).readAsStringSync();
    List response = json.decode(jsonData);
    return response.map((offer) => new Company.fromJson(offer)).toList();
  }
}
Future<List<Company>> fetchOfferRecent({String tag = '', String lat = '', String long ='', String fullTime = '', int page = 0}) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  String fileName = "CacheRecentData.json";
  var cacheDir = await getTemporaryDirectory();
  if (await File(cacheDir.path + "/" + fileName).exists() ) {
    //TOD0: Reading from the json File
    var jsonData = File(cacheDir.path + "/" + fileName).readAsStringSync();
    List response = json.decode(jsonData);
    return response.map((offer) => new Company.fromJson(offer)).toList();
  }
  else {
    var response = await get(
        'https://jobs.github.com/positions.json?description=$tag&lat=$lat&long=$long&full_time=$fullTime&page=$page', headers:headers);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName);
      List jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      file.writeAsString(response.body , flush: true, mode: FileMode.write);
      return jsonResponse.map((offer) => new Company.fromJson(offer)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
Future<List<Company>> fetchOfferSearch({String tag = '', String location = '', String fullTime = '', int page = 0}) async {
  var response = await get(
      'https://jobs.github.com/positions.json?description=$tag&location=$location&full_time=$fullTime&page=$page');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((offer) => new Company.fromJson(offer)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
Future fetchOfferById({List<String> ids}) async {
  List<Company> b = new List();

  for (int i = 0; i < ids.length; i++) {
    var response =
    await get('https://jobs.github.com/positions/${ids[i]}.json');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      b.add(Company.fromJson(jsonDecode(response.body)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
  //Future<List<Company>> returned = new Future(b);
  return b;
}

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}

class Company {
  String id;
  String title;
  String location;
  String time;
  String description;
  String companyLogo;
  String company;
  String offerURL;
  String date;
  String companyURL;
  String howTo;
  Company(
      {this.id,
      this.title,
      this.location,
      this.company,
      this.time,
      this.description,
      this.date,
      this.offerURL,
      this.companyLogo,
      this.companyURL,
      this.howTo});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      title: json['title'],
      id: json['id'],
      company: json['company'],
      companyURL: json['company_url'],
      location: json['location'],
      time: json['type'],
      companyLogo:
          json['company_logo'] == null ? 'Empty' : json['company_logo'],
      description: removeAllHtmlTags(json['description']),
      offerURL: json['url'],
      howTo: removeAllHtmlTags(json['how_to_apply']),
      date: json['created_at'].substring(8, 10) +
          ' ' +
          json['created_at'].substring(4, 8) +
          ' ' +
          json['created_at'].substring(24, 28),
    );
  }
}
