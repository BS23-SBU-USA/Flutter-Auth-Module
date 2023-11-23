class UploadImageResponseModel {
  UploadImageResponseModel({
    required this.message,
    required this.data,
  });

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadImageResponseModel(
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
  String message;
  Data data;
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.urlViewer,
    required this.url,
    required this.displayUrl,
    required this.width,
    required this.height,
    required this.size,
    required this.time,
    required this.expiration,
    required this.image,
    required this.thumb,
    required this.medium,
    required this.deleteUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        title: json['title'],
        urlViewer: json['url_viewer'],
        url: json['url'],
        displayUrl: json['display_url'],
        width: json['width'],
        height: json['height'],
        size: json['size'],
        time: json['time'],
        expiration: json['expiration'],
        image:
            json['image'] != null ? ImageModel.fromJson(json['image']) : null,
        thumb:
            json['thumb'] != null ? ImageModel.fromJson(json['thumb']) : null,
        medium:
            json['medium'] != null ? ImageModel.fromJson(json['medium']) : null,
        deleteUrl: json['delete_url'],
      );
  String id;
  String title;
  String urlViewer;
  String url;
  String displayUrl;
  int width;
  int height;
  int size;
  int time;
  int expiration;
  ImageModel? image;
  ImageModel? thumb;
  ImageModel? medium;
  String deleteUrl;
}

class ImageModel {
  ImageModel({
    required this.filename,
    required this.name,
    required this.mime,
    required this.extension,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      filename: json['filename'],
      name: json['name'],
      mime: json['mime'],
      extension: json['extension'],
      url: json['url'],
    );
  }
  String filename;
  String name;
  String mime;
  String extension;
  String url;
}
