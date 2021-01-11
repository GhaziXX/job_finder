import 'package:http/http.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

Future<List<Company>> fetchOffer({String tag='', String location='', String fullTime='',int page=0}) async {
  var response = await get('https://jobs.github.com/positions.json?description=$tag&location=$location&full_time=$fullTime&page=$page');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse=jsonDecode(response.body);
    return jsonResponse.map((offer) => new Company.fromJson(offer)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
Future<Company> fetchOfferById({String id='' }) async {
  var response = await get('https://jobs.github.com/positions/$id.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Company.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
  );
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
  Company({this.id,this.title,this.location,this.company,this.time,this.description,this.date,this.offerURL,this.companyLogo,this.companyURL,this.howTo});


  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      title : json['title'],
      id: json['id'],
      company: json['company'],
      companyURL : json['company_url'],
      location : json['location'],
      time : json['type'],
      companyLogo : json['company_logo'] == null ? 'Empty' : json['company_logo'],
      description: removeAllHtmlTags(json['description']),
      offerURL : json['url'],
      howTo: removeAllHtmlTags(json['how_to_apply']),
      date : json['created_at'].substring(8,10)+' '+json['created_at'].substring(4,8)+' '+json['created_at'].substring(24,28),
    );
  }

}

