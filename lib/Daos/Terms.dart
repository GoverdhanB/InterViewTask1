class Terms {
  Terms({
    this.description,
  });

  List<String> description;
  Terms.fromJson(Map<String,dynamic> json){
    List<dynamic> list= json['description'];
    description = new List() ;
  }
}
