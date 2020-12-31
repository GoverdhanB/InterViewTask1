class Thumbnail {
Thumbnail({
  this.source,
  this.width,
  this.height,
});

String source;
int width;
int height;

Thumbnail.fromJson(Map<String,dynamic> json){
  this.source = json['source'];
  this.width  = json['width'];
  this.height = json['height'];
}
}
