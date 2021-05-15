import 'package:firebase_storage/firebase_storage.dart';

class ImageModel {
  String _url;
  String _thumbUrl;
  String _downloadUrl;

  ImageModel(path, downloadUrl) {
    this._url = path;
    this._thumbUrl = 'thumb_' + path;
    this._downloadUrl = downloadUrl;
  }

  String getUrl() => this._downloadUrl;

  Future<void> downloadImage() {

  }

  Future<void> downloadThumb() {

  }
}