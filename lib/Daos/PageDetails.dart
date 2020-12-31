import 'dart:collection';
import 'dart:convert';
import 'Terms.dart';
import 'Thumbnail.dart';

class PageDetails {

  PageDetails({
    this.pageid,
    this.ns,
    this.title,
    this.index,
    this.thumbnail,
    this.terms,
  });

  int pageid;
  int ns;
  String title;
  int index;
  Thumbnail thumbnail;
  Terms terms;

  PageDetails.fromJson(dynamic json){
    try {
      this.pageid = json['pageid'];
      this.ns =  json['ns'] != null ? json['ns']:0;
      this.title = json['title'] != null ? json['title']:'No title';
      this.index = json['index'] != null ? json['index']:0;
      this.thumbnail =json['thumbnail'] != null  ? Thumbnail.fromJson(json['thumbnail']):new Thumbnail();
      this.terms = json['terms'] != null  ?Terms.fromJson(json['terms']):new Terms();
    }catch(error){
      print("error"+error);
    }
    }


}